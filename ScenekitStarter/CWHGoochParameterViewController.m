//
//  CWHGoochParameterViewController.m
//  ScenekitStarter
//
//  Created by Super on 8/12/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHGoochParameterViewController.h"

@interface CWHGoochParameterViewController ()

@end

@implementation CWHGoochParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

-(void)viewDidDisappear
{
    [self.delegate parameterViewDidClose];
    self.delegate  = nil;
}

- (IBAction)updateCoolColor:(id)sender {
    NSColorWell *colorWell = sender;
    NSColor *color = [colorWell color];
    
    self.coolColor = color;
    [self updateShaderValues];
}

- (IBAction)updateWarmColor:(id)sender {
    NSColorWell *colorWell = sender;
    NSColor *color = [colorWell color];
    
    self.warmColor = color;
    [self updateShaderValues];
    
}

- (IBAction)updateDiffuseCool:(id)sender {
    
    NSSlider *slider = sender;
    double value = [slider doubleValue];
    
    self.diffuseCool = value;
    [self.diffuseCoolTextField setDoubleValue:value];
    
    [self updateShaderValues];
}

- (IBAction)updateDiffuseWarm:(id)sender {
    NSSlider *slider = sender;
    double value = [slider doubleValue];
    
    self.diffuseWarm = value;
    [self.diffuseWarmTextField setDoubleValue:value];
    
    [self updateShaderValues];
}

-(void)updateShaderValues
{
    CWHGoochProgram *program = [CWHGoochProgram program];
    program.warmColor = self.warmColor;
    program.coolColor = self.coolColor;
    program.diffuseCool = self.diffuseCool;
    program.diffuseWarm = self.diffuseWarm;
    
    [self.delegate updateShaderValues];
}

@end
