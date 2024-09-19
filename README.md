# Swift Explorer

[![CI](https://github.com/heroesofcode/swift-explorer/actions/workflows/CI.yml/badge.svg)](https://github.com/heroesofcode/swift-explorer/actions/workflows/CI.yml)
[![codecov](https://codecov.io/gh/heroesofcode/swift-explorer/graph/badge.svg?token=gUGYi5D9Ga)](https://codecov.io/gh/heroesofcode/swift-explorer)
![GitHub Release](https://img.shields.io/github/v/release/heroesofcode/swift-explorer)
![macOS Version](https://img.shields.io/badge/macOS-14.0+-orange.svg)
[![GitHub](https://img.shields.io/github/license/heroesofcode/swift-explorer)](https://github.com/heroesofcode/swift-explorer/blob/main/LICENSE)

<img src="https://github.com/heroesofcode/swift-explorer/blob/main/SwiftExplorer/Assets.xcassets/AppIcon.appiconset/1024-mac.png?raw=true" align="right" width="100" height="100" />

Desktop tool to quickly explore and analyze Swift Intermediate Representation (IR) generated by the LLVM compiler, and also generate assembly code.

## Features

<img src="https://github.com/heroesofcode/swift-explorer/blob/main/Assets/screen1.png?raw=true">

<img src="https://github.com/heroesofcode/swift-explorer/blob/main/Assets/screen2.png?raw=true">

- <b>Deep Code Understanding:</b> Developers can see how Swift code is transformed into both LLVM IR and assembly code, helping them better understand optimization and low-level behavior.
- <b>Advanced Debugging:</b> Viewing LLVM IR and assembly can help identify performance issues or hard-to-trace bugs in source code.
- <b>Education and Learning:</b> A valuable educational tool for learning about compilers and how different language constructs translate into intermediate representation and assembly.
- <b>Optimization:</b> Helps identify and optimize code snippets that are not compiling efficiently by providing insights from both LLVM IR and assembly.
- <b>Comparative Analysis:</b> Allows you to compare how different approaches or code versions generate different IR and assembly code, facilitating the choice of best coding practices.
- <b>IA Gemini:</b> You can see how to improve your code and compare LVVM and Assembly with the help of Gemini.

> [!IMPORTANT]
> To review the details through Gemini, you must generate an API Key through this [link](https://aistudio.google.com/app/apikey).

### Optimization flags

- `Onone:` Compile without any optimization.
- `Osize:` Compile with optimizations and target small code size.
- `Ounchecked:` Compile with optimizations and remove runtime safety checks.
- `O:` Compile with optimizations.

## Installing

Download the dmg - [click here](https://github.com/heroesofcode/swift-explorer/releases/download/1.7.0/SwiftExplorer.dmg)

## Contributing

Please see the [documentation](https://github.com/heroesofcode/swift-explorer/blob/main/CONTRIBUTING.md)

## Run the project

Install [mise](https://mise.jdx.dev/)
```sh
mise install
```

Generate `SwiftExplorer.xcworkspace` with [Tuist](https://tuist.io/)
```
tuist install
tuist generate
```

## Inspiration

This project was inspired by [kotlin-explorer](https://github.com/romainguy/kotlin-explorer) developed by [Romain Guy](https://github.com/romainguy).

If you have any questions about the kotlin-explorer tool, I recommend you watch the talk [Practical Optimizations - Romain Guy](https://www.youtube.com/watch?v=5cxw_fdpnoA&list=PLn7H9CUCuXAtxPltq2mEHc_Wbgckrd4B-)

## License

swift-explorer is released under the MIT license. See [LICENSE](https://github.com/heroesofcode/swift-explorer/blob/main/LICENSE) for details.
