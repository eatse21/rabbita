///|
pub enum Attribute {
  Attribute(String, String)
  Property(String, @variant.Variant)
  Style(String, String)
  Handler(String, (@dom.Event, &@runtime.Scheduler) -> Unit)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/style)
/// Specify a style declaration.
pub fn style(key : String, value : String) -> Attribute {
  Style(key, value)
}

///|
pub fn attribute(key : String, value : String) -> Attribute {
  Attribute(key, value)
}

///|
pub fn property(key : String, value : @variant.Variant) -> Attribute {
  Property(key, value)
}

///|
pub fn handler(
  key : String,
  value : (@dom.Event, &@runtime.Scheduler) -> Unit,
) -> Attribute {
  Handler(key, value)
}

///|
pub(all) enum Target {
  Self
  Blank
}

///|
fn Target::to_string(self : Target) -> String {
  match self {
    Self => "_self"
    Blank => "_blank"
  }
}

///|
pub(all) enum AutoComplete {
  On
  Off
}

///|
pub(all) enum Scope {
  Row
  Col
  RowGroup
  ColGroup
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/accept)
pub fn accept(value : String) -> Attribute {
  attribute("accept", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/accept-charset)
pub fn accept_charset(value : String) -> Attribute {
  attribute("accept-charset", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/accesskey)
pub fn accesskey(value : String) -> Attribute {
  attribute("accesskey", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/action)
pub fn action(value : String) -> Attribute {
  attribute("action", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/align)
pub fn align(value : String) -> Attribute {
  attribute("align", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/allow)
pub fn allow(value : String) -> Attribute {
  attribute("allow", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/alpha)
pub fn alpha(value : String) -> Attribute {
  attribute("alpha", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/alt)
pub fn alt(value : String) -> Attribute {
  attribute("alt", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/as)
pub fn as_(value : String) -> Attribute {
  attribute("as", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/async)
pub fn async_(value : Bool) -> Attribute {
  property("async", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/autocapitalize)
pub fn autocapitalize(value : String) -> Attribute {
  attribute("autocapitalize", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/autocomplete)
pub fn autocomplete(value : AutoComplete) -> Attribute {
  let s = match value {
    On => "on"
    Off => "off"
  }
  attribute("autocomplete", s)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/autoplay)
pub fn autoplay(value : Bool) -> Attribute {
  property("autoplay", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/background)
pub fn background(value : String) -> Attribute {
  attribute("background", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/bgcolor)
pub fn bgcolor(value : String) -> Attribute {
  attribute("bgcolor", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/border)
pub fn border(value : Int) -> Attribute {
  attribute("border", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/capture)
pub fn capture(value : String) -> Attribute {
  attribute("capture", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/charset)
pub fn charset(value : String) -> Attribute {
  attribute("charset", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/checked)
pub fn checked(value : Bool) -> Attribute {
  property("checked", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/cite)
pub fn cite(value : String) -> Attribute {
  attribute("cite", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/class)
pub fn class(value : String) -> Attribute {
  attribute("class", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/color)
pub fn color(value : String) -> Attribute {
  attribute("color", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/colorspace)
pub fn colorspace(value : String) -> Attribute {
  attribute("colorspace", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/cols)
pub fn cols(value : Int) -> Attribute {
  attribute("cols", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/colspan)
pub fn colspan(value : Int) -> Attribute {
  attribute("colspan", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/content)
pub fn content(value : String) -> Attribute {
  attribute("content", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/contenteditable)
pub fn contenteditable(value : String) -> Attribute {
  attribute("contenteditable", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/controls)
pub fn controls(value : Bool) -> Attribute {
  property("controls", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/coords)
pub fn coords(value : String) -> Attribute {
  attribute("coords", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/crossorigin)
pub fn crossorigin(value : String) -> Attribute {
  attribute("crossorigin", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/csp)
pub fn csp(value : String) -> Attribute {
  attribute("csp", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/data)
pub fn data(value : String) -> Attribute {
  attribute("data", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/data-*)
pub fn data_set(name : String, value : String) -> Attribute {
  attribute("data-" + name, value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/datetime)
pub fn datetime(value : String) -> Attribute {
  attribute("datetime", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/decoding)
pub fn decoding(value : String) -> Attribute {
  attribute("decoding", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/default)
pub fn default(value : Bool) -> Attribute {
  property("default", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/defer)
pub fn defer_(value : Bool) -> Attribute {
  property("defer", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/dir)
pub fn dir(value : String) -> Attribute {
  attribute("dir", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/dirname)
pub fn dirname(value : String) -> Attribute {
  attribute("dirname", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/disabled)
pub fn disabled(value : Bool) -> Attribute {
  property("disabled", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/download)
pub fn download(value : String) -> Attribute {
  attribute("download", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/draggable)
pub fn draggable(value : String) -> Attribute {
  attribute("draggable", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/enctype)
pub fn enctype(value : String) -> Attribute {
  attribute("enctype", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/enterkeyhint)
pub fn enterkeyhint(value : String) -> Attribute {
  attribute("enterkeyhint", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/elementtiming)
pub fn elementtiming(value : String) -> Attribute {
  attribute("elementtiming", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/fetchpriority)
pub fn fetchpriority(value : String) -> Attribute {
  attribute("fetchpriority", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/for)
pub fn for_(value : String) -> Attribute {
  attribute("for", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/form)
pub fn form(value : String) -> Attribute {
  attribute("form", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/formaction)
pub fn formaction(value : String) -> Attribute {
  attribute("formaction", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/formenctype)
pub fn formenctype(value : String) -> Attribute {
  attribute("formenctype", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/formmethod)
pub fn formmethod(value : String) -> Attribute {
  attribute("formmethod", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/formnovalidate)
pub fn formnovalidate(value : Bool) -> Attribute {
  property("formnovalidate", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/formtarget)
pub fn formtarget(value : String) -> Attribute {
  attribute("formtarget", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/headers)
pub fn headers(value : String) -> Attribute {
  attribute("headers", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/height)
pub fn height(value : Int) -> Attribute {
  attribute("height", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/hidden)
pub fn hidden(value : Bool) -> Attribute {
  property("hidden", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/high)
pub fn high(value : Int) -> Attribute {
  attribute("high", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/href)
pub fn href(value : String) -> Attribute {
  property("href", @variant.String(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/hreflang)
pub fn hreflang(value : String) -> Attribute {
  attribute("hreflang", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/http-equiv)
pub fn http_equiv(value : String) -> Attribute {
  attribute("http-equiv", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/id)
pub fn id(value : String) -> Attribute {
  attribute("id", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/integrity)
pub fn integrity(value : String) -> Attribute {
  attribute("integrity", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/inputmode)
pub fn inputmode(value : String) -> Attribute {
  attribute("inputmode", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/ismap)
pub fn ismap(value : Bool) -> Attribute {
  property("ismap", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/itemprop)
pub fn itemprop(value : String) -> Attribute {
  attribute("itemprop", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/kind)
pub fn kind(value : String) -> Attribute {
  attribute("kind", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/label)
pub fn label(value : String) -> Attribute {
  attribute("label", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/lang)
pub fn lang(value : String) -> Attribute {
  attribute("lang", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/language)
pub fn language(value : String) -> Attribute {
  attribute("language", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/loading)
pub fn loading(value : String) -> Attribute {
  attribute("loading", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/list)
pub fn list(value : String) -> Attribute {
  attribute("list", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/loop)
pub fn loop_(value : Bool) -> Attribute {
  property("loop", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/low)
pub fn low(value : Int) -> Attribute {
  attribute("low", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/max)
pub fn max(value : Int) -> Attribute {
  attribute("max", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/maxlength)
pub fn maxlength(value : Int) -> Attribute {
  attribute("maxlength", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/media)
pub fn media(value : String) -> Attribute {
  attribute("media", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/method)
pub fn method_(value : String) -> Attribute {
  attribute("method", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/min)
pub fn min(value : Int) -> Attribute {
  attribute("min", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/minlength)
pub fn minlength(value : Int) -> Attribute {
  attribute("minlength", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/multiple)
pub fn multiple(value : Bool) -> Attribute {
  property("multiple", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/muted)
pub fn muted(value : Bool) -> Attribute {
  property("muted", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/name)
pub fn name(value : String) -> Attribute {
  attribute("name", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/novalidate)
pub fn novalidate(value : Bool) -> Attribute {
  property("novalidate", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/open)
pub fn open(value : Bool) -> Attribute {
  property("open", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/optimum)
pub fn optimum(value : Int) -> Attribute {
  attribute("optimum", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/pattern)
pub fn pattern(value : String) -> Attribute {
  attribute("pattern", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/ping)
pub fn ping(value : String) -> Attribute {
  attribute("ping", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/placeholder)
pub fn placeholder(value : String) -> Attribute {
  attribute("placeholder", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/playsinline)
pub fn playsinline(value : Bool) -> Attribute {
  property("playsinline", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/poster)
pub fn poster(value : String) -> Attribute {
  attribute("poster", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/preload)
pub fn preload(value : String) -> Attribute {
  attribute("preload", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/readonly)
pub fn readonly_(value : Bool) -> Attribute {
  property("readonly", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/referrerpolicy)
pub fn referrerpolicy(value : String) -> Attribute {
  attribute("referrerpolicy", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/rel)
pub fn rel(value : String) -> Attribute {
  attribute("rel", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/required)
pub fn required(value : Bool) -> Attribute {
  property("required", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/reversed)
pub fn reversed(value : Bool) -> Attribute {
  property("reversed", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/role)
pub fn role(value : String) -> Attribute {
  attribute("role", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/rows)
pub fn rows(value : Int) -> Attribute {
  attribute("rows", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/rowspan)
pub fn rowspan(value : Int) -> Attribute {
  attribute("rowspan", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/sandbox)
pub fn sandbox(value : String) -> Attribute {
  attribute("sandbox", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/scope)
pub fn scope(value : Scope) -> Attribute {
  let s = match value {
    Row => "row"
    Col => "col"
    RowGroup => "rowgroup"
    ColGroup => "colgroup"
  }
  attribute("scope", s)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/selected)
pub fn selected(value : Bool) -> Attribute {
  property("selected", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/shape)
pub fn shape(value : String) -> Attribute {
  attribute("shape", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/size)
pub fn size(value : Int) -> Attribute {
  attribute("size", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/sizes)
pub fn sizes(value : String) -> Attribute {
  attribute("sizes", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/slot)
pub fn slot(value : String) -> Attribute {
  attribute("slot", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/span)
pub fn span(value : Int) -> Attribute {
  attribute("span", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/spellcheck)
pub fn spellcheck(value : Bool) -> Attribute {
  property("spellcheck", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/src)
pub fn src(value : String) -> Attribute {
  attribute("src", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/srcdoc)
pub fn srcdoc(value : String) -> Attribute {
  attribute("srcdoc", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/srclang)
pub fn srclang(value : String) -> Attribute {
  attribute("srclang", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/srcset)
pub fn srcset(value : String) -> Attribute {
  attribute("srcset", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/start)
pub fn start(value : Int) -> Attribute {
  attribute("start", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/step)
pub fn step(value : Int) -> Attribute {
  attribute("step", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/style)
pub fn style_attr(value : String) -> Attribute {
  attribute("style", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/summary)
pub fn summary(value : String) -> Attribute {
  attribute("summary", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/tabindex)
pub fn tabindex(value : Int) -> Attribute {
  attribute("tabindex", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/target)
pub fn target(value : Target) -> Attribute {
  attribute("target", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/title)
pub fn title(value : String) -> Attribute {
  attribute("title", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/translate)
pub fn translate(value : String) -> Attribute {
  attribute("translate", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/type)
pub fn type_(value : String) -> Attribute {
  attribute("type", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/usemap)
pub fn usemap(value : String) -> Attribute {
  attribute("usemap", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/value)
pub fn value(value : String) -> Attribute {
  attribute("value", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/width)
pub fn width(value : Int) -> Attribute {
  attribute("width", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/wrap)
pub fn wrap(value : String) -> Attribute {
  attribute("wrap", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/abbr)
pub fn abbr(value : String) -> Attribute {
  attribute("abbr", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/anchor)
pub fn anchor(value : String) -> Attribute {
  attribute("anchor", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/autocorrect)
pub fn autocorrect(value : String) -> Attribute {
  attribute("autocorrect", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/autofocus)
pub fn autofocus(value : Bool) -> Attribute {
  property("autofocus", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/exportparts)
pub fn exportparts(value : String) -> Attribute {
  attribute("exportparts", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/inert)
pub fn inert(value : Bool) -> Attribute {
  property("inert", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/is)
pub fn is_(value : String) -> Attribute {
  attribute("is", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/itemid)
pub fn itemid(value : String) -> Attribute {
  attribute("itemid", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/itemref)
pub fn itemref(value : String) -> Attribute {
  attribute("itemref", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/itemscope)
pub fn itemscope(value : Bool) -> Attribute {
  property("itemscope", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/itemtype)
pub fn itemtype(value : String) -> Attribute {
  attribute("itemtype", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/nonce)
pub fn nonce(value : String) -> Attribute {
  attribute("nonce", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/part)
pub fn part(value : String) -> Attribute {
  attribute("part", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/popover)
pub fn popover(value : String) -> Attribute {
  attribute("popover", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/allowfullscreen)
pub fn allowfullscreen(value : Bool) -> Attribute {
  property("allowfullscreen", @variant.Boolean(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/value)
pub fn value_int(value : Int) -> Attribute {
  attribute("value", value.to_string())
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/value)
pub fn value_prop(value : String) -> Attribute {
  property("value", @variant.String(value))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-activedescendant)
pub fn aria_activedescendant(value : String) -> Attribute {
  attribute("aria-activedescendant", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-atomic)
pub fn aria_atomic(value : String) -> Attribute {
  attribute("aria-atomic", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-autocomplete)
pub fn aria_autocomplete(value : String) -> Attribute {
  attribute("aria-autocomplete", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-braillelabel)
pub fn aria_braillelabel(value : String) -> Attribute {
  attribute("aria-braillelabel", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-brailleroledescription)
pub fn aria_brailleroledescription(value : String) -> Attribute {
  attribute("aria-brailleroledescription", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-busy)
pub fn aria_busy(value : String) -> Attribute {
  attribute("aria-busy", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-checked)
pub fn aria_checked(value : String) -> Attribute {
  attribute("aria-checked", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colcount)
pub fn aria_colcount(value : String) -> Attribute {
  attribute("aria-colcount", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colindex)
pub fn aria_colindex(value : String) -> Attribute {
  attribute("aria-colindex", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colindextext)
pub fn aria_colindextext(value : String) -> Attribute {
  attribute("aria-colindextext", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colspan)
pub fn aria_colspan(value : String) -> Attribute {
  attribute("aria-colspan", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-controls)
pub fn aria_controls(value : String) -> Attribute {
  attribute("aria-controls", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-current)
pub fn aria_current(value : String) -> Attribute {
  attribute("aria-current", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-describedby)
pub fn aria_describedby(value : String) -> Attribute {
  attribute("aria-describedby", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-description)
pub fn aria_description(value : String) -> Attribute {
  attribute("aria-description", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-details)
pub fn aria_details(value : String) -> Attribute {
  attribute("aria-details", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-disabled)
pub fn aria_disabled(value : String) -> Attribute {
  attribute("aria-disabled", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-dropeffect)
pub fn aria_dropeffect(value : String) -> Attribute {
  attribute("aria-dropeffect", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-errormessage)
pub fn aria_errormessage(value : String) -> Attribute {
  attribute("aria-errormessage", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-expanded)
pub fn aria_expanded(value : String) -> Attribute {
  attribute("aria-expanded", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-flowto)
pub fn aria_flowto(value : String) -> Attribute {
  attribute("aria-flowto", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-grabbed)
pub fn aria_grabbed(value : String) -> Attribute {
  attribute("aria-grabbed", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-haspopup)
pub fn aria_haspopup(value : String) -> Attribute {
  attribute("aria-haspopup", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-hidden)
pub fn aria_hidden(value : String) -> Attribute {
  attribute("aria-hidden", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-invalid)
pub fn aria_invalid(value : String) -> Attribute {
  attribute("aria-invalid", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-keyshortcuts)
pub fn aria_keyshortcuts(value : String) -> Attribute {
  attribute("aria-keyshortcuts", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-label)
pub fn aria_label(value : String) -> Attribute {
  attribute("aria-label", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-labelledby)
pub fn aria_labelledby(value : String) -> Attribute {
  attribute("aria-labelledby", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-level)
pub fn aria_level(value : String) -> Attribute {
  attribute("aria-level", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-live)
pub fn aria_live(value : String) -> Attribute {
  attribute("aria-live", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-modal)
pub fn aria_modal(value : String) -> Attribute {
  attribute("aria-modal", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-multiline)
pub fn aria_multiline(value : String) -> Attribute {
  attribute("aria-multiline", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-multiselectable)
pub fn aria_multiselectable(value : String) -> Attribute {
  attribute("aria-multiselectable", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-orientation)
pub fn aria_orientation(value : String) -> Attribute {
  attribute("aria-orientation", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-owns)
pub fn aria_owns(value : String) -> Attribute {
  attribute("aria-owns", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-placeholder)
pub fn aria_placeholder(value : String) -> Attribute {
  attribute("aria-placeholder", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-posinset)
pub fn aria_posinset(value : String) -> Attribute {
  attribute("aria-posinset", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-pressed)
pub fn aria_pressed(value : String) -> Attribute {
  attribute("aria-pressed", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-readonly)
pub fn aria_readonly(value : String) -> Attribute {
  attribute("aria-readonly", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-relevant)
pub fn aria_relevant(value : String) -> Attribute {
  attribute("aria-relevant", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-required)
pub fn aria_required(value : String) -> Attribute {
  attribute("aria-required", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-roledescription)
pub fn aria_roledescription(value : String) -> Attribute {
  attribute("aria-roledescription", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowcount)
pub fn aria_rowcount(value : String) -> Attribute {
  attribute("aria-rowcount", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowindex)
pub fn aria_rowindex(value : String) -> Attribute {
  attribute("aria-rowindex", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowindextext)
pub fn aria_rowindextext(value : String) -> Attribute {
  attribute("aria-rowindextext", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowspan)
pub fn aria_rowspan(value : String) -> Attribute {
  attribute("aria-rowspan", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-selected)
pub fn aria_selected(value : String) -> Attribute {
  attribute("aria-selected", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-setsize)
pub fn aria_setsize(value : String) -> Attribute {
  attribute("aria-setsize", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-sort)
pub fn aria_sort(value : String) -> Attribute {
  attribute("aria-sort", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuemax)
pub fn aria_valuemax(value : String) -> Attribute {
  attribute("aria-valuemax", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuemin)
pub fn aria_valuemin(value : String) -> Attribute {
  attribute("aria-valuemin", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuenow)
pub fn aria_valuenow(value : String) -> Attribute {
  attribute("aria-valuenow", value)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuetext)
pub fn aria_valuetext(value : String) -> Attribute {
  attribute("aria-valuetext", value)
}
