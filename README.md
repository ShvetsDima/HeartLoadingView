# HeartLoadingView

# ![./HeartLoadingView](https://github.com/ShvetsDima/HeartLoadingView/blob/master/Assets/theme.png)
[![Version](https://img.shields.io/cocoapods/v/HeartLoadingView.svg?style=flat)](http://cocoapods.org/pods/HeartLoadingView)
[![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)]()
[![Supports](https://img.shields.io/badge/supports-CocoaPods%20%7C%20Carthage-green.svg?style=flat)]()
[![License](https://img.shields.io/cocoapods/l/HeartLoadingView.svg?style=flat)](http://cocoapods.org/pods/HeartLoadingView)
[![Platform](https://img.shields.io/cocoapods/p/HeartLoadingView.svg?style=flat)](http://cocoapods.org/pods/HeartLoadingView)
<br />

[![Twitter: @GhazouaniHamza](https://img.shields.io/badge/contact-@Bear_Tooth-blue.svg?style=flat)](https://twitter.com/Bear_Tooth)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

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

HeartLoadingView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HeartLoadingView'
```

HeartLoadingView is also available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:


``` ruby
github "ShvetsDima/HeartLoadingView"
```

## Author

Dima Shvets, aoedima@gmail.com

## License

HeartLoadingView is available under the MIT license. See the LICENSE file for more info.
