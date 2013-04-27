//
//  AGMedallionView.h
//  AGMedallionView
//
//  Modified by Charles Powell on 3/6/12
//
//  Created by Artur Grigor on 1/23/12.
//  Copyright (c) 2012 Artur Grigor. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import <UIKit/UIKit.h>

typedef enum
{
    AGMedallionStyleOriginal = 0,
    AGMedallionStyleSquare

} AGMedallionStyle;

@interface AGMedallionView : UIControl
{
    AGMedallionStyle style;
    CGFloat borderWidth;
    CGGradientRef borderGradient;
    CGFloat cornerRadius;
    BOOL addShine;
    CGSize shadowOffset;
    CGFloat shadowBlur;

    // Private
    UIControl *touchableControl;
    CGGradientRef alphaGradient;
}

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *shadowColor;

@property (nonatomic, assign) AGMedallionStyle style;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic) CGGradientRef borderGradient;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) BOOL addShine;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGFloat shadowBlur;
@property (nonatomic, assign) BOOL clipShadow;

@end
