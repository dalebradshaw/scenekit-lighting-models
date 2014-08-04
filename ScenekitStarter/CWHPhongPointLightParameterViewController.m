//
//  CWHPhongPointLightParameterViewController.m
//  ScenekitStarter
//
//  Created by Super on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHPhongPointLightParameterViewController.h"

@interface CWHPhongPointLightParameterViewController ()

@end

@implementation CWHPhongPointLightParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self.specularityTextField setDoubleValue:[self.specularitySlider doubleValue]];
    [self.shininessTextField setDoubleValue:[self.shininessSlider doubleValue]];
}
- (void)viewDidAppear
{
    
}

-(void)viewWillDisappear
{
}

-(void)viewDidDisappear
{
    [self.delegate parameterViewDidClose];
    self.delegate  = nil;
}

-(IBAction)setMaterialSpecularity:(id)sender
{
    NSSlider *slider = sender;
    double value = [slider doubleValue];
    [self.specularityTextField setDoubleValue:value];
}

-(IBAction)setShininess:(id)sender
{
    NSSlider *slider = sender;
    double value = [slider doubleValue];
    [self.shininessTextField setDoubleValue:value];
}

-(IBAction)setAmbientColor:(id)sender
{
    
}

-(IBAction)updateLightColor:(id)sender
{
    NSColorWell *colorWell = sender;
    NSColor *color = [colorWell color];

    self.lightColor = color;
    [self updateShaderValues];
}

-(void)updateShaderValues
{
    NSDictionary *values = @{@"light_color":self.lightColor};
    [self.delegate updateShaderValues:values];
}

@end
