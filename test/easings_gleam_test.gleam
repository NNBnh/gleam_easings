import birdie
import easings
import gleam/dict
import gleam/float
import gleam/int
import gleam/list
import gleam/string
import gleeunit
import vec/dict/vec_dict_ansi
import vec/vec2.{Vec2}
import vec/vec2f

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn snapshot_test() {
  let easings = [
    #("linear", easings.linear),
    #("quadratic", easings.quadratic),
    #("cubic", easings.cubic),
    #("quartic", easings.quartic),
    #("quintic", easings.quintic),
    #("sine", easings.sine),
    #("exponential", easings.exponential),
    #("circular", easings.circular),
    #("back", easings.back),
    #("elastic", easings.elastic),
    #("bounce", easings.bounce),
  ]

  easings
  |> list.each(fn(easing) {
    let #(name, fun) = easing

    snapshot_easing(fun, name <> "_in")
    snapshot_easing(fun |> easings.reverse, name <> "_out")
    snapshot_easing(fun |> easings.in_out, name <> "_in_out")
  })
}

fn snapshot_easing(fun: easings.Easing, title: String) -> Nil {
  let steps = fun |> steps

  { graph(steps) <> "\n" <> list_steps(steps) } |> birdie.snap(title)
}

fn steps(fun: easings.Easing) -> List(#(Float, Float)) {
  int.range(0, 101, [], fn(steps, step) {
    let t =
      step |> int.to_float |> float.multiply(0.01) |> float.to_precision(2)
    let x = fun(t) |> float.to_precision(8)

    [#(t, x), ..steps]
  })
  |> list.reverse
}

fn graph(steps: List(#(Float, Float))) -> String {
  steps
  |> list.map(fn(step) {
    let vec =
      step
      |> vec2.from_tuple
      |> vec2f.multiply(Vec2(100.0, -32.0))
      |> vec2f.round
    #(vec, -1)
  })
  |> dict.from_list
  |> vec_dict_ansi.brailles(Vec2(0, 16), Vec2(100, -48))
}

fn list_steps(steps: List(#(Float, Float))) -> String {
  steps
  |> list.map(fn(step) {
    let #(t, x) = step
    let t = t |> float.to_string |> string.pad_end(4, "0")
    let x = x |> float.to_string
    t <> " : " <> x
  })
  |> string.join("\n")
}
