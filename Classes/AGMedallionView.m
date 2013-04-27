//
//  AGMedallionView.m
//  AGMedallionView
//
//  Modified by Charles Powell on 3/6/12.
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

#import "AGMedallionView.h"

@interface AGMedallionView (Private)

// Helper methods
- (void)setup;

// Helper functions
void addRoundedRect(CGContextRef ctx, CGRect rect, float cornerRadius);

@end

@implementation AGMedallionView

#pragma mark - Properties

@synthesize style, borderWidth, borderGradient, cornerRadius, addShine, shadowOffset, shadowBlur, clipShadow;

- (void)setShadowOffset:(CGSize)aShadowOffset
{
    if (!CGSizeEqualToSize(shadowOffset, aShadowOffset)) {
        shadowOffset.width = aShadowOffset.width;
        shadowOffset.height = aShadowOffset.height;

        [self setNeedsDisplay];
    }
}

- (void)setShadowBlur:(CGFloat)aShadowBlur
{
    if (shadowBlur != aShadowBlur) {
        shadowBlur = aShadowBlur;

        [self setNeedsDisplay];
    }
}

#pragma mark - Object Lifecycle

- (void)setup
{
    alphaGradient = NULL;

    self.addShine = YES;
    self.borderColor = [UIColor whiteColor];
    self.borderWidth = 5.f;
    self.shadowColor = [UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:.75f];
    self.shadowOffset = CGSizeMake(0, 1);
    self.shadowBlur = 2.f;
    self.clipShadow = NO;
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 128.f, 128.f)];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }

    return self;
}

#pragma mark - Drawing

- (CGGradientRef)alphaGradient
{
    if (NULL == alphaGradient) {
        CGFloat colors[6] = {1.f, 0.75f, 1.f, 0.f, 0.f, 0.f};
        CGFloat colorStops[3] = {1.f, 0.35f, 0.f};
        CGColorSpaceRef grayColorSpace = CGColorSpaceCreateDeviceGray();
        alphaGradient = CGGradientCreateWithColorComponents(grayColorSpace, colors, colorStops, 3);
        CGColorSpaceRelease(grayColorSpace);
    }

    return alphaGradient;
}

