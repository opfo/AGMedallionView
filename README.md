## AGMedallionView

AGMedallionView is a picture view control just like the one that Apple is using at the login screen in Mac OS X Lion.

![Screenshot](http://dl.dropbox.com/u/2387405/Screenshots/AGMedallionView.png)

## Installation

Copy over the files from the Classes folder to your project folder.

## Usage

Wherever you want to use AGMedallionView, import the appropriate header file and initialize as follows:

``` objective-c
#import "AGMedallionView.h"
```

### Basic

``` objective-c
AGMedallionView *medallionView = [[AGMedallionView alloc] init];
medallionView.image = [UIImage imageNamed:@"sample"];
[self.view addSubview:medallionView];
[medallionView release];
```

To use a rounded rect medallion, initialize as follows:

``` objective-c
AGMedallionView *medallionView = [[AGMedallionView alloc] init];
medallionView.style = AGMedallionStyleSquare;
medallionView.cornerRadius = 20.0f;
medallionView.image = [UIImage imageNamed:@"sample"];
[self.view addSubview:medallionView];
[medallionView release];
```

You can also specify a gradient for the medallion border by specifying a CGGradientRef as shown:

``` objective-c
CGFloat colors[8] = {0.925, 0.953, 0.992, 1.000, 0.451, 0.482, 0.522, 1.000};
CGFloat colorStops[2] = {1.f, 0.f};
CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
CGGradientRef newGradient = CGGradientCreateWithColorComponents(rgbColorSpace, colors, colorStops, 2);
medallionView.borderGradient = newGradient;
```

## Contact

- [GitHub](http://github.com/arturgrigor)
- [Twitter](http://twitter.com/arturgrigor)

Let me know if you're using or enjoying this product.