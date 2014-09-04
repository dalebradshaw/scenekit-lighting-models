//
//  CWHPhongPointLightParameterViewController.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHPhongPointLightParameterViewController.h"

@interface CWHPhongPointLightParameterViewController ()

@end

@implementation CWHPhongPointLightParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    if(self.program){
        NSColor *ambientColor = [self.program valueForKey:@"ambientColor"];
        
        if (ambientColor) {
            [self.ambientColorWell setColor:ambientColor];
            self.ambientColor = ambientColor;
        }
        
        NSColor *lightColor = [self.program valueForKey:@"lightColor"];
        
        if(lightColor){
            [self.lightColorWell setColor:lightColor];
            self.lightColor = lightColor;
        }
        
        double shininess = [[self.program valueForKey:@"shininess"] doubleValue];
        if (shininess) {
            [self.shininessSlider setDoubleValue:shininess];
            [self.shininessTextField setDoubleValue:shininess];
            self.shininess = shininess;
        }
        
        double materialSpecularity = [[self.program valueForKey:@"materialSpecularity"] doubleValue];
        if (materialSpecularity) {
            [self.specularitySlider setDoubleValue:materialSpecularity];
            [self.specularityTextField setDoubleValue:materialSpecularity];
            self.materialSpecularity = materialSpecularity;
        }
    }
    
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
