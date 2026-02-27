///|
extern "js" fn load_shiki() -> @js.Promise =
  #| (async () => {
  #|   const [
  #|     { createHighlighterCore },
  #|     { createJavaScriptRegexEngine },
  #|   ] = await Promise.all([
  #|     import('https://esm.sh/shiki@3.23.0/core'),
  #|     import('https://esm.sh/shiki@3.23.0/engine/javascript'),
  #|   ])
  #|
  #|   return createHighlighterCore({
  #|     langs: [],
  #|     themes: [],
  #|     engine: createJavaScriptRegexEngine(),
  #|   })
  #| })

///|
extern "js" fn load_langs(
  highlighter : @js.Value,
  langs : Array[String],
) -> @js.Promise =
  #| (hl, langs) =>
  #|   hl.loadLanguage(
  #|     ...langs.map(lang =>
  #|       import(/* @vite-ignore */ ('https://esm.sh/shiki@3.23.0/langs/' + lang))
  #|     )
  #|   )

///|
extern "js" fn load_themes(
  highlighter : @js.Value,
  themes : Array[String],
) -> @js.Promise =
  #| (hl, themes) =>
  #|   hl.loadTheme(
  #|     ...themes.map(theme =>
  #|       import(/* @vite-ignore */ ('https://esm.sh/shiki@3.23.0/themes/' + theme))
  #|     )
  #|   )

///|
extern "js" fn code_to_html(
  highlighter : @js.Value,
  code : String,
  lang : String,
  theme : String,
) -> String =
  #| (hl, code, lang, theme) => {
  #|   try {
  #|     return hl.codeToHtml(code, { lang, theme })
  #|   } catch (e) {
  #|     console.warn(`[shiki] highlight failed: lang=${lang}, theme=${theme}`, e)
  #|     return ""
  #|   }
  #| }

///|
using @rabbita {type Cmd}

///|
struct Highlighter(@js.Value)

///|
extern "js" fn is_highlighter(x : @js.Value) -> Bool =
  #| (x) => !!x
  #|   && typeof x.codeToHtml === 'function'
  #|   && typeof x.loadLanguage === 'function'
  #|   && typeof x.loadTheme === 'function'

///|
pub fn load(
  langs : Array[String],
  themes : Array[String],
  msg : (Result[Highlighter, Error]) -> Cmd,
) -> Cmd {
  @rabbita.attempt(msg, async fn() {
    let highlighter = load_shiki().wait()
    guard is_highlighter(highlighter) else {
      fail("shiki highlighter init failed: invalid object")
    }
    if !(langs is []) {
      try load_langs(highlighter, langs).wait() |> ignore catch {
        e => fail("shiki load langs failed: \{e}")
      }
    }
    if !(themes is []) {
      try load_themes(highlighter, themes).wait() |> ignore catch {
        e => fail("shiki load themes failed: \{e}")
      }
    }
    Highlighter(highlighter)
  })
}

///|
pub async fn Highlighter::add_theme(self : Self, theme : String) -> Unit {
  load_themes(self.0, [theme]).wait() |> ignore
}

///|
pub async fn Highlighter::add_lang(self : Self, lang : String) -> Unit {
  load_langs(self.0, [lang]).wait() |> ignore
}

///|
/// Render a code to html, with language and theme options.
#warnings("-alert_xss_vulnerable")
pub fn Highlighter::code_to_html(
  self : Self,
  code : String,
  lang~ : String,
  theme~ : String,
) -> @rabbita.Html {
  let str = code_to_html(self.0, code, lang, theme)
  @html.code(attrs=@html.Attrs::build().inner_html(str), @html.nothing)
}
