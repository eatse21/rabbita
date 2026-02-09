///|
fn push_style(style : Array[String], attrs : Array[@attr.Attribute]) -> Unit {
  if style.length() > 0 {
    attrs.push(@attr.attribute("style", style.join(";")))
  }
}

///|
fn push_id(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("id", v))
  }
}

///|
fn push_class(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("class", v))
  }
}

///|
fn push_click(value : Cmd?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.on_click(_ => v))
  }
}

///|
fn push_mousedown(
  value : ((Mouse) -> Cmd)?,
  attrs : Array[@attr.Attribute],
) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.on_mousedown(event => v(Mouse(event))))
  }
}

///|
fn push_mouseup(
  value : ((Mouse) -> Cmd)?,
  attrs : Array[@attr.Attribute],
) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.on_mouseup(event => v(Mouse(event))))
  }
}

///|
fn push_scroll(
  value : ((Scroll) -> Cmd)?,
  attrs : Array[@attr.Attribute],
) -> Unit {
  if value is Some(v) {
    attrs.push(
      @attr.on_scroll(event => {
        let element = event.target().to_element().unwrap()
        v(Scroll(element))
      }),
    )
  }
}

///|
fn push_keydown(
  value : ((Keyboard) -> Cmd)?,
  attrs : Array[@attr.Attribute],
) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.on_keydown(event => v(Keyboard(event))))
  }
}

///|
fn push_keyup(
  value : ((Keyboard) -> Cmd)?,
  attrs : Array[@attr.Attribute],
) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.on_keyup(event => v(Keyboard(event))))
  }
}

///|
fn push_submit(value : Cmd?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(
      @attr.handler("submit", (event, scheduler) => {
        event.prevent_default()
        scheduler.add(v)
      }),
    )
  }
}

///|
fn push_open(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("open", @variant.Boolean(v)))
  }
}

///|
fn push_datetime(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("datetime", v))
  }
}

///|
fn push_reversed(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("reversed", v.to_string()))
  }
}

///|
fn push_start(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("start", v.to_string()))
  }
}

///|
fn push_value_attr_int(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("value", v.to_string()))
  }
}

///|
fn push_value_attr_string(
  value : String?,
  attrs : Array[@attr.Attribute],
) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("value", v))
  }
}

///|
fn push_value_prop_string(
  value : String?,
  attrs : Array[@attr.Attribute],
) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("value", @variant.String(v)))
  }
}

///|
fn push_src(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("src", v))
  }
}

///|
fn push_alt(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("alt", v))
  }
}

///|
fn push_title(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("title", v))
  }
}

///|
fn push_width(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("width", v.to_string()))
  }
}

///|
fn push_height(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("height", v.to_string()))
  }
}

///|
fn push_action(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("action", v))
  }
}

///|
fn push_name(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("name", v))
  }
}

///|
fn push_for(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("for", v))
  }
}

///|
fn push_disabled(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("disabled", @variant.Boolean(v)))
  }
}

///|
fn push_label(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("label", v))
  }
}

///|
fn push_rows(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("rows", v.to_string()))
  }
}

///|
fn push_cols(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("cols", v.to_string()))
  }
}

///|
fn push_placeholder(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("placeholder", v))
  }
}

///|
fn push_readonly(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("readonly", @variant.Boolean(v)))
  }
}

///|
fn push_checked(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("checked", @variant.Boolean(v)))
  }
}

///|
fn push_multiple(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("multiple", @variant.Boolean(v)))
  }
}

///|
fn push_accept(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("accept", v))
  }
}

///|
fn push_max(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("max", v.to_string()))
  }
}

///|
fn push_min(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("min", v.to_string()))
  }
}

///|
fn push_step(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("step", v.to_string()))
  }
}

///|
fn push_maxlength(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("maxlength", v.to_string()))
  }
}

///|
fn push_minlength(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("minlength", v.to_string()))
  }
}

///|
fn push_pattern(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("pattern", v))
  }
}

///|
fn push_size(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("size", v.to_string()))
  }
}

///|
fn push_change(
  value : ((String) -> Cmd)?,
  attrs : Array[@attr.Attribute],
) -> Unit {
  if value is Some(v) {
    attrs.push(
      @attr.handler("change", (event, scheduler) => {
        let target = event.target()
        let value = if target.to_html_input_element() is Some(x) {
          x.value()
        } else if target.to_html_select_element() is Some(x) {
          x.value()
        } else {
          panic() // TODO: check for other HTMLElement types
        }
        scheduler.add(v(value))
      }),
    )
  }
}

