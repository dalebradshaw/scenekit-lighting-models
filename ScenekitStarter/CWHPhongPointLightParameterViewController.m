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
   
    self.ambientColor = [self.ambientColorWell color];
    self.lightColor = [self.lightColorWell color];
    self.materialSpecularity = [self.specularitySlider doubleValue];
    self.shininess = [self.shininessSlider doubleValue];

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

-(IBAction)updateMaterialSpecularity:(id)sender
{
    NSSlider *slider = sender;
    double value = [slider doubleValue];
    
    [self.specularityTextField setDoubleValue:value];
    self.materialSpecularity = value;
    
    [self updateShaderValues];
}

-(IBAction)updateShininess:(id)sender
{
    NSSlider *slider = sender;
    double value = [slider doubleValue];
    
    self.shininess = value;
    [self.shininessTextField setDoubleValue:value];
    
    [self updateShaderValues];
}

-(IBAction)updateAmbientColor:(id)sender
{
    NSColorWell *colorWell = sender;
    NSColor *color = [colorWell color];
    
    self.ambientColor = color;
    [self updateShaderValues];
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
   
    CWHPhongPointLightProgram *program = [CWHPhongPointLightProgram program];

    program.lightColor = self.lightColor;
    program.ambientColor = self.ambientColor;
    program.shininess = self.shininess;
    program.materialSpecularity = self.materialSpecularity;
    
    [self.delegate updateShaderValues:program];
}

@end
