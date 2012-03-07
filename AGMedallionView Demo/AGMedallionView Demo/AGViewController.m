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

@synthesize medallionView;

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
    
    self.medallionView.image = [UIImage imageNamed:@"sample"];
    [self.medallionView addTarget:self action:@selector(medallionDidTap:) forControlEvents:UIControlEventTouchUpInside];
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
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tap" message:@"Medallion has been tapped." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
    if (self.medallionView.style == AGMedallionStyleOriginal) {
        
        self.medallionView.style = AGMedallionStyleSquare;
        self.medallionView.cornerRadius = 20.0f;
        self.medallionView.addShine = NO;
        self.medallionView.shadowOffset = CGSizeMake(0.0, 1.0);
        self.medallionView.shadowBlur = 5.0f;
        
        CGFloat colors[8] = {0.925, 0.953, 0.992, 1.000, 0.451, 0.482, 0.522, 1.000};
        CGFloat colorStops[2] = {1.f, 0.f};
        CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef newGradient = CGGradientCreateWithColorComponents(rgbColorSpace, colors, colorStops, 2);
        self.medallionView.borderGradient = newGradient;
        
    } else if (self.medallionView.style == AGMedallionStyleSquare) {
        
        self.medallionView.style = AGMedallionStyleOriginal;
        self.medallionView.addShine = YES;
        
    }
    
}

@end