///|
fn push_input(
  value : ((String) -> Cmd)?,
  attrs : Array[@attr.Attribute],
) -> Unit {
  if value is Some(v) {
    attrs.push(
      @attr.handler("input", (event, scheduler) => {
        let value = event.target().to_html_input_element().unwrap().value()
        scheduler.add(v(value))
      }),
    )
  }
}

///|
fn push_span(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("span", v.to_string()))
  }
}

///|
fn push_colspan(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("colspan", v.to_string()))
  }
}

///|
fn push_rowspan(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("rowspan", v.to_string()))
  }
}

///|
fn push_headers(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("headers", v))
  }
}

///|
fn push_abbr(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("abbr", v))
  }
}

///|
fn push_scope(value : Scope?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(scope) {
    let s = match scope {
      Row => "row"
      Col => "col"
      RowGroup => "rowgroup"
      ColGroup => "colgroup"
    }
    attrs.push(@attr.attribute("scope", s))
  }
}

///|
fn push_close(
  value : ((String) -> Cmd)?,
  attrs : Array[@attr.Attribute],
) -> Unit {
  if value is Some(close) {
    attrs.push(
      @attr.handler("close", (event, scheduler) => {
        let html_element = event.target().to_html_dialog_element().unwrap()
        scheduler.add(close(html_element.return_value()))
      }),
    )
  }
}

///|
fn push_cancel(value : Cmd?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(cancel) {
    attrs.push(
      @attr.handler("cancel", (event, scheduler) => {
        event.prevent_default()
        scheduler.add(cancel)
      }),
    )
  }
}

///|
fn push_low(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("low", v.to_string()))
  }
}

///|
fn push_high(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("high", v.to_string()))
  }
}

///|
fn push_optimum(value : Int?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("optimum", v.to_string()))
  }
}

///|
fn push_lang(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("lang", v))
  }
}

///|
fn push_dir(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("dir", v))
  }
}

///|
fn push_hidden(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("hidden", @variant.Boolean(v)))
  }
}

///|
fn push_rel(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("rel", v))
  }
}

///|
fn push_href(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("href", v))
  }
}

///|
fn push_target(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("target", v))
  }
}

///|
fn push_download(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("download", v))
  }
}

///|
fn push_media(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("media", v))
  }
}

///|
fn push_sizes(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("sizes", v))
  }
}

///|
fn push_charset(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("charset", v))
  }
}

///|
fn push_content(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("content", v))
  }
}

///|
fn push_http_equiv(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("http-equiv", v))
  }
}

///|
fn push_type(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("type", v))
  }
}

///|
fn push_async(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("async", @variant.Boolean(v)))
  }
}

///|
fn push_defer(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("defer", @variant.Boolean(v)))
  }
}

///|
fn push_required(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("required", @variant.Boolean(v)))
  }
}

///|
fn push_autofocus(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("autofocus", @variant.Boolean(v)))
  }
}

///|
fn push_list(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("list", v))
  }
}

///|
fn push_inputmode(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("inputmode", v))
  }
}

///|
fn push_wrap(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("wrap", v))
  }
}

///|
fn push_srcset(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("srcset", v))
  }
}

///|
fn push_loading(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("loading", v))
  }
}

///|
fn push_decoding(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("decoding", v))
  }
}

///|
fn push_controls(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("controls", @variant.Boolean(v)))
  }
}

///|
fn push_autoplay(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("autoplay", @variant.Boolean(v)))
  }
}

///|
fn push_loop(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("loop", @variant.Boolean(v)))
  }
}

///|
fn push_muted(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("muted", @variant.Boolean(v)))
  }
}

///|
fn push_preload(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("preload", v))
  }
}

///|
fn push_poster(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("poster", v))
  }
}

///|
fn push_allow(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("allow", v))
  }
}

///|
fn push_sandbox(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("sandbox", v))
  }
}

///|
fn push_allowfullscreen(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("allowfullscreen", @variant.Boolean(v)))
  }
}

///|
fn push_coords(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("coords", v))
  }
}

///|
fn push_cite(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("cite", v))
  }
}

///|
fn push_shape(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("shape", v))
  }
}

///|
fn push_kind(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("kind", v))
  }
}

///|
fn push_srclang(value : String?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.attribute("srclang", v))
  }
}

///|
fn push_default(value : Bool?, attrs : Array[@attr.Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(@attr.property("default", @variant.Boolean(v)))
  }
}
