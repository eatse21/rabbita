// ///|
// pub(all) struct Svg(@runtime.Node)

// ///|
// pub(all) struct Attribute(@runtime.Attribute)

// ///|
// pub fn node(
//   tag : String,
//   attrs : Array[Attribute],
//   children : Array[Svg],
// ) -> Svg {
//   @runtime.node_ns(
//     @dom.namespace_svg,
//     tag,
//     attrs.map(x => x.0),
//     children.map(x => x.0),
//   )
// }

// ///|
// pub fn attribute(key : String, value : String) -> Attribute {
//   @runtime.attribute(key, value)
// }

// ///|
// pub fn property(key : String, value : @variant.Variant) -> Attribute {
//   @runtime.property(key, value)
// }

// ///|
// pub fn svg(
//   attrs : Array[Attribute],
//   children : Array[Svg],
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // required
//   width? : Int,
//   height? : Int,
//   // optional
//   view_box? : String,
//   xmlns? : String,
// ) -> @html.Html {
//   let attrs : Array[Attribute] = [..attrs]
//   if width is Some(val) {
//     attrs.push(attribute("width", val.to_string()))
//   }
//   if height is Some(val) {
//     attrs.push(attribute("height", val.to_string()))
//   }
//   if id is Some(val) {
//     attrs.push(attribute("id", val))
//   }
//   if class is Some(val) {
//     attrs.push(attribute("class", val))
//   }
//   if style is Some(val) {
//     attrs.push(attribute("style", val.join(";")))
//   }
//   let attrs : Array[Attribute] = []
//   if view_box is Some(val) {
//     attrs.push(attribute("viewBox", val))
//   }
//   if xmlns is Some(val) {
//     attrs.push(attribute("xmlns", val))
//   }
//   @runtime.node_ns(
//     @dom.namespace_svg,
//     "svg",
//     attrs.map(x => x.0),
//     children.map(x => x.0),
//   )
// }

// ///|
// /// Create an SVG element from a svg string.
// pub fn from_string(svg : String) -> @html.Html {
//   @runtime.node_ns(
//     @dom.namespace_svg,
//     "svg",
//     [@runtime.property("innerHTML", String(svg))],
//     [],
//   )
// }

// ///|
// fn common_svg_node(
//   tag_name : String,
//   new_attrs : Array[Attribute],
//   // common attributes
//   id~ : String?,
//   style~ : Array[String]?,
//   class~ : String?,
//   children~ : Array[Svg]?,
// ) -> Svg {
//   let attrs : Array[Attribute] = []
//   for attr in new_attrs {
//     attrs.push(attr)
//   }
//   if id is Some(val) {
//     attrs.push(attribute("id", val))
//   }
//   if class is Some(val) {
//     attrs.push(attribute("class", val))
//   }
//   if style is Some(val) {
//     attrs.push(attribute("style", val.join(";")))
//   }
//   node(tag_name, attrs, children.unwrap_or([]))
// }

// ///|
// /// svg rect element
// pub fn rect(
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // required
//   x~ : Int,
//   y~ : Int,
//   width~ : Int,
//   height~ : Int,
//   // optional
//   rx? : Int,
//   ry? : Int,
//   fill? : String,
//   stroke? : String,
//   stroke_width? : Int,
// ) -> Svg {
//   let attrs : Array[Attribute] = [
//     attribute("x", x.to_string()),
//     attribute("y", y.to_string()),
//     attribute("width", width.to_string()),
//     attribute("height", height.to_string()),
//   ]
//   if rx is Some(val) {
//     attrs.push(attribute("rx", val.to_string()))
//   }
//   if ry is Some(val) {
//     attrs.push(attribute("ry", val.to_string()))
//   }
//   if style is Some(val) {
//     attrs.push(attribute("style", val.join(";")))
//   }
//   if fill is Some(val) {
//     attrs.push(attribute("fill", val))
//   }
//   if stroke is Some(val) {
//     attrs.push(attribute("stroke", val))
//   }
//   if stroke_width is Some(val) {
//     attrs.push(attribute("stroke-width", val.to_string()))
//   }
//   common_svg_node("rect", attrs, id~, style~, class~, children=None)
// }

// ///|
// /// svg ellipse element
// pub fn ellipse(
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // required
//   cx~ : Int,
//   cy~ : Int,
//   rx~ : Int,
//   ry~ : Int,
//   // optional
//   fill? : String,
//   stroke? : String,
//   stroke_width? : Int,
// ) -> Svg {
//   let attrs : Array[Attribute] = [
//     attribute("cx", cx.to_string()),
//     attribute("cy", cy.to_string()),
//     attribute("rx", rx.to_string()),
//     attribute("y", ry.to_string()),
//   ]
//   if style is Some(val) {
//     attrs.push(attribute("style", val.join(";")))
//   }
//   if fill is Some(val) {
//     attrs.push(attribute("fill", val))
//   }
//   if stroke is Some(val) {
//     attrs.push(attribute("stroke", val))
//   }
//   if stroke_width is Some(val) {
//     attrs.push(attribute("stroke-width", val.to_string()))
//   }
//   common_svg_node("rect", attrs, id~, style~, class~, children=None)
// }

