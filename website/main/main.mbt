///|
using @html {
  a, button, div, footer, h1, h2, h3, header, img, main_, nav, nothing, p,
  pre, code, section, span, text,
}

///|
using @rabbita { type Dispatch, type Html, type Cmd, batch }

///|
enum Theme {
  System
  Light
  Dark
}

///|
enum Msg {
  ToggleMenu
  CycleTheme
  SelectTab(Int)
  SelectCmpIdx(Int)
  NextCmpIdx
  CopiedStep(Int)
  ClearCopied
  LoadResult(Result[@shiki.Highlighter, Error])
}

///|
struct Model {
  menu_open : Bool
  theme : Theme
  hero_tab : Int
  cmp_idx : Int
  cmp_anim : Bool
  copied_step : Int?
  highlighter : @shiki.Highlighter?
}

///|
fn update(dispatch : Dispatch[Msg], msg : Msg, model : Model) -> (Cmd, Model) {
  match msg {
    ToggleMenu => (@rabbita.none, { ..model, menu_open: not(model.menu_open) })
    CycleTheme =>
      (
        @rabbita.none,
        {
          ..model,
          theme: match model.theme {
            System => Dark
            Dark => Light
            Light => System
          },
        },
      )
    SelectTab(t) => (@rabbita.none, { ..model, hero_tab: t })
    SelectCmpIdx(i) =>
      (
        @rabbita.none,
        { ..model, cmp_idx: i, cmp_anim: not(model.cmp_anim) },
      )
    NextCmpIdx =>
      (
        @rabbita.delay(dispatch(NextCmpIdx), 12000),
        {
          ..model,
          cmp_anim: not(model.cmp_anim),
          cmp_idx: (model.cmp_idx + 1) % cmp_entries.length(),
        },
      )
    CopiedStep(i) =>
      (
        @rabbita.delay(dispatch(ClearCopied), 1500),
        { ..model, copied_step: Some(i) },
      )
    ClearCopied => (@rabbita.none, { ..model, copied_step: None })
    LoadResult(Ok(hl)) => (@rabbita.none, { ..model, highlighter: Some(hl) })
    LoadResult(Err(_)) => (@rabbita.none, model)
  }
}

///|
let github_url : String = "https://github.com/moonbit-community/rabbita"

///|
let docs_url : String = "https://mooncakes.io/docs/moonbit-community/rabbita/"

///|
let template_url : String =
  "https://github.com/moonbit-community/rabbita-template"

///|
let code_counter : String =
  #|fn main {
  #|  enum Msg {
  #|    Click
  #|  }
  #|  let app = @rabbita.simple_cell(
  #|    model={ count: 0 },
  #|    update=(msg, count) => {
  #|      match msg {
  #|        Click => count + 1
  #|      }
  #|    },
  #|    view=(dispatch, count) => {
  #|      button(on_click=dispatch(Click), "You clicked \{count} times")
  #|    },
  #|  )
  #|  new(app).mount("app")
  #|}

///|
let code_ssr : String =
  #|test "render html to string" {
  #|  enum Msg {}
  #|  struct Model {
  #|    todos : Array[String]
  #|  }
  #|  let page = @rabbita.simple_cell(
  #|    model={ todos: ["todo1", "todo2"] },
  #|    update=(_ : Msg, model) => model,
  #|    view=(_, model) => ul(model.todos.map(x => li(x))),
  #|  )
  #|  inspect(
  #|    @rabbita.render_to_string(page),
  #|    content=(
  #|      #|<ul><li>todo1</li><li>todo2</li></ul>
  #|    ),
  #|  )
  #|}

// ─── Comparison code samples ──────────────────────────────────────────────

///|
let cmp_js_match : String =
  #|function getLabel(status) {
  #|  if (status === 'active') {
  #|    return 'Active';
  #|  } else if (status === 'pending') {
  #|    return 'Pending';
  #|  } else {
  #|    return 'Unknown';
  #|  }
  #|}

///|
let cmp_mb_match : String =
  #|fn get_label(status : Status) -> String {
  #|  match status {
  #|    Active  => "Active"
  #|    Pending => "Pending"
  #|  }
  #|}

///|
let cmp_js_expr : String =
  #|const label = (() => {
  #|  if (isLoggedIn) {
  #|    return 'Welcome back!';
  #|  } else {
  #|    return 'Please sign in.';
  #|  }
  #|})()

///|
let cmp_mb_expr : String =
  #|let label = if is_logged_in {
  #|  "Welcome back!"
  #|} else {
  #|  "Please sign in."
  #|}

