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
    UIImage *image;
    UIColor *borderColor;
    CGFloat borderWidth;
    CGGradientRef borderGradient;
    CGFloat cornerRadius;
    UIColor *shadowColor;
    CGSize shadowOffset;
    CGFloat shadowBlur;
    
    // Private
    UIControl *touchableControl;
    CGGradientRef alphaGradient;
}

@property (nonatomic, assign) AGMedallionStyle style;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGGradientRef borderGradient;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, retain) UIColor *shadowColor;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGFloat shadowBlur;

@end
