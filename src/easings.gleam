/// Easing functions for more natural animation transitions, derived from [easings.net](https://easings.net).
import gleam/float
import gleam_community/maths

/// An Easing function maps a float from 0..1 into a float
pub type Easing =
  fn(Float) -> Float

const c1 = 1.70158

// C1 * 1.525
const c2 = 2.5949095

// C2 + 1
const c3 = 3.5949095

// 2/3 PI
const c4 = 2.0943951

// 2/4.5 PI
const c5 = 1.3962634

/// Linear easing is an identity transformation, time is not skewed.
pub fn linear(t: Float) -> Float {
  t
}

/// Eases in quadratically.
/// * [easeInQuad](https://easings.net/#easeInQuad)
pub fn quadratic_in(t: Float) -> Float {
  t *. t
}

/// Eases out quadratically.
/// * [easeOutQuad](https://easings.net/#easeOutQuad)
pub fn quadratic_out(t: Float) -> Float {
  t *. { 2.0 -. t }
}

/// Eases in and out quadratically.
/// * [easeInOutQuad](https://easings.net/#easeInOutQuad)
pub fn quadratic_in_out(t: Float) -> Float {
  case t <. 0.5 {
    True -> 2.0 *. t *. t
    False -> {
      let t_adj = t -. 1.0
      -1.0 *. { 2.0 *. t_adj *. t_adj -. 1.0 }
    }
  }
}

/// Eases in cubically.
/// * [easeInCubic](https://easings.net/#easeInCubic)
pub fn cubic_in(t: Float) -> Float {
  t *. t *. t
}

/// Eases out cubically.
/// * [easeOutCubic](https://easings.net/#easeOutCubic)
pub fn cubic_out(t: Float) -> Float {
  let t_adj = t -. 1.0
  t_adj *. t_adj *. t_adj +. 1.0
}

/// Eases in and out cubically.
/// * [easeInOutCubic](https://easings.net/#easeInOutCubic)
pub fn cubic_in_out(t: Float) -> Float {
  case t <. 0.5 {
    True -> 4.0 *. t *. t *. t
    False -> {
      let t_adj = 2.0 *. t -. 2.0
      { t_adj *. t_adj *. t_adj +. 2.0 } /. 2.0
    }
  }
}

/// Eases in quartically.
/// * [easeInQuart](https://easings.net/#easeInQuart)
pub fn quartic_in(t: Float) -> Float {
  t *. t *. t *. t
}

/// Eases out quartically.
/// * [easeOutQuart](https://easings.net/#easeOutQuart)
pub fn quartic_out(t: Float) -> Float {
  1.0 -. { t *. t *. t *. t }
}

/// Eases in and out quartically.
/// * [easeInOutQuart](https://easings.net/#easeInOutQuart)
pub fn quartic_in_out(t: Float) -> Float {
  case t {
    x if x <. 0.5 -> 8.0 *. x *. x *. x *. x
    x -> {
      let x = -2.0 *. x +. 2.0
      1.0 -. { x *. x *. x *. x } /. 2.0
    }
  }
}

/// Eases in quintically.
/// * [easeInQuint](https://easings.net/#easeInQuint)
pub fn quintic_in(t: Float) -> Float {
  t *. t *. t *. t *. t
}

/// Eases out quintically.
/// * [easeOutQuint](https://easings.net/#easeOutQuint)
pub fn quintic_out(t: Float) -> Float {
  1.0 -. { t *. t *. t *. t *. t }
}

/// Eases in and out quintically.
/// * [easeInOutQuint](https://easings.net/#easeInOutQuint)
pub fn quintic_in_out(t: Float) -> Float {
  case t {
    x if x <. 0.5 -> 16.0 *. x *. x *. x *. x *. x
    x -> {
      let x = -2.0 *. x +. 2.0
      1.0 -. { x *. x *. x *. x *. x } /. 2.0
    }
  }
}

/// Eases in with a sine function.
/// * [easeInSine](https://easings.net/#easeInSine)
pub fn sine_in(t: Float) -> Float {
  let angle = t *. 1.5707963267948966
  1.0 -. maths.cos(angle)
}

/// Eases out with a sine function.
/// * [easeOutSine](https://easings.net/#easeOutSine)
pub fn sine_out(t: Float) -> Float {
  let angle = t *. 1.5707963267948966
  maths.sin(angle)
}

/// Eases in and out with a sine function.
/// * [easeInOutSine](https://easings.net/#easeInOutSine)
pub fn sine_in_out(t: Float) -> Float {
  let angle = 3.141592653589793 *. t
  { 1.0 -. maths.cos(angle) } /. 2.0
}

/// Eases in exponentially.
/// * [easeInExpo](https://easings.net/#easeInExpo)
pub fn exponential_in(t: Float) -> Float {
  case t {
    0.0 -> 0.0
    _ -> {
      let assert Ok(r) = float.power(2.0, 10.0 *. t -. 10.0)
      r
    }
  }
}

/// Eases out exponentially.
/// * [easeOutExpo](https://easings.net/#easeOutExpo)
pub fn exponential_out(t: Float) -> Float {
  case t {
    1.0 -> 1.0
    _ -> {
      let assert Ok(r) = float.power(2.0, -10.0 *. t)
      1.0 -. r
    }
  }
}

