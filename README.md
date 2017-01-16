# KWVerificationCodeView

[![Build Status](https://www.bitrise.io/app/df05a5313a9741ef.svg?token=NNC-GCKiEh6G4w7MJ6bM5Q&branch=master)](https://www.bitrise.io/app/df05a5313a9741ef)
[![Version](https://img.shields.io/cocoapods/v/KWVerificationCodeView.svg?style=flat)](http://cocoapods.org/pods/KWVerificationCodeView)
[![License](https://img.shields.io/cocoapods/l/KWVerificationCodeView.svg?style=flat)](http://cocoapods.org/pods/KWVerificationCodeView)
[![Platform](https://img.shields.io/cocoapods/p/KWVerificationCodeView.svg?style=flat)](http://cocoapods.org/pods/KWVerificationCodeView)

A customisable verification code view with built in validation. Can be used for one time passwords (OTPs), email verification codes etc.

![Screenshot](Screenshots/KWVerificationCodeView.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 8 or later
- Swift 3.0

## Installation

KWVerificationCodeView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "KWVerificationCodeView"
```
## Usage

Add a `UIView` in your *Storyboard* and change the class to `KWVerificationCodeView`. You can set the properties in the *Attributes Inspector* and see a live preview:

![Interface Builder Screenshot](Screenshots/interfacebuilder.png)

It is possile to set the default and selected colors of the underline in the *Storyboard*.

### Methods

`hasValidCode() -> Bool` - Returns true when the entered code is valid.

`getVerificationCode() -> String` - Returns the validation code. 

### Delegate

`KWVerificationCodeViewDelegate` has a method `didChangeVerificationCode()`, which you can implement to check for valid code in real time. This comes handy in stituations where you have to enable the submit button only if the verification code is valid.

## Author

KeepWorks, ios@keepworks.com

## Credits

KWVerificationCodeView is owned and maintained by [KeepWorks](http://www.keepworks.com/).

[![N|Solid](http://www.keepworks.com/assets/logo-800bbf55fabb3427537cf669dc8cd018.png)](http://www.keepworks.com/)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/keepworks/KWVerificationCodeView.

## License

KWVerificationCodeView is available under the [MIT License](http://opensource.org/licenses/MIT). See the [License](https://github.com/keepworks/KWVerificationCodeView/blob/master/LICENSE) file for more info.
