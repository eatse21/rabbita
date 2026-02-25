///|
pub fn button(value : String, on_click~ : @rabbita.Cmd) -> @rabbita.Html {
  let class =
    #| p-4 bg-pink-200 w-24 rounded-lg select-none text-center 
    #| hover:-translate-y-1 hover:shadow-lg active:bg-pink-300 
    #| active:shadow-sm transition-all
  div(on_click~, class~, [text(value)])
}