// ///|
// /// svg text
// pub fn svg_text(
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // required
//   x~ : Int,
//   y~ : Int,
//   text~ : String,
//   // optional
//   dx? : Int,
//   dy? : Int,
//   rotate? : String,
//   length_adjust? : String,
//   text_length? : Int,
// ) -> Svg {
//   let attrs : Array[Attribute] = [
//     attribute("x", x.to_string()),
//     attribute("y", y.to_string()),
//     property("textContent", @variant.String(text)),
//   ]
//   if dx is Some(val) {
//     attrs.push(attribute("dx", val.to_string()))
//   }
//   if dy is Some(val) {
//     attrs.push(attribute("dy", val.to_string()))
//   }
//   if rotate is Some(val) {
//     attrs.push(attribute("rotate", val))
//   }
//   if length_adjust is Some(val) {
//     attrs.push(attribute("lengthAdjust", val))
//   }
//   if text_length is Some(val) {
//     attrs.push(attribute("textLength", val.to_string()))
//   }
//   common_svg_node("text", attrs, id~, style~, class~, children=None)
// }

// ///|
// /// svg text
// pub fn path(
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // required
//   d~ : String,
// ) -> Svg {
//   let attrs : Array[Attribute] = [attribute("d", d)]
//   common_svg_node("path", attrs, id~, style~, class~, children=None)
// }

// ///|
// /// svg g element
// pub fn g(
//   children : Array[Svg],
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // optional
//   fill? : String,
//   stroke? : String,
// ) -> Svg {
//   let attrs : Array[Attribute] = []
//   if fill is Some(val) {
//     attrs.push(attribute("fill", val))
//   }
//   if stroke is Some(val) {
//     attrs.push(attribute("stroke", val))
//   }
//   common_svg_node("g", attrs, id~, style~, class~, children=Some(children))
// }

// ///|
// /// svg defs element
// pub fn defs(children : Array[Svg]) -> Svg {
//   let attrs : Array[Attribute] = []
//   common_svg_node(
//     "defs",
//     attrs,
//     id=None,
//     style=None,
//     class=None,
//     children=Some(children),
//   )
// }

// ///|
// /// svg use element
// pub fn svg_use(
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // required
//   href~ : String,
//   x~ : Int,
//   y~ : Int,
//   // optional
//   stroke? : String,
//   stroke_width? : Int,
//   fill? : String,
//   fill_opacity? : Int,
// ) -> Svg {
//   let attrs : Array[Attribute] = [
//     attribute("href", href),
//     attribute("x", x.to_string()),
//     attribute("y", y.to_string()),
//   ]
//   if stroke is Some(val) {
//     attrs.push(attribute("stroke", val))
//   }
//   if stroke_width is Some(val) {
//     attrs.push(attribute("stroke-width", val.to_string()))
//   }
//   if fill is Some(val) {
//     attrs.push(attribute("fill", val))
//   }
//   if fill_opacity is Some(val) {
//     attrs.push(attribute("fill-opacity", val.to_string()))
//   }
//   common_svg_node("use", attrs, id~, style~, class~, children=None)
// }

// ///|
// pub fn view(
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // required
//   view_box? : String,
//   zoom_and_pan? : String,
//   preserve_aspect_ratio? : String,
// ) -> Svg {
//   let attrs : Array[Attribute] = []
//   if view_box is Some(val) {
//     attrs.push(attribute("viewBox", val))
//   }
//   if zoom_and_pan is Some(val) {
//     attrs.push(attribute("zoomAndPan", val))
//   }
//   if preserve_aspect_ratio is Some(val) {
//     attrs.push(attribute("preserveAspectRatio", val))
//   }
//   common_svg_node("view", attrs, id~, style~, class~, children=None)
// }

// ///|
// /// svg g element
// pub fn image(
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // required
//   href~ : String,
//   x~ : Int,
//   y~ : Int,
//   // optional
//   preserveAspectRatio? : String,
// ) -> Svg {
//   let attrs : Array[Attribute] = [
//     attribute("href", href),
//     attribute("x", x.to_string()),
//     attribute("y", y.to_string()),
//   ]
//   if preserveAspectRatio is Some(val) {
//     attrs.push(attribute("preserveAspectRatio", val))
//   }
//   common_svg_node("image", attrs, id~, style~, class~, children=None)
// }