- (void)drawRect:(CGRect)rect
{
    // Image rect
    CGRect imageRect, borderRect;
    // These are the absolute largest possible given the specified frame
    imageRect = CGRectInset(self.bounds, self.borderWidth, self.borderWidth);
    borderRect = CGRectInset(self.bounds, self.borderWidth/2, self.borderWidth/2);
    if (!self.clipShadow) {
        // Not clipping shadow

        // Calculate rect required to contain original rects with a blurred edge plus offset
        // Assumption: the shadow blur would take a 1px line and make it 3px, so inset by negative the shadow blur
        CGRect shadowRect = CGRectOffset(CGRectInset(borderRect, -self.shadowBlur, -self.shadowBlur), self.shadowOffset.width * self.shadowBlur, self.shadowOffset.height * self.shadowBlur);
        // Create insets based on differences of edges
        UIEdgeInsets resizingInsets = UIEdgeInsetsMake(fabs(CGRectGetMinY(shadowRect) - CGRectGetMinY(self.bounds)),
                                                       fabs(CGRectGetMinX(shadowRect) - CGRectGetMinX(self.bounds)),
                                                       fabs(CGRectGetMaxY(shadowRect) - CGRectGetMaxY(self.bounds)),
                                                       fabs(CGRectGetMaxX(shadowRect) - CGRectGetMaxX(self.bounds)));

        // Resize image and border rects with insets
        imageRect = UIEdgeInsetsInsetRect(imageRect, resizingInsets);
        borderRect = UIEdgeInsetsInsetRect(borderRect, resizingInsets);
    }

    // Start working with the mask
    CGColorSpaceRef maskColorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef mainMaskContextRef = CGBitmapContextCreate(NULL,
                                                        self.bounds.size.width,
                                                        self.bounds.size.height,
                                                        8,
                                                        self.bounds.size.width,
                                                        maskColorSpaceRef,
                                                        0);

    CGContextRef shineMaskContextRef = CGBitmapContextCreate(NULL,
                                                             rect.size.width,
                                                             rect.size.height,
                                                             8,
                                                             rect.size.width,
                                                             maskColorSpaceRef,
                                                             0);
    CGColorSpaceRelease(maskColorSpaceRef);
    CGContextSetFillColorWithColor(mainMaskContextRef, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(shineMaskContextRef, [UIColor blackColor].CGColor);
    CGContextFillRect(mainMaskContextRef, rect);
    CGContextFillRect(shineMaskContextRef, rect);
    CGContextSetFillColorWithColor(mainMaskContextRef, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(shineMaskContextRef, [UIColor whiteColor].CGColor);

    // Create main mask shape
    CGContextMoveToPoint(mainMaskContextRef, 0, 0);
    if (self.style == AGMedallionStyleSquare && self.cornerRadius > 0.0f) {
        addRoundedRect(mainMaskContextRef, borderRect, self.cornerRadius);
    } else {
        CGContextAddEllipseInRect(mainMaskContextRef, imageRect);
    }
    CGContextFillPath(mainMaskContextRef);

    // Create shine mask shape
    CGContextTranslateCTM(shineMaskContextRef, -(rect.size.width / 4), rect.size.height / 4 * 3);
    CGContextRotateCTM(shineMaskContextRef, -45.f);
    CGContextMoveToPoint(shineMaskContextRef, 0, 0);
    CGFloat shineHeight;
    if (self.style == AGMedallionStyleSquare && self.cornerRadius > 0.0f) {
        shineHeight = rect.size.height * 1.5;
    } else {
        shineHeight = rect.size.height;
    }
    CGContextFillRect(shineMaskContextRef, CGRectMake(0,
                                                      0,
                                                      rect.size.width / 8 * 5,
                                                      shineHeight));

    CGImageRef mainMaskImageRef = CGBitmapContextCreateImage(mainMaskContextRef);
    CGImageRef shineMaskImageRef = CGBitmapContextCreateImage(shineMaskContextRef);
    CGContextRelease(mainMaskContextRef);
    CGContextRelease(shineMaskContextRef);
    // Done with mask context

    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextRef);

    CGContextTranslateCTM(contextRef, 0, rect.size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);

    CGContextSaveGState(contextRef);

    // Draw image
    CGContextClipToMask(contextRef, self.bounds, mainMaskImageRef);
    CGContextDrawImage(contextRef, imageRect, self.image.CGImage);

    CGContextRestoreGState(contextRef);
    CGContextSaveGState(contextRef);

    // Clip to shine's mask
    CGContextClipToMask(contextRef, self.bounds, mainMaskImageRef);
    CGContextClipToMask(contextRef, self.bounds, shineMaskImageRef);
    CGContextSetBlendMode(contextRef, kCGBlendModeLighten);
    if (self.addShine) {
        CGContextDrawLinearGradient(contextRef, [self alphaGradient], CGPointMake(0, 0), CGPointMake(0, self.bounds.size.height), 0);
    }
    CGImageRelease(mainMaskImageRef);
    CGImageRelease(shineMaskImageRef);
    // Done with image

    CGContextRestoreGState(contextRef);



    if (self.borderGradient != NULL) {
        CGContextMoveToPoint(contextRef, 0, 0);

        if (self.clipShadow) {
            // Add slightly expanded paths equating to outer border
            if (self.style == AGMedallionStyleSquare && self.cornerRadius > 0.0f) {
                addRoundedRect(contextRef,
                               CGRectInset(borderRect, -self.borderWidth/2, -self.borderWidth/2),
                               self.cornerRadius + (float)self.borderWidth/2);

            } else {
                CGContextAddEllipseInRect(contextRef, CGRectInset(borderRect,
                                                                  -self.borderWidth/2,
                                                                  -self.borderWidth/2));
            }
            // Apply path to clip
            CGContextClip(contextRef);
        }

        // Draw sub-path for the shadow
        // Save state to restore after
        CGContextSaveGState(contextRef);

        // Setup path for clipping
        CGContextSetLineWidth(contextRef, self.borderWidth);
        if (self.style == AGMedallionStyleSquare && self.cornerRadius > 0.0f) {
            addRoundedRect(contextRef, borderRect, self.cornerRadius);
        } else {
            CGContextAddEllipseInRect(contextRef, borderRect);
        }

        CGContextSetLineWidth(contextRef, MAX(self.borderWidth, 0));

        // Convert to stroked path and clip
        CGContextReplacePathWithStrokedPath(contextRef);
        CGContextAddRect(contextRef, self.bounds);
        CGContextEOClip(contextRef);

        // Setup path for shadow drawing
        CGContextSetLineWidth(contextRef, self.borderWidth);
        if (self.style == AGMedallionStyleSquare && self.cornerRadius > 0.0f) {
            addRoundedRect(contextRef, borderRect, self.cornerRadius);
        } else {
            CGContextAddEllipseInRect(contextRef, borderRect);
        }

        CGContextSetLineWidth(contextRef, MAX(self.borderWidth - 1.0, 0));
        CGContextSetStrokeColorWithColor(contextRef, [UIColor whiteColor].CGColor);
        CGContextSetShadowWithColor(contextRef,
                                    self.shadowOffset,
                                    self.shadowBlur,
                                    self.shadowColor.CGColor);

        CGContextStrokePath(contextRef);

        CGContextRestoreGState(contextRef);


        // Recreate path in context
        CGContextMoveToPoint(contextRef, 0, 0);
        CGContextSetLineWidth(contextRef, self.borderWidth);
        if (self.style == AGMedallionStyleSquare) {
            addRoundedRect(contextRef, borderRect, self.cornerRadius);
        } else {
            CGContextAddEllipseInRect(contextRef, borderRect);
        }
        // Create fillable path
        CGContextReplacePathWithStrokedPath(contextRef);
        CGContextClip(contextRef);
        // Draw border gradient
        CGContextDrawLinearGradient(contextRef, self.borderGradient, CGPointMake(0, 0), CGPointMake(0, self.bounds.size.height), 0);

    } else {

        CGContextMoveToPoint(contextRef, 0, 0);
        if (self.clipShadow) {
            // Add slightly expanded paths equating to outer border
            if (self.style == AGMedallionStyleSquare && self.cornerRadius > 0.0f) {
                addRoundedRect(contextRef,
                               CGRectInset(borderRect, -self.borderWidth/2, -self.borderWidth/2),
                               self.cornerRadius + (float)self.borderWidth/2);

            } else {
                CGContextAddEllipseInRect(contextRef, CGRectInset(borderRect,
                                                                  -self.borderWidth/2,
                                                                  -self.borderWidth/2));
            }
            // Apply path to clip
            CGContextClip(contextRef);
        }

        CGContextSetLineWidth(contextRef, self.borderWidth);
        if (self.style == AGMedallionStyleSquare && self.cornerRadius > 0.0f) {
            addRoundedRect(contextRef, borderRect, self.cornerRadius);
        } else {
            CGContextAddEllipseInRect(contextRef, borderRect);
        }
        CGContextSetStrokeColorWithColor(contextRef, self.borderColor.CGColor);
        CGContextSetShadowWithColor(contextRef,
                                    self.shadowOffset,
                                    self.shadowBlur,
                                    self.shadowColor.CGColor);
        CGContextStrokePath(contextRef);
    }
     // Restore state
     CGContextRestoreGState(contextRef);
}

void addRoundedRect(CGContextRef ctx, CGRect rect, float cornerRadius) {
    if (cornerRadius <= 2.0) {
        CGContextAddRect(ctx, rect);
    } else {
        float x_left = rect.origin.x;
        float x_left_center = x_left + cornerRadius;
        float x_right_center = x_left + rect.size.width - cornerRadius;
        float x_right = x_left + rect.size.width;
        float y_top = rect.origin.y;
        float y_top_center = y_top + cornerRadius;
        float y_bottom_center = y_top + rect.size.height - cornerRadius;
        float y_bottom = y_top + rect.size.height;
        /* Begin path */
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, x_left, y_top_center);
        /* First corner */
        CGContextAddArcToPoint(ctx, x_left, y_top, x_left_center, y_top, cornerRadius);
        CGContextAddLineToPoint(ctx, x_right_center, y_top);
        /* Second corner */
        CGContextAddArcToPoint(ctx, x_right, y_top, x_right, y_top_center, cornerRadius);
        CGContextAddLineToPoint(ctx, x_right, y_bottom_center);
        /* Third corner */
        CGContextAddArcToPoint(ctx, x_right, y_bottom, x_right_center, y_bottom, cornerRadius);
        CGContextAddLineToPoint(ctx, x_left_center, y_bottom);
        /* Fourth corner */
        CGContextAddArcToPoint(ctx, x_left, y_bottom, x_left, y_bottom_center, cornerRadius);
        CGContextAddLineToPoint(ctx, x_left, y_top_center);
        /* Done */
        CGContextClosePath(ctx);
    }
}

@end
