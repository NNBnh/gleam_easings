import birdie
import easings
import gleam/dict
import gleam/float
import gleam/int
import gleam/list
import gleam/string
import gleeunit
import vec/dict/vec2i_dict
import vec/dict/vec_dict_ansi
import vec/vec2.{Vec2}
import vec/vec2f
import vec/vec2i

const graph_background = ""
  <> "                                                           \n"
  <> "                                                           \n"
  <> "                                                           \n"
  <> "    1 _ ___________________________________________________\n"
  <> "      _                                                    \n"
  <> " 0.75 _                                                    \n"
  <> "      _                                                    \n"
  <> "  0.5 _                                                    \n"
  <> "      _                                                    \n"
  <> " 0.25 _                                                    \n"
  <> "      _                                                    \n"
  <> "    0 _ ___________________________________________________\n"
  <> "                                                           \n"
  <> "        |''''|''''|''''|''''|''''|''''|''''|''''|''''|''''|\n"
  <> "        0   0.1  0.2  0.3  0.4  0.5  0.6  0.7  0.8  0.9   1\n"
  <> "                                                           \n"

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
    #("spring", easings.spring),
  ]

  easings
  |> list.each(fn(easing) {
    let #(name, ease_start) = easing

    snapshot_easing(ease_start, name <> "_in")
    snapshot_easing(ease_start |> easings.reverse, name <> "_out")
    snapshot_easing(ease_start |> easings.in_out, name <> "_in_out")
    snapshot_easing(
      ease_start |> easings.reverse |> easings.in_out,
      name <> "_out_in",
    )

    easings
    |> list.index_map(fn(easing, y) {
      let #(_name, ease_end) = easing
      let ease_end = ease_end |> easings.reverse
      [0.25, 0.5, 0.75]
      |> list.index_map(fn(at, x) {
        #(
          Vec2(x, y),
          easings.combine_at(ease_start, ease_end, at) |> steps |> graph,
        )
      })
    })
    |> list.flatten
    |> dict.from_list
    |> vec_dict_ansi.custom(vec2i.zero, Vec2(2, list.length(easings) - 1))
    |> birdie.snap(name <> "_combine")
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
  |> vec2i_dict.translate(Vec2(0, -1))
  |> vec_dict_ansi.brailles(Vec2(0, 16), Vec2(100, -48))
  |> vec2i_dict.from_string
  |> vec2i_dict.translate(Vec2(8, 0))
  |> dict.merge(vec2i_dict.from_string(graph_background), _)
  |> vec_dict_ansi.custom(vec2i.zero, Vec2(58, 15))
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
