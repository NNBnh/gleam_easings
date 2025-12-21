# easings_gleam

Easing functions for animation in pure Gleam.

[![Package Version](https://img.shields.io/hexpm/v/easings_gleam)](https://hex.pm/packages/easings_gleam)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/easings_gleam/)

```sh
gleam add easings_gleam@1
```
```gleam
import easings

pub fn main() -> Nil {
  // Compute the easing for bounce-in halfway-through the transition
  0.5
  |> easings.bounce_in()
  |> echo

  Nil
}
```

Further documentation can be found at <https://hexdocs.pm/easings_gleam>.

## Development

```sh
gleam test  # Run the tests
gleam run -m birdie # Update test snapshots
```
