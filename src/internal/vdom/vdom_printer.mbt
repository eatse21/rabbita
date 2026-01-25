///|
pub fn pretty_vnode(vnode : VNode) -> String {
  let buf = StringBuilder::new()
  write_vnode(buf, vnode, 0)
  buf.to_string()
}

///|
fn write_vnode(buf : StringBuilder, vnode : VNode, depth : Int) -> Unit {
  match vnode {
    Elem(tag, elem_props, children, namespace_uri=ns, node~) => {
      write_line(buf, depth, "VNode::Elem")
      write_line(buf, depth + 1, "tag: \{format_string(tag)}")
      write_line(buf, depth + 1, "namespace_uri: \{format_option_string(ns)}")
      write_line(buf, depth + 1, "node: \{format_dom_node(node)}")
      write_line(buf, depth + 1, "props:")
      write_props(buf, elem_props, depth + 2)
      write_line(buf, depth + 1, "children:")
      write_children(buf, children, depth + 2)
    }
    Text(value, node~) => {
      write_line(buf, depth, "VNode::Text")
      write_line(buf, depth + 1, "text: \{format_string(value)}")
      write_line(buf, depth + 1, "node: \{format_dom_node(node)}")
    }
    Cell(cell) => {
      write_line(buf, depth, "VNode::Cell")
      write_line(buf, depth + 1, "cell:")
      write_line(buf, depth + 2, "id: \{cell.id()}")
      write_line(buf, depth + 2, "dirty: \{cell.dirty_flag()}")
      write_line(buf, depth + 2, "detail: ...")
      write_line(buf, depth + 2, "vnode:")
      write_vnode(buf, cell.node(), depth + 3)
    }
    Empty => {
      write_line(buf, depth, "VNode::Empty")
    }
  }
}

///|
fn write_children(buf : StringBuilder, children : Children, depth : Int) -> Unit {
  match children {
    Array(items) => {
      write_line(buf, depth, "Array(len=\{items.length()})")
      if items.length() == 0 {
        write_line(buf, depth + 1, "(empty)")
      } else {
        for i, child in items {
          write_line(buf, depth + 1, "[\{i}]:")
          write_vnode(buf, child, depth + 2)
        }
      }
    }
    Map(items) => {
      write_line(buf, depth, "Map(len=\{items.length()})")
      if items.length() == 0 {
        write_line(buf, depth + 1, "(empty)")
      } else {
        for k, child in items {
          write_line(buf, depth + 1, "\{format_string(k)}:")
          write_vnode(buf, child, depth + 2)
        }
      }
    }
  }
}

///|
fn write_props(buf : StringBuilder, props : Props, depth : Int) -> Unit {
  if props.attrs.length() > 0 {
    write_map_string(buf, "attrs", props.attrs, depth)
  }
  if props.props.length() > 0 {
    write_map_variant(buf, "props", props.props, depth)
  }
  if props.styles.length() > 0 {
    write_map_string(buf, "styles", props.styles, depth)
  }
  if props.handlers.length() > 0 {
    write_map_hidden(buf, "handlers", props.handlers, depth)
  }
  if props.slots.length() > 0 {
    write_map_hidden(buf, "slots", props.slots, depth)
  }
}

///|
fn write_map_string(
  buf : StringBuilder,
  title : String,
  items : Map[String, String],
  depth : Int,
) -> Unit {
  write_line(buf, depth, "\{title} (len=\{items.length()}):")
  if items.length() == 0 {
    write_line(buf, depth + 1, "(empty)")
  } else {
    for k, v in items {
      write_line(buf, depth + 1, "\{k}: \{format_string(v)}")
    }
  }
}

///|
fn write_map_variant(
  buf : StringBuilder,
  title : String,
  items : Map[String, @variant.Variant],
  depth : Int,
) -> Unit {
  write_line(buf, depth, "\{title} (len=\{items.length()}):")
  if items.length() == 0 {
    write_line(buf, depth + 1, "(empty)")
  } else {
    for k, v in items {
      write_line(buf, depth + 1, "\{k}: \{format_variant(v)}")
    }
  }
}

///|
fn[V] write_map_hidden(
  buf : StringBuilder,
  title : String,
  items : Map[String, V],
  depth : Int,
) -> Unit {
  write_line(buf, depth, "\{title} (len=\{items.length()}):")
  if items.length() == 0 {
    write_line(buf, depth + 1, "(empty)")
  } else {
    for k, _ in items {
      write_line(buf, depth + 1, "\{k}: ...")
    }
  }
}

///|
fn write_line(buf : StringBuilder, depth : Int, line : String) -> Unit {
  buf.write_string("  ".repeat(depth))
  buf.write_string(line)
  buf.write_char('\n')
}

///|
fn format_dom_node(node : @dom.Node?) -> String {
  match node {
    None => "None"
    Some(n) => describe_dom_node(n)
  }
}

///|
fn describe_dom_node(node : @dom.Node) -> String {
  let name = node.get_node_name()
  if name == "#text" {
    let value = escape_string(node.get_node_value())
    "text \"\{value}\""
  } else {
    "<\{name}>"
  }
}

///|
fn format_option_string(value : String?) -> String {
  match value {
    None => "None"
    Some(v) => format_string(v)
  }
}

///|
fn format_variant(value : @variant.Variant) -> String {
  match value {
    Boolean(v) => v.to_string()
    Integer(v) => v.to_string()
    Floating(v) => v.to_string()
    String(v) => format_string(v)
  }
}

///|
fn format_string(value : String) -> String {
  let escaped = escape_string(value)
  "\"\{escaped}\""
}

///|
fn escape_string(value : String) -> String {
  value
  .replace_all(old="\\", new="\\\\")
  .replace_all(old="\"", new="\\\"")
  .replace_all(old="\n", new="\\n")
  .replace_all(old="\r", new="\\r")
  .replace_all(old="\t", new="\\t")
}