///|
let cmp_js_update : String =
  #|const next = {
  #|  ...model,
  #|  count: model.count + 1,
  #|}

///|
let cmp_mb_update : String =
  #|let next = {
  #|  ..model,
  #|  count: model.count + 1,
  #|}

///|
struct CmpEntry {
  label  : String
  desc   : String
  js_src : String
  mb_src : String
}

///|
let cmp_entries : Array[CmpEntry] = [
  {
    label:  "Pattern matching",
    desc:   "Exhaustive by default. No fallthrough, no forgotten cases.",
    js_src: cmp_js_match,
    mb_src: cmp_mb_match,
  },
  {
    label:  "if / match as expressions",
    desc:   "Control flow returns values directly. No IIFE wrappers, no ternary pyramids.",
    js_src: cmp_js_expr,
    mb_src: cmp_mb_expr,
  },
  {
    label:  "Record update",
    desc:   "Pure, concise, type-checked. Only the fields you change.",
    js_src: cmp_js_update,
    mb_src: cmp_mb_update,
  },
]

// ─── Feature Icons ────────────────────────────────────────────────────────

///| Arrow with source dot — represents a single-direction flow
fn icon_flow() -> Html {
  @svg.svg(view_box="0 0 24 24", width=24, height=24, class="feat-icon", [
    @svg.circle(cx=4, cy=12, r=2, fill="currentColor"),
    @svg.path(
      d="M 8 12 L 20 12 M 15 7 L 20 12 L 15 17",
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
  ])
}

///| Shield with checkmark — represents type safety
fn icon_shield() -> Html {
  @svg.svg(view_box="0 0 24 24", width=24, height=24, class="feat-icon", [
    @svg.path(
      d="M 12 3 L 4 7 V 12 C 4 17 8 21 12 22 C 16 21 20 17 20 12 V 7 Z",
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
    @svg.path(
      d="M 9 12 L 11 14 L 15 10",
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
  ])
}

///| Stacked layers — represents modular, composable cells
fn icon_layers() -> Html {
  @svg.svg(view_box="0 0 24 24", width=24, height=24, class="feat-icon", [
    @svg.path(
      d="M 12 2 L 2 7 L 12 12 L 22 7 Z",
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
    @svg.path(
      d="M 2 12 L 12 17 L 22 12",
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
    @svg.path(
      d="M 2 17 L 12 22 L 22 17",
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
  ])
}

///| Package box — represents small bundle size
fn icon_box() -> Html {
  @svg.svg(view_box="0 0 24 24", width=24, height=24, class="feat-icon", [
    @svg.path(
      d="M 5 8 L 12 4 L 19 8 L 19 16 L 12 20 L 5 16 Z",
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
    @svg.path(
      d="M 5 8 L 12 12 L 19 8",
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
    @svg.line(x1=12, y1=12, x2=12, y2=20, stroke="currentColor", stroke_width=2),
  ])
}

// ─── Theme Toggle Icons ───────────────────────────────────────────────────

///| Sun — shown when theme is Light
fn icon_sun() -> Html {
  @svg.svg(view_box="0 0 24 24", width=20, height=20, class="theme-icon", [
    @svg.circle(
      cx=12,
      cy=12,
      r=4,
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
    @svg.path(
      d="M 12 2 V 5 M 12 19 V 22 M 4.22 4.22 L 6.34 6.34 M 17.66 17.66 L 19.78 19.78 M 2 12 H 5 M 19 12 H 22 M 4.22 19.78 L 6.34 17.66 M 17.66 6.34 L 19.78 4.22",
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
  ])
}

///| Crescent moon — shown when theme is Dark
fn icon_moon() -> Html {
  @svg.svg(view_box="0 0 24 24", width=20, height=20, class="theme-icon", [
    @svg.path(
      d="M 21 12.79 A 9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79 Z",
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
  ])
}

///| Half-filled circle — left half filled (dark), right half empty (light)
fn icon_auto() -> Html {
  @svg.svg(view_box="0 0 24 24", width=20, height=20, class="theme-icon", [
    @svg.circle(
      cx=12,
      cy=12,
      r=9,
      fill="none",
      stroke="currentColor",
      stroke_width=2,
    ),
    @svg.path(d="M 12 3 A 9 9 0 0 0 12 21 Z", fill="currentColor"),
  ])
}

///|
fn theme_icon(theme : Theme) -> Html {
  match theme {
    System => icon_auto()
    Light => icon_sun()
    Dark => icon_moon()
  }
}

// ─── Navigation ───────────────────────────────────────────────────────────

///|
fn hamburger(is_open : Bool) -> Html {
  div(
    class=if is_open { "hamburger is-open" } else { "hamburger" },
    [
      div(class="bar", nothing),
      div(class="bar", nothing),
      div(class="bar", nothing),
    ],
  )
}

///|
fn view_nav(dispatch : Dispatch[Msg], model : Model) -> Html {
  header(class="site-header", [
    nav(class="navbar", [
      a(class="nav-logo", href=github_url, "Rabbita"),
      div(class="nav-links", [
        a(href=docs_url, target=Blank, class="nav-link", "Docs"),
        a(href="#", class="nav-link", "Tutorial"),
        a(href=github_url, target=Blank, class="nav-link", "GitHub"),
      ]),
      div(class="nav-actions", [
        button(class="theme-toggle", on_click=dispatch(CycleTheme), [
          theme_icon(model.theme),
        ]),
        button(class="nav-toggle", on_click=dispatch(ToggleMenu), [
          hamburger(model.menu_open),
        ]),
      ]),
    ]),
    if model.menu_open {
      div(class="mobile-menu", [
        a(href=docs_url, target=Blank, class="mobile-link", "Docs"),
        a(href="#", class="mobile-link", "Tutorial"),
        a(href=github_url, target=Blank, class="mobile-link", "GitHub"),
      ])
    } else {
      nothing
    },
  ])
}

// ─── Hero ─────────────────────────────────────────────────────────────────

///|
struct HeroTabEntry {
  label : String
  src   : String
}

///|
let hero_tabs : Array[HeroTabEntry] = [
  { label: "Counter", src: code_counter },
  { label: "SSR",     src: code_ssr     },
]

///|
fn view_hero(dispatch : Dispatch[Msg], model : Model) -> Html {
  let src = hero_tabs[model.hero_tab].src
  let code_block = match model.highlighter {
    Some(hl) =>
      div(class="code-dual", [
        div(class="code-light", [
          hl.code_to_html(src, lang="moonbit", theme="github-light"),
        ]),
        div(class="code-dark", [
          hl.code_to_html(src, lang="moonbit", theme="github-dark-default"),
        ]),
      ])
    None => pre(class="code-block", [code(src)])
  }
  section(class="hero", [
    div(class="hero-grid", [
      div(class="hero-left", [
        h1(class="hero-title", [
          span(class="hero-accent", "Confidence"),
          text(" at every scale."),
        ]),
        p(
          class="hero-desc",
          "A web UI framework for MoonBit. Declarative, typed, and functional.",
        ),
        div(class="hero-actions", [
          a(class="btn-primary", href=template_url, target=Blank, "Get Started"),
          a(class="btn-secondary", href=github_url, target=Blank, "GitHub"),
        ]),
      ]),
      div(class="hero-right", [
        div(
          class="hero-tabs",
          hero_tabs.mapi(fn(i, t) {
            let cls = if i == model.hero_tab {
              "hero-tab hero-tab--active"
            } else {
              "hero-tab"
            }
            button(class=cls, on_click=dispatch(SelectTab(i)), t.label)
          }),
        ),
        div(class="hero-code", [code_block]),
      ]),
    ]),
  ])
}

// ─── Features ─────────────────────────────────────────────────────────────

///|
fn feature_card(icon : Html, title : String, desc : String) -> Html {
  div(class="feature-card", [
    div(class="feature-icon", [icon]),
    h3(class="feature-title", title),
    p(class="feature-desc", desc),
  ])
}

///|
fn view_features() -> Html {
  section(class="features", [
    div(class="features-inner", [
      h2(class="section-title", "Why Rabbita?"),
      div(class="features-grid", [
        feature_card(
          icon_flow(),
          "Predictable",
          "Single, explicit update path for state changes. Side effects are managed through Cmd types.",
        ),
        feature_card(
          icon_shield(),
          "Strict Types",
          "Descriptive APIs with no Any sprawl, no stringly-typed values. Leverage the full power of MoonBit's type system.",
        ),
        feature_card(
          icon_layers(),
          "Modular",
          "Split your app into reusable Cells. Only dirty cells trigger re-renders. Cell lifecycle is explicit.",
        ),
        feature_card(
          icon_box(),
          "Tiny Footprint",
          "~15 KB min+gzip including streaming VDOM diff and the MoonBit stdlib with aggressive dead-code elimination.",
        ),
      ]),
    ]),
  ])
}

// ─── Comparison ───────────────────────────────────────────────────────────

///|
fn dual_block(hl : @shiki.Highlighter, src : String, lang : String) -> Html {
  div(class="code-dual", [
    div(class="code-light", [
      hl.code_to_html(src, lang=lang, theme="github-light"),
    ]),
    div(class="code-dark", [
      hl.code_to_html(src, lang=lang, theme="github-dark-default"),
    ]),
  ])
}

///|
fn cmp_card(
  hl : @shiki.Highlighter?,
  js_src : String,
  mb_src : String
) -> Html {
  let js_block = match hl {
    Some(h) => dual_block(h, js_src, "javascript")
    None => pre(class="code-block", [code(js_src)])
  }
  let mb_block = match hl {
    Some(h) => dual_block(h, mb_src, "moonbit")
    None => pre(class="code-block", [code(mb_src)])
  }
  div(class="cmp-card", [
    div(class="cmp-cols", [
      div(class="cmp-col", [
        div(class="cmp-lang-label", "JavaScript"),
        js_block,
      ]),
      div(class="cmp-col", [
        div(class="cmp-lang-label", "MoonBit"),
        mb_block,
      ]),
    ]),
    div(class="cmp-progress-track", [
      div(class="cmp-progress-fill", nothing),
    ]),
  ])
}

///|
fn view_comparison(dispatch : Dispatch[Msg], model : Model) -> Html {
  let entry = cmp_entries[model.cmp_idx]
  let card = cmp_card(model.highlighter, entry.js_src, entry.mb_src)
  section(class="comparison", [
    div(class="comparison-inner", [
      h2(class="section-title", "MoonBit feels right"),
      div(class="cmp-widget", [
        div(
          class="cmp-tabs",
          cmp_entries.mapi(fn(i, e) {
            let cls = if i == model.cmp_idx {
              "cmp-tab cmp-tab--active"
            } else {
              "cmp-tab"
            }
            button(class=cls, on_click=dispatch(SelectCmpIdx(i)), e.label)
          }),
        ),
        div(
          class=if model.cmp_anim { "cmp-anim-wrap anim-a" } else { "cmp-anim-wrap anim-b" },
          [card],
        ),
        p(class="cmp-nav-desc", entry.desc),
      ]),
    ]),
  ])
}

// ─── Showcase ─────────────────────────────────────────────────────────────

///|
fn showcase_card(
  url : String,
  img_src : String,
  title : String,
  desc : String
) -> Html {
  a(
    class="showcase-card",
    href=url,
    target=Blank,
    [
      div(class="showcase-thumb", [
        img(class="showcase-thumb-img", src=img_src, alt=title, nothing),
      ]),
      div(class="showcase-info", [
        span(class="showcase-title", title),
        span(class="showcase-desc", desc),
      ]),
    ],
  )
}

///|
fn view_showcase() -> Html {
  section(class="showcase", [
    div(class="showcase-inner", [
      h2(class="section-title", "Built with Rabbita"),
      p(
        class="section-desc",
        "Real websites running in production on the MoonBit ecosystem.",
      ),
      div(class="showcase-grid", [
        showcase_card(
          github_url,
          "/rabbita.jpeg",
          "rabbita.dev",
          "The official Rabbita framework site — this page.",
        ),
        showcase_card(
          "https://mooncakes.io",
          "/mooncakesio.jpeg",
          "mooncakes.io",
          "The MoonBit package registry and documentation hub.",
        ),
        a(
          class="showcase-card showcase-card--submit",
          href=github_url + "/issues",
          target=Blank,
          [
            div(class="showcase-thumb showcase-thumb--submit", [
              div(class="showcase-thumb-placeholder", nothing),
              span(class="showcase-submit-plus", "+"),
            ]),
            div(class="showcase-info", [
              span(class="showcase-title", "Your project here"),
              span(class="showcase-desc", "Using Rabbita? Submit yours →"),
            ]),
          ],
        ),
      ]),
    ]),
  ])
}

// ─── Quick Start ──────────────────────────────────────────────────────────

///| Two overlapping rectangles — clipboard copy
fn icon_copy() -> Html {
  @svg.svg(view_box="0 0 24 24", width=15, height=15, class="qs-copy-icon", [
    @svg.rect(
      x=9, y=9, width=13, height=13, rx=2,
      fill="none", stroke="currentColor", stroke_width=2,
    ),
    @svg.path(
      d="M 5 15 H 4 C 3 15 2 14 2 13 V 4 C 2 3 3 2 4 2 H 13 C 14 2 15 3 15 4 V 5",
      fill="none", stroke="currentColor", stroke_width=2,
    ),
  ])
}

///| Checkmark — shown after successful copy
fn icon_check() -> Html {
  @svg.svg(view_box="0 0 24 24", width=15, height=15, class="qs-copy-icon", [
    @svg.path(
      d="M 5 12 L 10 17 L 19 7",
      fill="none", stroke="currentColor", stroke_width=2,
      attrs=@svg.Attrs::build().stroke_linecap("round").stroke_linejoin("round"),
    ),
  ])
}

///|
fn qs_step(
  dispatch : Dispatch[Msg],
  idx : Int,
  num : String,
  title : String,
  cmd : String,
  is_copied : Bool
) -> Html {
  div(class="qs-step", [
    div(class="qs-step-head", [
      span(class="qs-step-num", num),
      span(class="qs-step-title", title),
    ]),
    div(class="qs-step-code-wrap", [
      pre(class="install-block qs-step-code", [code(cmd)]),
      button(
        class=if is_copied { "qs-copy-btn qs-copy-btn--done" } else { "qs-copy-btn" },
        on_click=batch([
          @clipboard.copy(@clipboard.Text(cmd)),
          dispatch(CopiedStep(idx)),
        ]),
        [if is_copied { icon_check() } else { icon_copy() }],
      ),
    ]),
  ])
}

///|
fn view_quickstart(dispatch : Dispatch[Msg], model : Model) -> Html {
  let copied = model.copied_step
  section(class="quickstart", [
    div(class="quickstart-inner", [
      h2(class="section-title", "Quick Start"),
      p(
        class="section-desc",
        "From zero to a running app in three steps.",
      ),
      div(class="qs-steps", [
        qs_step(
          dispatch,
          0,
          "1",
          "Clone the template",
          "git clone " + template_url + " my-app\ncd my-app",
          copied == Some(0),
        ),
        qs_step(
          dispatch,
          1,
          "2",
          "Add Rabbita",
          "moon add moonbit-community/rabbita",
          copied == Some(1),
        ),
        qs_step(
          dispatch,
          2,
          "3",
          "Start the dev server",
          "npm i\nnpm run dev",
          copied == Some(2),
        ),
      ]),
      div(class="quickstart-cta", [
        a(class="btn-primary", href=docs_url, target=Blank, "Read the Docs"),
        a(
          class="btn-secondary",
          href=template_url,
          target=Blank,
          "Get Template",
        ),
      ]),
    ]),
  ])
}

// ─── Footer ───────────────────────────────────────────────────────────────

///|
fn view_footer() -> Html {
  footer(class="site-footer", [
    div(class="footer-inner", [
      span(class="footer-copy", "© 2025 moonbit-community · Apache 2.0"),
      div(class="footer-links", [
        a(href=github_url, target=Blank, class="footer-link", "GitHub"),
        a(href=docs_url, target=Blank, class="footer-link", "Docs"),
        a(
          href="https://www.moonbitlang.com/",
          target=Blank,
          class="footer-link",
          "MoonBit",
        ),
      ]),
    ]),
  ])
}

// ─── Root View ────────────────────────────────────────────────────────────

///|
fn view(dispatch : Dispatch[Msg], model : Model) -> Html {
  let site_class = match model.theme {
    System => "site"
    Light => "site light"
    Dark => "site dark"
  }
  div(class=site_class, [
    view_nav(dispatch, model),
    main_(class="site-main", [
      view_hero(dispatch, model),
      view_features(),
      view_comparison(dispatch, model),
      view_showcase(),
      view_quickstart(dispatch, model),
    ]),
    view_footer(),
  ])
}

///|
/// NOTE: This program is only available in the js backend,
/// see README.md to get started.
async fn main {
  let (dispatch, app) = @rabbita.cell_with_dispatch(
    model={ menu_open: false, theme: System, hero_tab: 0, cmp_idx: 0, cmp_anim: false, copied_step: None, highlighter: None },
    update~,
    view~,
  )
  @rabbita.new(app)
  ..with_init(
    batch([
      @shiki.load(
        ["moonbit", "javascript"],
        ["github-light", "github-dark-default"],
        x => dispatch(LoadResult(x)),
      ),
      @rabbita.delay(dispatch(NextCmpIdx), 12000),
    ]),
  )
  .mount("app")
}
