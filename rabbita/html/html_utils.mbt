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
fn push_border(value : Int?, attrs : Array[Attribute]) -> Unit {
  if value is Some(v) {
    attrs.push(attribute("border", v.to_string()))
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
