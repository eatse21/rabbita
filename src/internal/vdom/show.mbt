///|
impl Show for AttrsUpdate with to_string(self : AttrsUpdate) -> String {
  match self {
    AttrRemove(key) => "AttrRemove(\{key})"
    AttrAdd(key, value) => "AttrAdd(\{key}, \{value})"
    StyleAdd(key, value) => "StyleAdd(\{key}, \{value})"
    StyleRemove(key) => "StyleRemove(\{key})"
    PropertyAdd(key, value) => "PropertyAdd(\{key}, \{value})"
    PropertyRemove(key) => "PropertyRemove(\{key})"
    EventRemove(key, _) => "EventRemove(\{key})"
    EventAdd(key, _) => "EventAdd(\{key})"
  }
}

///|
impl Show for AttrsUpdate with output(self, buf) {
  buf.write_string(self.to_string())
}

///|
impl Show for AttrValue with to_string(self) {
  match self {
    AttrEvent(_) => "AttrEvent"
    AttrStyle(value) => "AttrStyle(\{value})"
    AttrString(value) => "AttrString(\{value})"
    AttrProperty(value) => "AttrProperty(\{value})"
  }
}

///|
impl Show for AttrValue with output(self, buf) {
  buf.write_string(self.to_string())
}

///|
impl Show for Node with to_string(self) {
  match self {
    Node(tag, attrs~, children~, listeners~, namespace_uri~) =>
      "Node(\{tag}, \{attrs}, \{children}, Listeners(\{listeners.length()}), \{namespace_uri})"
    ExternalNode(_, attrs, width~, height~) =>
      "ExternalNode(\{attrs},\{width},\{height})"
    Text(value) => "Text(\{value})"
    Nothing => "Nothing"
  }
}

///|
impl Show for Node with output(self, buf) {
  buf.write_string(self.to_string())
}

///|
impl Show for Patch with to_string(self) {
  match self {
    Drop(index, length) => "Drop(\{index}, \{length})"
    Remove(index) => "Remove(\{index})"
    Replace(index, node) => "Replace(\{index}, \{node})"
    InsertBefore(index, node) => "InsertBefore(\{index}, \{node})"
    Append(nodes) => "Append(\{nodes})"
    Update(update) => "Update(\{update})"
  }
}

///|
impl Show for Patch with output(self, buf) {
  buf.write_string(self.to_string())
}

///|
impl Show for Update with to_string(self) {
  match self {
    UpdateNode(index, attrs, children, listeners) =>
      "UpdateNode(\{index}, \{attrs}, \{children}, Listeners(\{listeners.length()}))"
    UpdateText(index, value) => "UpdateText(\{index}, \{value})"
  }
}

///|
impl Show for Update with output(self, buf) {
  buf.write_string(self.to_string())
}

///|
impl Show for Attribute with to_string(self) {
  "Attribute(\{self.0}, \{self.1})"
}

///|
impl Show for Attribute with output(self, buf) {
  buf.write_string(self.to_string())
}
