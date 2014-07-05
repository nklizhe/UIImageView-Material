# UIImageView+Material

An experimental `UIImageView` category for loading images using the [Material Design](http://www.google.com/design/spec/patterns/imagery-treatment.html#) style.

## Usage

```
#import <UIImageView+Material/UIImageView+Material.h>

[imageView setImage:<your image>];
[imageView.layer setOpacity:0.0];

// fade in
[imageView fadeInWithDuration:1.0];

// fade out
[imageView fadeOutWithDuration:1.0];
```

## Installation

UIImageView+Material is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

pod "UIImageView+Material"

## Author

Tom Li, nklizhe@gmail.com

## License

UIImageView+Material is available under the MIT license. See the LICENSE file for more info.

