//
//  CWHGoochParameterViewController.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/12/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHGoochParameterViewController.h"

@interface CWHGoochParameterViewController ()

@end

@implementation CWHGoochParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    if(self.program){
        
        NSColor *surfaceColor = [self.program valueForKey:@"surfaceColor"];
        if (surfaceColor) {
            [self.surfaceColorWell setColor:surfaceColor];
            self.surfaceColor= surfaceColor;
        }
        
        
        double diffuseWarm= [[self.program valueForKey:@"diffuseWarm"] doubleValue];
        if (diffuseWarm) {
            [self.diffuseWarmSlider setDoubleValue:diffuseWarm];
            [self.diffuseWarmTextField setDoubleValue:diffuseWarm];
            self.diffuseWarm = diffuseWarm;
        }
        
        double diffuseCool = [[self.program valueForKey:@"diffuseCool"] doubleValue];
       
        [self.diffuseCoolSlider setDoubleValue:diffuseCool];
        [self.diffuseCoolTextField setDoubleValue:diffuseCool];
        self.diffuseCool = diffuseCool;
        

        NSColor *warmColor  = [self.program valueForKey:@"warmColor"];
        if (warmColor ) {
            [self.warmColorWell setColor:warmColor ];
            self.warmColor  = warmColor ;
        }
        
        NSColor *coolColor = [self.program valueForKey:@"coolColor"];
        if (coolColor) {
            [self.coolColorWell setColor:coolColor];
            self.coolColor = coolColor;
        }
    }
    
}

-(void)viewDidDisappear
{

}

- (IBAction)updateSurfaceColor:(id)sender {

    NSColorWell *colorWell = sender;
    NSColor *color = [colorWell color];
    
    self.surfaceColor = color;
    [self updateShaderValues];
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
    program.surfaceColor = self.surfaceColor;
    program.warmColor = self.warmColor;
    program.coolColor = self.coolColor;
    program.diffuseCool = self.diffuseCool;
    program.diffuseWarm = self.diffuseWarm;
    
    [self.delegate updateShaderValues:program];
}


@end
