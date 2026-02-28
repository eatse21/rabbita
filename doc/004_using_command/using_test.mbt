///|
using @rabbita {type Dispatch, type Cmd, type Html, none, batch, delay}

///|
using @html {div, h1, p, button}

///|
test {
  ignore(Inc)
  ignore(IncLater)
  ignore(Reset)
  let basic_tag = match Inc {
    Inc => 1
    IncLater => 2
    Reset => 3
  }
  ignore(basic_tag)

  ignore(RunBatch)
  ignore(StartLoad)
  ignore(StartTry)
  let batch_tag = match RunBatch {
    RunBatch => 1
    Applied(_) => 2
  }
  ignore(batch_tag)
  let perform_tag = match StartLoad {
    StartLoad => 1
    Loaded(_) => 2
  }
  ignore(perform_tag)
  let attempt_tag = match StartTry {
    StartTry => 1
    Tried(_) => 2
  }
  ignore(attempt_tag)

  ignore(update)
  ignore(view)
  ignore(batch_update)
  ignore(perform_update)
  ignore(attempt_update)
}
