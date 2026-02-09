///|
fn push_style(style : Array[String], attrs : Array[Attribute]) -> Unit {
  if style.length() > 0 {
    attrs.push(attribute("style", style.join(";")))
  }
}

///|
fn push_id(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("id", v))
  }
}

///|
fn push_class(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("class", v))
  }
}

///|
fn push_click(value : Cmd?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(on_click(_ => v))
  }
}

///|
fn push_open(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("open", Boolean(v)))
  }
}

///|
fn push_datetime(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("datetime", v))
  }
}

///|
fn push_reversed(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("reversed", v.to_string()))
  }
}

///|
fn push_start(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("start", v.to_string()))
  }
}

///|
fn push_value_attr_int(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("value", v.to_string()))
  }
}

///|
fn push_value_attr_string(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("value", v))
  }
}

///|
fn push_value_prop_string(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("value", String(v)))
  }
}

///|
fn push_src(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("src", v))
  }
}

///|
fn push_alt(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("alt", v))
  }
}

///|
fn push_title(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("title", v))
  }
}

///|
fn push_width(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("width", v.to_string()))
  }
}

///|
fn push_height(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("height", v.to_string()))
  }
}

///|
fn push_action(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("action", v))
  }
}

///|
fn push_name(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("name", v))
  }
}

///|
fn push_for(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("for", v))
  }
}

///|
fn push_disabled(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("disabled", Boolean(v)))
  }
}

///|
fn push_label(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("label", v))
  }
}

///|
fn push_rows(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("rows", v.to_string()))
  }
}

///|
fn push_cols(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("cols", v.to_string()))
  }
}

///|
fn push_placeholder(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("placeholder", v))
  }
}

///|
fn push_readonly(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("readonly", Boolean(v)))
  }
}

///|
fn push_checked(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("checked", Boolean(v)))
  }
}

///|
fn push_multiple(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("multiple", Boolean(v)))
  }
}

///|
fn push_accept(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("accept", v))
  }
}

///|
fn push_max(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("max", v.to_string()))
  }
}

///|
fn push_min(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("min", v.to_string()))
  }
}

///|
fn push_step(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("step", v.to_string()))
  }
}

///|
fn push_maxlength(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("maxlength", v.to_string()))
  }
}

///|
fn push_minlength(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("minlength", v.to_string()))
  }
}

///|
fn push_pattern(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("pattern", v))
  }
}

///|
fn push_size(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("size", v.to_string()))
  }
}

///|
fn push_change(value : ((String) -> Cmd)?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(on_change(v))
  }
}

///|
fn push_input(value : ((String) -> Cmd)?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(on_input(v))
  }
}

///|
fn push_span(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("span", v.to_string()))
  }
}

///|
fn push_colspan(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("colspan", v.to_string()))
  }
}

///|
fn push_rowspan(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("rowspan", v.to_string()))
  }
}

///|
fn push_headers(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("headers", v))
  }
}

///|
fn push_abbr(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("abbr", v))
  }
}

///|
fn push_scope(value : Scope?, attrs : Array[Attribute]) -> Unit {
  if value is Some(scope) {
    let s = match scope {
      Row => "row"
      Col => "col"
      RowGroup => "rowgroup"
      ColGroup => "colgroup"
    }
    attrs.push(attribute("scope", s))
  }
}

///|
fn push_close(value : ((String) -> Cmd)?, attrs : Array[Attribute]) -> Unit {
  if value is Some(close) {
    attrs.push(
      Handler("close", (event, scheduler) => {
        let html_element = event.target().to_html_dialog_element().unwrap()
        scheduler.add(close(html_element.return_value()))
      }),
    )
  }
}

///|
fn push_cancel(value : Cmd?, attrs : Array[Attribute]) -> Unit {
  if value is Some(cancel) {
    attrs.push(
      Handler("cancel", (event, scheduler) => {
        event.prevent_default()
        scheduler.add(cancel)
      }),
    )
  }
}

///|
fn push_low(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("low", v.to_string()))
  }
}

///|
fn push_high(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("high", v.to_string()))
  }
}

///|
fn push_optimum(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("optimum", v.to_string()))
  }
}

///|
fn push_lang(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("lang", v))
  }
}

///|
fn push_dir(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("dir", v))
  }
}

///|
fn push_hidden(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("hidden", Boolean(v)))
  }
}

///|
fn push_rel(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("rel", v))
  }
}

///|
fn push_href(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("href", v))
  }
}

///|
fn push_target(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("target", v))
  }
}

///|
fn push_download(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("download", v))
  }
}

///|
fn push_media(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("media", v))
  }
}

///|
fn push_sizes(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("sizes", v))
  }
}

///|
fn push_charset(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("charset", v))
  }
}

///|
fn push_content(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("content", v))
  }
}

///|
fn push_http_equiv(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("http-equiv", v))
  }
}

///|
fn push_type(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("type", v))
  }
}

///|
fn push_async(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("async", Boolean(v)))
  }
}

///|
fn push_defer(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("defer", Boolean(v)))
  }
}

///|
fn push_required(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("required", Boolean(v)))
  }
}

///|
fn push_autofocus(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("autofocus", Boolean(v)))
  }
}

///|
fn push_list(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("list", v))
  }
}

///|
fn push_inputmode(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("inputmode", v))
  }
}

///|
fn push_wrap(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("wrap", v))
  }
}

///|
fn push_srcset(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("srcset", v))
  }
}

///|
fn push_loading(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("loading", v))
  }
}

///|
fn push_decoding(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("decoding", v))
  }
}

///|
fn push_controls(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("controls", Boolean(v)))
  }
}

///|
fn push_autoplay(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("autoplay", Boolean(v)))
  }
}

///|
fn push_loop(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("loop", Boolean(v)))
  }
}

///|
fn push_muted(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("muted", Boolean(v)))
  }
}

///|
fn push_preload(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("preload", v))
  }
}

///|
fn push_poster(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("poster", v))
  }
}

///|
fn push_allow(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("allow", v))
  }
}

///|
fn push_sandbox(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("sandbox", v))
  }
}

///|
fn push_allowfullscreen(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("allowfullscreen", Boolean(v)))
  }
}

///|
fn push_coords(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("coords", v))
  }
}

///|
fn push_cite(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("cite", v))
  }
}

///|
fn push_shape(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("shape", v))
  }
}

///|
fn push_kind(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("kind", v))
  }
}

///|
fn push_srclang(value : String?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("srclang", v))
  }
}

///|
fn push_default(value : Bool?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(property("default", Boolean(v)))
  }
}
