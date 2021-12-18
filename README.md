# SPIndicator

<p aligment="left">
    <img src="https://cdn.ivanvorobei.by/github/spindicator/v1.6/animatable-presets.png?version=1" height="180"/>
    <img src="https://cdn.ivanvorobei.by/github/spindicator/v1.6/customize.png?version=1" height="180"/>
    <img src="https://cdn.ivanvorobei.by/github/spindicator/v1.6/bottom-present.png?version=1" height="180"/>
</p>

Mimicrate to indicator which appear when silent mode turn on / off. Availalbe 2 animated presets: `done` & `error`.  Also support custom images and present from top, center & bottom side. For get alert like in Apple music, use library [SPAlert](https://github.com/ivanvorobei/SPAlert).

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
    - [Shared Configuration](#shared-configuration)
- [Swift UI](#swift-ui)
- [Russian Community](#russian-community)

## Installation

Ready for use on iOS 12+ & tvOS 12+.

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Once you have your Swift package set up, adding as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/ivanvorobei/SPIndicator", .upToNextMajor(from: "1.6.0"))
]
```

### CocoaPods:

[CocoaPods](https://cocoapods.org) is a dependency manager. For usage and installation instructions, visit their website. To integrate using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SPIndicator'
```

### Manually

If you prefer not to use any of dependency managers, you can integrate manually. Put `Sources/SPIndicator` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## Quick Start

For best experience, I recommend presenting indicator by calling the class functions `SPIndicator`. These functions are updated regularly and show the indicator as Apple way: 

```swift 
// Presets:
SPIndicator.present(title: "Error", message: "Try Again", preset: .error)

// For show with custom image:
let image = UIImage.init(systemName: "sun.min.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
SPIndicator.present(title: "Custom Image", message: "With tint color", preset: .custom(image)))

// For show text only:
SPIndicator.present(title: "Error", haptic: .error)
```

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

// or for custom `SPIndicatorView`

indicatorView.presentSide = .bottom
```
In last cases indicator will appear from bottom and attached to bottom. For manage offset check property `offset`.

### Shared Configuration

Also you can change some default values for alerts. For example you can change default duration for alert with next code:

```swift
SPIndicatorView.appearance().duration = 2
```

It will apply for all alerts. I recomend set it in app delegate. But you can change it in runtime.

## SwiftUI

Use like system alert only show message tips:

```swift
Button("Show Indicator") {
    showIndicator = true
}.SPIndicator(isPresent: $showIndicator, title: "This is title only")
```

or show message, title, image and other configuration:

```swift
Button("Show Indicator") {
    showIndicator = true
}.SPIndicator(
    isPresent: $showIndicator, 
    title: "Title", 
    message: "Message",
    duration: 2.0, 
    presentSide: .top,
    dismissByDrag: false, 
    preset: .custom(UIImage(systemName: "heart")!), 
    haptic: .success, 
    layout: .init(), 
    completion: {
        print("Indicator is destoryed")
    })
```

## Russian Community

Я веду [телеграм-канал](https://sparrowcode.by/telegram), там публикую новости и туториалы.<br>
С проблемой помогут [в чате](https://sparrowcode.by/telegram/chat).

Видео-туториалы выклыдываю на [YouTube](https://ivanvorobei.by/youtube):

[![Tutorials on YouTube](https://cdn.ivanvorobei.by/github/readme/youtube-preview.jpg)](https://ivanvorobei.by/youtube)
