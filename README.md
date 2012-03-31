## AGMedallionView

cbpowell/AGMedallionView is a bordered image view for iOS, with a customizable border (color/gradient/shadow). This version is forked from AGMedallionView, which was created as a picture view control just like the one that Apple is using at the login screen in Mac OS X Lion.

![Screenshot](http://cbpowell.github.com/AGMedallionView/AGMedallionViewImage.png)

## Installation

Copy over the files from the Classes folder to your project folder.

## Usage

Wherever you want to use AGMedallionView, import the appropriate header file and initialize as follows:

```objective-c
#import "AGMedallionView.h"
```

### Basic

```objective-c
AGMedallionView *medallionView = [[AGMedallionView alloc] init];
medallionView.image = [UIImage imageNamed:@"sample"];
[self.view addSubview:medallionView];
[medallionView release];
```

To use a rounded rect medallion, initialize as follows:

```objective-c
AGMedallionView *medallionView = [[AGMedallionView alloc] init];
medallionView.style = AGMedallionStyleSquare;
medallionView.cornerRadius = 20.0f;
medallionView.image = [UIImage imageNamed:@"sample"];
[self.view addSubview:medallionView];
[medallionView release];
```

You can also specify a gradient for the medallion border by specifying a CGGradientRef as shown:

```objective-c
CGFloat colors[8] = {0.925, 0.953, 0.992, 1.000, 0.451, 0.482, 0.522, 1.000};
CGFloat colorStops[2] = {1.f, 0.f};
CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
CGGradientRef newGradient = CGGradientCreateWithColorComponents(rgbColorSpace, colors, colorStops, 2);
medallionView.borderGradient = newGradient;
```

The shadow color, blur, and offset can be manipulated as follows if the defaults aren't to your liking:
```objective-c
medallionView.shadowColor = [UIColor grayColor];
medallionView.shadowBlur = 3.0f;
medallionView.shadowOffset = CGSizeMake(2.0, 2.0);
```

The shadow is drawn both inside the border ontop of the image, and outside the border above anything below AGMedallionView. If you don't want the shadow drawn outside the border, set `medallionView.clipShadow = YES`. The default for `clipShadow` is `NO`.

If `clipShadow` is set to `NO`, AGMedallionView will resize automatically in order to contain the shadow completely. __NOTE__: this will result in the contained image being smaller, relative to the frame you specify for the view. The image/border will also no longer be in the absolute center of the frame.

## Todo
- Depending on the background color and the image, sometimes the background can bleed through.


## Contact

Charles Powell
- [GitHub](http://github.com/cbpowell)
- [Twitter](http://twitter.com/seventhcolumn)

Artur Grigor (original creator of [AGMedallionView](https://github.com/arturgrigor/AGMedallionView))
- [GitHub](http://github.com/arturgrigor)
- [Twitter](http://twitter.com/arturgrigor)

Let me (us) know if you're using or enjoying this code!