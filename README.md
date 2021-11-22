# SPIndicator

<img align="left" src="https://github.com/ivanvorobei/SPIndicator/blob/main/Assets/Readme/preview-v1.jpg" width="360"/>

### About

Mimicrate to indicator which appear when silent mode turn on / off. Availalbe 2 animated presets: `done` & `error`.  Also support custom images and present from top, center & bottom side.

For get alert like in Apple music, use library [SPAlert](https://github.com/ivanvorobei/SPAlert).

If you like the project, don't forget to `put star ★`<br>Check out my other libraries:

<p float="left">
    <a href="https://opensource.ivanvorobei.by">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/more-libraries.svg">
    </a>
</p>

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
- [Russian Community](#russian-community)

## Installation

Ready for use on iOS 12+, tvOS 12+. Works with Swift 5+. Required Xcode 12.0 and higher.

<img align="right" src="https://github.com/ivanvorobei/SPIndicator/blob/main/Assets/Readme/spm-install-preview.png" width="520"/>

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Once you have your Swift package set up, adding as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/ivanvorobei/SPIndicator", .upToNextMajor(from: "1.4.2"))
]
```

### CocoaPods:

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SPIndicator'
```

### Manually

If you prefer not to use any of dependency managers, you can integrate manually. Put `Sources/SPIndicator` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

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

## Russian Community

Подписывайся в телеграм-канал, если хочешь получать уведомления о новых туториалах.<br>
Со сложными и непонятными задачами помогут в чате.

<p float="left">
    <a href="https://sparrowcode.by/telegram">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/open-telegram-channel.svg">
    </a>
    <a href="https://sparrowcode.by/telegram/chat">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/russian-community-chat.svg">
    </a>
</p>

Видео-туториалы выклыдываю на [YouTube](https://ivanvorobei.by/youtube):

[![Tutorials on YouTube](https://cdn.ivanvorobei.by/github/readme/youtube-preview.jpg)](https://ivanvorobei.by/youtube)
