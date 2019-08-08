# MXParallaxBackground

[![CI Status](http://img.shields.io/travis/maxep/MXParallaxBackground.svg?style=flat)](https://travis-ci.org/maxep/MXParallaxBackground)
[![Version](https://img.shields.io/cocoapods/v/MXParallaxBackground.svg?style=flat)](http://cocoapods.org/pods/MXParallaxBackground)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/MXParallaxBackground.svg?style=flat)](http://cocoapods.org/pods/MXParallaxBackground)
[![Platform](https://img.shields.io/cocoapods/p/MXParallaxBackground.svg?style=flat)](http://cocoapods.org/pods/MXParallaxBackground)

MXParallaxBackground is a simple background class for UIScrolView.

|          Horizontal           |          Vertical           |
|-------------------------------|-----------------------------|
|![Demo](Examples/objective-c/Horizontal.gif)|![Demo](Examples/objective-c/Vertical.gif)|

## Usage

If you want to try it, simply run:

```
pod try MXParallaxBackground
```

Or clone the repo and run `pod install` from the Example directory first.

+ Adding a parallax background to a UIScrollView is straightforward, e.g:

<details open=1>
<summary>Swift</summary>

```swift
let imageView = UIImageView()
imageView.contentMode = .scaleAspectFill
imageView.image = UIImage(named: "Background")

let background = MXParallaxBackground()
background.view = imageView
background.intensity = 0.75

let scrollView = UIScrollView()
scrollView.add(background)
```
</details>

<details>
<summary>Objective-C</summary>

```objective-c
UIImageView *imageView = [UIImageView new];
imageView.contentMode = UIViewContentModeScaleAspectFill;
imageView.image = [UIImage imageNamed:@"Background"];
    
MXParallaxBackground *background = [MXParallaxBackground new];
background.view = imageView;
background.intensity = 0.75;

UIScrollView *scrollView = [UIScrollView new]; 
[scrollView addBackground:background];
```
</details>

## Installation

MXParallaxBackground is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MXParallaxBackground"
```

## Author

[Maxime Epain](http://maxep.github.io)

[![Twitter](https://img.shields.io/badge/twitter-%40MaximeEpain-blue.svg?style=flat)](https://twitter.com/MaximeEpain)

## Credits

Images are taken from [this](http://jonathannicol.com/blog/2011/08/06/build-a-parallax-scrolling-website-interface-with-jquery-and-css/) tutorial made by [Jonathan Nicol](https://github.com/jnicol).

## License

MXParallaxBackground is available under the MIT license. See the LICENSE file for more info.
