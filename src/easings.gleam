//// Easing functions for more natural animation transitions, derived from
//// [Easings.net](https://easings.net).

import gleam/float
import gleam_community/maths

/// An Easing function maps a float from 0..1 into a float.
///
pub type Easing =
  fn(Float) -> Float

/// Linear easing is an identity transformation, time is not skewed.
///
pub fn linear(t: Float) -> Float {
  t
}

/// Eases in quadratically.
///
/// See [more info](https://easings.net/#easeInQuad).
///
pub fn quadratic(t: Float) -> Float {
  t *. t
}

/// Eases in cubically.
///
/// See [more info](https://easings.net/#easeInCubic).
///
pub fn cubic(t: Float) -> Float {
  t *. t *. t
}

/// Eases in quartically.
///
/// See [more info](https://easings.net/#easeInQuart).
///
pub fn quartic(t: Float) -> Float {
  t *. t *. t *. t
}

/// Eases in quintically.
///
/// See [more info](https://easings.net/#easeInQuint).
///
pub fn quintic(t: Float) -> Float {
  t *. t *. t *. t *. t
}

/// Eases in with a sine function.
///
/// See [more info](https://easings.net/#easeInSine).
///
pub fn sine(t: Float) -> Float {
  let half_pi = 1.5707963267948966

  1.0 -. maths.cos(t *. half_pi)
}

/// Eases in exponentially.
///
/// See [more info](https://easings.net/#easeInExpo).
///
pub fn exponential(t: Float) -> Float {
  case t {
    0.0 -> 0.0
    _ -> {
      let assert Ok(x) = float.power(2.0, 10.0 *. t -. 10.0)
      x
    }
  }
}

/// Eases in on an elliptic arc.
///
/// See [more info](https://easings.net/#easeInCirc).
///
pub fn circular(t: Float) -> Float {
  let assert Ok(x) = float.square_root(1.0 -. t *. t)
  1.0 -. x
}

/// Eases away from the goal before accelerating toward it.
///
/// See [more info](https://easings.net/#easeInBack).
///
pub fn back(t: Float) -> Float {
  let c1 = 1.70158
  let c3 = c1 +. 1.0

  c3 *. t *. t *. t -. c1 *. t *. t
}

/// Eases by oscillating with increasing amplitude around the start.
///
/// See [more info](https://easings.net/#easeInElastic).
///
pub fn elastic(t: Float) -> Float {
  let c4 = 2.0943951

  case t {
    0.0 -> 0.0
    1.0 -> 1.0
    _ -> {
      let assert Ok(p) = float.power(2.0, 10.0 *. t -. 10.0)
      { 0.0 -. p } *. maths.sin({ t *. 10.0 -. 10.75 } *. c4)
    }
  }
}

/// Eases in by "bouncing" around the start.
///
/// See [more info](https://easings.net/#easeInBounce).
///
pub fn bounce(t: Float) -> Float {
  let n1 = 7.5625
  let d1 = 2.75
  let a = 1.0 /. d1
  let b = 2.0 *. a
  let c = 2.5 *. a

  let x = case 1.0 -. t {
    t if t <. a -> {
      n1 *. t *. t
    }
    t if t <. b -> {
      let t = t -. { 1.5 /. d1 }
      n1 *. t *. t +. 0.75
    }
    t if t <. c -> {
      let t = t -. { 2.25 /. d1 }
      n1 *. t *. t +. 0.9375
    }
    t -> {
      let t = t -. { 2.625 /. d1 }
      n1 *. t *. t +. 0.984375
    }
  }
  1.0 -. x
}

/// Eases in like a spring around the start.
///
pub fn spring(t: Float) -> Float {
  let pi = 3.1415926535897932

  let #(t, s1) = #(1.0 -. t, t)
  let assert Ok(s2) = float.power(s1, 2.2)

  1.0
  -. { maths.sin(t *. pi *. { 0.2 +. 2.5 *. t *. t *. t }) *. s2 +. t }
  *. { 1.0 +. { 1.2 *. s1 } }
}

/// Inverts an easing function, so ease-in becomes ease-out and ease-out
/// becomes ease-in.
///
pub fn reverse(fun: Easing) -> Easing {
  fn(t: Float) -> Float { 1.0 -. fun(1.0 -. t) }
}

/// TODO docs
///
pub fn in_out(fun: Easing) -> Easing {
  combine(fun, fun |> reverse)
}

/// TODO docs
///
pub fn combine(ease_start: Easing, ease_end: Easing) -> Easing {
  combine_at(ease_start, ease_end, 0.5)
}

/// TODO docs
///
pub fn combine_at(ease_start: Easing, ease_end: Easing, at: Float) -> Easing {
  fn(t: Float) -> Float {
    case t <. at {
      True -> ease_start(t /. at) *. at
      False -> ease_end({ t -. at } /. { 1.0 -. at }) *. { 1.0 -. at } +. at
    }
  }
}
