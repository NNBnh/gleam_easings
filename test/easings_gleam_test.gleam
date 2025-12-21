import birdie
import easings
import gleam/float
import gleam/int
import gleam/list
import gleam/string
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

const steps = 35

const precision = 8

pub fn linear_test() {
  easings.linear |> snapshot_easing("Linear")
}

pub fn quadratic_in_test() {
  easings.quadratic_in |> snapshot_easing("Quadratic in")
}

pub fn quadratic_out_test() {
  easings.quadratic_out |> snapshot_easing("Quadratic out")
}

pub fn quadratic_in_out_test() {
  easings.quadratic_in_out |> snapshot_easing("Quadratic in/out")
}

pub fn cubic_in_test() {
  easings.cubic_in |> snapshot_easing("Cubic in")
}

pub fn cubic_out_test() {
  easings.cubic_out |> snapshot_easing("Cubic out")
}

pub fn cubic_in_out_test() {
  easings.cubic_in_out |> snapshot_easing("Cubic in/out")
}

pub fn quartic_in_test() {
  easings.quartic_in |> snapshot_easing("Quartic in")
}

pub fn quartic_out_test() {
  easings.quartic_out |> snapshot_easing("Quartic out")
}

pub fn quartic_in_out_test() {
  easings.quartic_in_out |> snapshot_easing("Quartic in/out")
}

pub fn quintic_in_test() {
  easings.quintic_in |> snapshot_easing("Quintic in")
}

pub fn quintic_out_test() {
  easings.quintic_out |> snapshot_easing("Quintic out")
}

pub fn quintic_in_out_test() {
  easings.quintic_in_out |> snapshot_easing("Quintic in/out")
}

pub fn sine_in_test() {
  easings.sine_in |> snapshot_easing("Sine in")
}

pub fn sine_out_test() {
  easings.sine_out |> snapshot_easing("Sine out")
}

pub fn sine_in_out_test() {
  easings.sine_in_out |> snapshot_easing("Sine in/out")
}

pub fn exponential_in_test() {
  easings.exponential_in |> snapshot_easing("Exponential in")
}

pub fn exponential_out_test() {
  easings.exponential_out |> snapshot_easing("Exponential out")
}

pub fn exponential_in_out_test() {
  easings.exponential_in_out |> snapshot_easing("Exponential in/out")
}

pub fn circular_in_test() {
  easings.circular_in |> snapshot_easing("Circular in")
}

pub fn circular_out_test() {
  easings.circular_out |> snapshot_easing("Circular out")
}

pub fn circular_in_out_test() {
  easings.circular_in_out |> snapshot_easing("Circular in/out")
}

pub fn back_in_test() {
  easings.back_in |> snapshot_easing("Back in")
}

pub fn back_out_test() {
  easings.back_out |> snapshot_easing("Back out")
}

pub fn back_in_out_test() {
  easings.back_in_out |> snapshot_easing("Back in/out")
}

pub fn elastic_in_test() {
  easings.elastic_in |> snapshot_easing("Elastic in")
}

pub fn elastic_out_test() {
  easings.elastic_out |> snapshot_easing("Elastic out")
}

pub fn elastic_in_out_test() {
  easings.elastic_in_out |> snapshot_easing("Elastic in/out")
}

pub fn bounce_in_test() {
  easings.bounce_in |> snapshot_easing("Bounce in")
}

pub fn bounce_out_test() {
  easings.bounce_out |> snapshot_easing("Bounce out")
}

pub fn bounce_in_out_test() {
  easings.bounce_in_out |> snapshot_easing("Bounce in/out")
}

fn snapshot_easing(f: easings.Easing, title: String) -> Nil {
  f
  |> compute_steps
  |> string.inspect
  |> birdie.snap(title)
}

fn compute_steps(f: easings.Easing) -> List(#(Float, Float)) {
  use points, step <- list.fold_right(list.range(0, steps), [])
  let t =
    { int.to_float(step) /. int.to_float(steps) }
    |> float.to_precision(precision)
  let y = f(t)

  [#(t, float.to_precision(y, precision)), ..points]
}
