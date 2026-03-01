# easings_gleam

[![Package Version](https://img.shields.io/hexpm/v/easings_gleam)](https://hex.pm/packages/easings_gleam)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/easings_gleam/)

Easing functions for animation in pure Gleam.

```sh
gleam add easings_gleam
```

```gleam
import ease

pub fn main() {
  // Compute the easing for bounce-in halfway-through the transition
  0.5 |> ease.bounce()
  // -> 0.234375
}
```

Bounce-In:

```ansi

    1 _ ________________________________________________⣀⣀⡀
      _                                            ⢀⠤⠒⠊⠉
 0.75 _                                          ⡠⠊⠁
      _                                        ⡠⠊
  0.5 _                                      ⡠⠊
      _                                    ⢀⠔
 0.25 _                     ⢀⣀⣀⣀⣀⡀        ⠠⠂
      _                 ⣀⠤⠒⠉⠁    ⠈⠉⠒⠤⣀   ⡐⠁
    0 _ ⣀⣀⣀⣀⣀⡠⠤⠒⠒⠒⠒⠢⠤⢄⠤⠊______________⠑⢄⠔__________________

        |''''|''''|''''|''''|''''|''''|''''|''''|''''|''''|
        0   0.1  0.2  0.3  0.4  0.5  0.6  0.7  0.8  0.9   1
```

Elastic-Out:

```ansi

              ⢀⡀
             ⡐⠁⠈⠢
            ⠠    ⠑⡀
    1 _ ____⠂_____⠐⠄______⢀⡠⠤⠤⠤⠤⠤⢄⣀⣀⣀_⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡀
      _    ⠐       ⠈⠢⣀⣀⣀⠤⠊⠁          ⠉
 0.75 _    ⠄
      _   ⠠
  0.5 _   ⡀
      _
 0.25 _  ⠈
      _  ⠁
    0 _ ⡈__________________________________________________

        |''''|''''|''''|''''|''''|''''|''''|''''|''''|''''|
        0   0.1  0.2  0.3  0.4  0.5  0.6  0.7  0.8  0.9   1
```

Quartic-In-Out:

```ansi

    1 _ _______________________________________⢀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡀
      _                                 ⣀⠤⠔⠒⠊⠉⠉⠁           
 0.75 _                              ⡠⠔⠉                   
      _                           ⢀⠔⠊                      
  0.5 _                          ⡠⠂                        
      _                        ⢀⠊                          
 0.25 _                      ⡠⠒⠁                           
      _                  ⢀⡠⠔⠉                              
    0 _ ⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⠤⠤⠤⠒⠒⠉⠁_________________________________
                                                           
        |''''|''''|''''|''''|''''|''''|''''|''''|''''|''''|
        0   0.1  0.2  0.3  0.4  0.5  0.6  0.7  0.8  0.9   1
```

Further documentation can be found at <https://hexdocs.pm/easings_gleam>.

## Development

```sh
gleam test  # Run the tests
gleam run -m birdie # Update test snapshots
```

<details>
  <summary></summary>

  <style>
      @font-face {
        font-family: "Iosevka";
        font-style: normal;
        font-display: swap;
        font-weight: 400;
        src: url(https://cdn.jsdelivr.net/fontsource/fonts/iosevka@latest/latin-400-normal.woff2) format('woff2'), url(https://cdn.jsdelivr.net/fontsource/fonts/iosevka@latest/latin-400-normal.woff) format('woff');
      }

      .language-ansi {
        font-family: "Iosevka", "monospace";
        line-height: 1.0;
      }
  </style>

</details>
