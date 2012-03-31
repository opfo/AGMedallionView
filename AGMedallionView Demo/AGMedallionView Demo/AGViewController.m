//
//  AGViewController.m
//  AGMedallionView Demo
//
//  Modified by Charles Powell on 3/6/12.
//
//  Created by Artur Grigor on 2/12/12.
//  Copyright (c) 2012 Artur Grigor. All rights reserved.
//

#import "AGViewController.h"

@interface AGViewController ()

- (void)medallionDidTap:(id)sender;

@end

@implementation AGViewController

#pragma mark - Properties

@synthesize medallionViewA, medallionViewB;

#pragma mark - Object Lifecycle

- (void)dealloc
{
    [medallionView release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.medallionViewA.image = [UIImage imageNamed:@"sample"];
    [self.medallionViewA addTarget:self action:@selector(medallionDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    self.medallionViewB.image = [UIImage imageNamed:@"sample"];
    [self.medallionViewB addTarget:self action:@selector(medallionDidTap:) forControlEvents:UIControlEventTouchUpInside];
    self.medallionViewB.style = AGMedallionStyleSquare;
    self.medallionViewB.cornerRadius = 20.0f;
    self.medallionViewB.addShine = NO;
    self.medallionViewB.shadowOffset = CGSizeMake(1.0, 2.0);
    self.medallionViewB.shadowBlur = 3.0f;
    self.medallionViewB.clipShadow = YES;
    
    CGFloat colors[8] = {0.925, 0.953, 0.992, 1.000, 0.451, 0.482, 0.522, 1.000};
    CGFloat colorStops[2] = {1.f, 0.f};
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef newGradient = CGGradientCreateWithColorComponents(rgbColorSpace, colors, colorStops, 2);
    self.medallionViewB.borderGradient = newGradient;
    CGGradientRelease(newGradient);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Private

- (void)medallionDidTap:(id)sender
{
    AGMedallionView *tappedView = (AGMedallionView *)sender;
    
    if (tappedView == self.medallionViewB) {
        
        tappedView.borderGradient = NULL;
        tappedView.cornerRadius = 10.0f;
        tappedView.addShine = YES;
        tappedView.shadowOffset = CGSizeMake(1.0, 2.0);
        tappedView.shadowBlur = 3.0f;
        tappedView.clipShadow = YES;
        
    } else {
        
        tappedView.addShine = NO;
        tappedView.clipShadow = YES;
        
        CGFloat colors[8] = {0.925, 0.953, 0.992, 1.000, 0.451, 0.482, 0.522, 1.000};
        CGFloat colorStops[2] = {1.f, 0.f};
        CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef newGradient = CGGradientCreateWithColorComponents(rgbColorSpace, colors, colorStops, 2);
        tappedView.borderGradient = newGradient;
        CGGradientRelease(newGradient);
        
    }
    
}

@end
