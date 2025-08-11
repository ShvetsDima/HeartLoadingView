# HeartLoadingView

# ![./HeartLoadingView](https://github.com/ShvetsDima/HeartLoadingView/blob/master/Assets/theme.png)
[![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)]()
<br />

[![Twitter: @GhazouaniHamza](https://img.shields.io/badge/contact-@Bear_Tooth-blue.svg?style=flat)](https://twitter.com/Bear_Tooth)

## Preview

Progress                   |  Amplitude
:-------------------------:|:-------------------------:
![](/Assets/Progress.gif)  |  ![](/Assets/amplitude.gif)

Color                      |  Progress Text
:-------------------------:|:-------------------------:
![](/Assets/Color.gif)  |  ![](/Assets/ProgressText.gif)

## Requirements
- iOS 8.0+
- Xcode 9.2

## Usage

1. Change the class of a view from UIView to HeartLoadingView
2. Programmatically:

```
let heartLoadingView = HeartLoadingView(frame: yourFrame)
```

## Customization

1. Progress level (0..<1)

```
heartLoadingView.progress = 0.5
```

2. Amplitude

```
heartLoadingView.amplitude = 50.0
```

3. Progress Text

```
heartLoadingView.isShowProgressText = true
```

4. Progress Text Font

```
heartLoadingView.progressTextFont = UIFont.systemFont(ofSize: 15.0)
```

5. Colors

```
heartLoadingView.heavyHeartColor = randomColor
heartLoadingView.lightHeartColor = randomColor.withAlphaComponent(0.5)
heartLoadingView.fillHeartColor = randomColor.withAlphaComponent(0.2)
```

6. Animation

```
heartLoadingView.isAnimated = true
```

## Installation

You can integrate HeartLoadingView by manually copying the source files into your project.

## License

HeartLoadingView is available under the MIT license. See the LICENSE file for more info.