/// Eases in and out exponentially.
/// * [easeInOutExpo](https://easings.net/#easeInOutExpo)
pub fn exponential_in_out(t: Float) -> Float {
  case t {
    0.0 -> 0.0
    1.0 -> 1.0
    x if x <. 0.5 -> {
      let assert Ok(r) = float.power(2.0, 20.0 *. x -. 10.0)
      r /. 2.0
    }
    _ -> {
      let assert Ok(r) = float.power(2.0, -20.0 *. t +. 10.0)
      { 2.0 -. r } /. 2.0
    }
  }
}

/// Eases in on an elliptic arc.
/// * [easeInCirc](https://easings.net/#easeInCirc)
pub fn circular_in(t: Float) -> Float {
  let assert Ok(i) = float.power(t, 2.0)
  let assert Ok(o) = float.square_root(1.0 -. i)
  1.0 -. o
}

/// Eases out on an elliptic arc.
/// * [easeOutCirc](https://easings.net/#easeOutCirc)
pub fn circular_out(t: Float) -> Float {
  let assert Ok(i) = float.power(t -. 1.0, 2.0)
  let assert Ok(o) = float.square_root(1.0 -. i)
  o
}

/// Eases in and out on elliptic arcs.
/// * [easeInOutCirc](https://easings.net/#easeInOutCirc)
pub fn circular_in_out(t: Float) -> Float {
  case t <. 0.5 {
    True -> {
      let assert Ok(i) = float.power(2.0 *. t, 2.0)
      let assert Ok(o) = float.square_root(1.0 -. i)
      { 1.0 -. o } /. 2.0
    }
    False -> {
      let assert Ok(i) = float.power(-2.0 *. t +. 2.0, 2.0)
      let assert Ok(o) = float.square_root(1.0 -. i)
      { o +. 1.0 } /. 2.0
    }
  }
}

/// Eases away from the goal before accelerating toward it.
/// * [easeInBack](https://easings.net/#easeInBack)
pub fn back_in(t: Float) -> Float {
  { c3 *. t *. t *. t } -. { c1 *. t *. t }
}

/// Eases quickly past the goal before settling toward it.
/// * [easeOutBack](https://easings.net/#easeOutBack)
pub fn back_out(t: Float) -> Float {
  let x = t -. 1.0
  1.0 +. { c3 *. x *. x *. x } +. { c1 *. x *. x }
}

/// Eases away from the goal, and then beyond it.
/// * [easeInOutBack](https://easings.net/#easeInOutBack)
pub fn back_in_out(t: Float) -> Float {
  case t <. 0.5 {
    True -> {
      let x = t *. 2.0
      { x *. x } *. { { c2 +. 1.0 } *. x -. c2 } /. 2.0
    }
    False -> {
      let x = { t *. 2.0 } -. 2.0
      { { x *. x } *. { { c2 +. 1.0 } *. x +. c2 } +. 2.0 } /. 2.0
    }
  }
}

/// Eases by oscillating with increasing amplitude around the start.
/// * [easeInElastic](https://easings.net/#easeInElastic)
pub fn elastic_in(t: Float) -> Float {
  case t {
    0.0 -> 0.0
    1.0 -> 1.0
    x -> {
      let assert Ok(p) = float.power(2.0, 10.0 *. x -. 10.0)
      { 0.0 -. p } *. maths.sin({ x *. 10.0 -. 10.75 } *. c4)
    }
  }
}

/// Eases by oscillating with decreasing amplitude around the end.
/// * [easeOutElastic](https://easings.net/#easeOutElastic)
pub fn elastic_out(t: Float) -> Float {
  case t {
    0.0 -> 0.0
    1.0 -> 1.0
    x -> {
      let assert Ok(p) = float.power(2.0, -10.0 *. x)
      p *. maths.sin({ x *. 10.0 -. 0.75 } *. c4) +. 1.0
    }
  }
}

/// Eases by oscillating with increasing amplitude around the start, and decreasing around the end.
/// * [easeInOutElastic](https://easings.net/#easeInOutElastic)
pub fn elastic_in_out(t: Float) -> Float {
  case t {
    0.0 -> 0.0
    1.0 -> 1.0
    x if x <. 0.5 -> {
      let assert Ok(p) = float.power(2.0, 20.0 *. x -. 10.0)
      { 0.0 -. p } *. maths.sin({ 20.0 *. x -. 11.125 } *. c5) /. 2.0
    }
    x -> {
      let assert Ok(p) = float.power(2.0, -20.0 *. x +. 10.0)
      p *. maths.sin({ 20.0 *. x -. 11.125 } *. c5) /. 2.0 +. 1.0
    }
  }
}

/// Eases in by "bouncing" around the start.
/// * [easeInBounce](https://easings.net/#easeInBounce)
pub fn bounce_in(t: Float) -> Float {
  1.0 -. bounce_out(1.0 -. t)
}

/// Eases out by "bouncing" around the end.
/// * [easeOutBounce](https://easings.net/#easeOutBounce)
pub fn bounce_out(t: Float) -> Float {
  let n1 = 7.5625
  let d1 = 2.75
  let a = 1.0 /. d1
  let b = 2.0 *. a
  let c = 2.5 *. a

  case t {
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
    _ -> {
      let t = t -. { 2.625 /. d1 }
      n1 *. t *. t +. 0.984375
    }
  }
}

/// Eases in and out by "bouncing" around the start and the end.
/// * [easeInBounce](https://easings.net/#easeInBounce)
pub fn bounce_in_out(t: Float) -> Float {
  case t {
    x if x <. 0.5 -> 0.5 *. bounce_in(2.0 *. x)
    x -> 0.5 +. 0.5 *. bounce_out(2.0 *. x -. 1.0)
  }
}
