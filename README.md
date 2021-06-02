# SPIndicator

<img align="left" src="https://github.com/ivanvorobei/SPIndicator/blob/main/Assets/Readme/preview-v1.jpg" width="360"/>

### About

Mimicrate to indicator which appear when silent mode turn on / off. Availalbe 2 animated presets: `done` & `error`.  Also support custom images and present from top, center & bottom side.

If you need alert from Apple music, use library [SPAlert](https://github.com/ivanvorobei/SPAlert).

If you like the project, don't forget to `put star ★` and follow me on GitHub:

[![https://github.com/ivanvorobei](https://github.com/ivanvorobei/Readme/blob/main/Buttons/follow-me-ivanvorobei.svg)](https://github.com/ivanvorobei)

## Navigate

- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
    - [Manually](#manually)
- [Quick Start](#quick-start)
- [Usage](#usage)
    - [Duration](#duration)
    - [Layout](#layout)
    - [Dismiss by Drag](#dismiss-by-drag)
    - [Haptic](#haptic)
    - [Present Side](#present-side)
- [Other Projects](#other-projects)
- [Russian Community](#russian-community)

## Installation

Ready for use on iOS 12+, tvOS 12+. Works with Swift 5+. Required Xcode 12.5 and higher.

<img align="right" src="https://github.com/ivanvorobei/SPIndicator/blob/main/Assets/Readme/spm-install-preview.png" width="520"/>

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `SPIndicator` into your Xcode project using Xcode 12, specify it in `File > Swift Packages > Add Package Dependency...`:

```ogdl
https://github.com/ivanvorobei/SPIndicator
```

### CocoaPods:

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate `SPIndicator` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SPIndicator'
```

### Manually

If you prefer not to use any of dependency managers, you can integrate `SPIndicator` into your project manually. Put `Sources/SPIndicator` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

<img align="right" src="https://github.com/ivanvorobei/SPIndicator/blob/main/Assets/Readme/error-preview.svg" width="270"/>

## Quick Start

For best experience, I recommend presenting indicator by calling the class functions `SPIndicator`. These functions are updated regularly and show the indicator as Apple way: 

```swift
SPIndicator.present(title: "Error", message: "Try Again", preset: .error)
```

For using a custom image:

```swift 
let image = UIImage.init(systemName: "sun.min.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
SPIndicator.present(title: "Custom Image", message: "With tint color", preset: .custom(image)))
```

<img align="left" src="https://github.com/ivanvorobei/SPIndicator/blob/main/Assets/Readme/message-only-preview.svg" width="210"/>

For showing a simple text message:

```swift 
SPIndicator.present(title: "Error", haptic: .error)
```
You can provide message optional too.

## Usage

### Duration

For change duration of present time, create indicator view and call `present` method with custom duration:

```swift
let indicatorView = SPIndicatorView(title: "Complete", preset: .done)
indicatorView.present(duration: 3)
```

### Layout

For customise layout and margins, use `layout` property. You can manage margins for each side, icon size and space between image and titles:

```swift
indicatorView.layout.iconSize = .init(width: 24, height: 24)
indicatorView.layout.margins.top = 12
```

### Dismiss by Drag

By default allow drag indicator for hide. While indicator is dragging, dismiss not work. This can be disabled:

```swift
indicatorView.dismissByDrag = false
```

### Haptic

For manage haptic, you shoud pass it in present method:

```swift
indicatorView.present(duration: 1.5, haptic: .success, completion: nil)
```

You can remove duration and completion, its have default values.

### Present Side

If you need present from special side, use this: 

```swift
SPIndicator.present(title: "Error", message: "Try Again", preset: .error, from: .bottom)

// or with custom view

indicatorView.presentSide = .bottom
```
In last cases indicator will appear from bottom and attached to bottom. For manage offset check property `offset`.

## Other Projects

#### [SPPermissions](https://github.com/ivanvorobei/SPPermissions)
Using for request and check state of permissions. Available native UI for request multiple permissions at the same time. Simple integration and usage like 2 lines code.

#### [SPAlert](https://github.com/ivanvorobei/SPAlert)
You can find this alerts in AppStore after feedback or after added song to library in Apple Music. Contains popular Done, Heart presets and many other. Done preset present with draw path animation like original. Also available simple present message without icon. Usage in one line code.

#### [SPPerspective](https://github.com/ivanvorobei/SPPerspective)
Animation of widgets from iOS 14. 3D transform with dynamic shadow. [Video preview](https://ivanvorobei.by/github/spperspective/video-preview). Available deep customisation 3D and shadow. Also you can use static transform without animation.

#### [SPDiffable](https://github.com/ivanvorobei/SPDiffable)
Simplifies working with animated changes in table and collections. Apple's diffable API required models for each object type. If you want use it in many place, you pass time to implement it and get over duplicates codes. This project help do it elegant with shared models and special cell providers. Support side bar iOS14 and already has native cell providers and views.

#### [SparrowKit](https://github.com/ivanvorobei/SparrowKit)
Collection of native Swift extensions to boost your development. Support tvOS and watchOS.

## Russian Community

В телеграм-канале [Код Воробья](https://sparrowcode.by/telegram) пишу о iOS разработке. Помощь можно найти в [нашем чате](https://sparrowcode.by/telegram/chat).
Видео-туториалы выклыдываю на [YouTube](https://sparrowcode.by/youtube):

[![Tutorials on YouTube](https://cdn.ivanvorobei.by/github/readme/youtube-preview.jpg)](https://sparrowcode.by/youtube)