// ///|
// /// svg circle element
// pub fn circle(
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // required
//   cx~ : Int,
//   cy~ : Int,
//   r~ : Int,
//   // optional
//   fill? : String,
//   stroke? : String,
//   stroke_width? : Int,
//   fill_opacity? : Int,
// ) -> Svg {
//   let attrs : Array[Attribute] = [
//     attribute("r", r.to_string()),
//     attribute("cx", cx.to_string()),
//     attribute("cy", cy.to_string()),
//   ]
//   if fill is Some(val) {
//     attrs.push(attribute("fill", val))
//   }
//   if stroke is Some(val) {
//     attrs.push(attribute("stroke", val))
//   }
//   if stroke_width is Some(val) {
//     attrs.push(attribute("stroke-width", val.to_string()))
//   }
//   if fill_opacity is Some(val) {
//     attrs.push(attribute("fill-opacity", val.to_string()))
//   }
//   common_svg_node("circle", attrs, id~, style~, class~, children=None)
// }

// ///|
// /// svg line element
// pub fn line(
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // required
//   x1~ : Int,
//   y1~ : Int,
//   x2~ : Int,
//   y2~ : Int,
//   // optional
//   fill? : String,
//   stroke? : String,
//   stroke_width? : Int,
//   stroke_linecap? : String,
// ) -> Svg {
//   let attrs : Array[Attribute] = []
//   attrs.push(attribute("x1", x1.to_string()))
//   attrs.push(attribute("y1", y1.to_string()))
//   attrs.push(attribute("x2", x2.to_string()))
//   attrs.push(attribute("y2", y2.to_string()))
//   if fill is Some(val) {
//     attrs.push(attribute("fill", val))
//   }
//   if stroke is Some(val) {
//     attrs.push(attribute("stroke", val))
//   }
//   if stroke_width is Some(val) {
//     attrs.push(attribute("stroke-width", val.to_string()))
//   }
//   if stroke_linecap is Some(val) {
//     attrs.push(attribute("stroke-linecap", val))
//   }
//   common_svg_node("line", attrs, id~, style~, class~, children=None)
// }

// ///|
// /// svg polyline element
// pub fn polyline(
//   // common attributes
//   id? : String,
//   class? : String,
//   style? : Array[String],
//   // required
//   points~ : Array[(Int, Int)],
//   pathLength~ : Int,
//   // optional
//   fill? : String,
//   stroke? : String,
//   stroke_width? : Int,
//   stroke_linecap? : String,
// ) -> Svg {
//   let attrs : Array[Attribute] = []
//   if points.length() > 0 {
//     let points_str = points.map(pt => "\{pt.0},\{pt.1}").join(" ")
//     attrs.push(attribute("points", points_str))
//   }
//   attrs.push(attribute("pathLength", pathLength.to_string()))
//   if fill is Some(val) {
//     attrs.push(attribute("fill", val))
//   }
//   if stroke is Some(val) {
//     attrs.push(attribute("stroke", val))
//   }
//   if stroke_width is Some(val) {
//     attrs.push(attribute("stroke-width", val.to_string()))
//   }
//   if stroke_linecap is Some(val) {
//     attrs.push(attribute("stroke-linecap", val))
//   }
//   common_svg_node("polyline", attrs, id~, style~, class~, children=None)
// }

// ///|
// /// svg foreignObject element
// /// TODO: foreignObject children are html elements
// // pub fn[M] foreign_object(
// //   // take html children, not svg
// //   // <foreignObject x="20" y="20" width="160" height="160">
// //   //   <div>elem</div>
// //   // </foreignObject>
// //   children: Array[@html.Html[M]],
// //   // common attributes
// //   id? : String,
// //   class? : String,
// //   style? : Array[String],
// //   // required
// //   x~ : Int,
// //   y~ : Int,
// //   width? : Int,
// //   height? : Int,
// // ) -> Svg[M] {
// //   let attrs : Array[Attribute[M]] = [
// //     attribute("x", x.to_string()),
// //     attribute("y", y.to_string()),
// //   ]
// //   if width is Some(val) {
// //     attrs.push(attribute("width", val.to_string()))
// //   }
// //   if height is Some(val) {
// //     attrs.push(attribute("height", val.to_string()))
// //   }
// //   if id is Some(val) {
// //     attrs.push(attribute("id", val))
// //   }
// //   if class is Some(val) {
// //     attrs.push(attribute("class", val))
// //   }
// //   if style is Some(val) {
// //     attrs.push(attribute("style", val.join(";")))
// //   }
// //   ...
// // }

// // TODO
// // clippath, filter, linearGradient, radialGradient, marker, pattern, mask
