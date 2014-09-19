//
//  CWHLUTSkinParameterViewController.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 9/12/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHLUTSkinParameterViewController.h"

@interface CWHLUTSkinParameterViewController ()

@end

@implementation CWHLUTSkinParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.program){
        NSColor *diffuseColor = [self.program valueForKey:@"diffuseColor"];
       
        if (diffuseColor) {
            [self.diffuseColorWell setColor:diffuseColor];
          
        }
        
        NSColor *specularColor = [self.program valueForKey:@"specularColor"];
        
        if (specularColor) {
            [self.diffuseColorWell setColor:specularColor];
            
        }
        NSColor *scatterColor = [self.program valueForKey:@"scatterColor"];
        
        if (scatterColor) {
            [self.diffuseColorWell setColor:scatterColor];
            
        }

        double wrap = [[self.program valueForKey:@"wrap"] doubleValue];
        
        if (wrap >= 0) {
            [self.wrapSlider setDoubleValue:wrap];
            [self.wrapTextField setDoubleValue:wrap];
            
        }
     
        
        double scatterWidth = [[self.program valueForKey:@"scatterWidth"] doubleValue];
        if (scatterWidth >= 0) {
            [self.scatterWidthSlider setDoubleValue:scatterWidth];
            [self.scatterWidthTextField setDoubleValue:scatterWidth];

        }
        
        double shininess = [[self.program valueForKey:@"shininess"] doubleValue];
        if (shininess) {
            [self.shininessSlider setDoubleValue:shininess];
            [self.shininessTextField setDoubleValue:shininess];
            
        }
    }
}

- (IBAction)updateWrap:(id)sender {
    if ([sender isKindOfClass:[NSSlider class]]) {
       [self.wrapTextField setDoubleValue:[sender doubleValue]];
    }else{
       [self.wrapSlider setDoubleValue:[sender doubleValue]];
    }
    
    [self updateShaderValues];
}

- (IBAction)updateScatterWidth:(id)sender {
    if ([sender isKindOfClass:[NSSlider class]]) {
        [self.scatterWidthTextField setDoubleValue:[sender doubleValue]];
    }else{
        [self.scatterWidthSlider setDoubleValue:[sender doubleValue]];
    }
    
    [self updateShaderValues];
}

- (IBAction)updateShininess:(id)sender {
    if ([sender isKindOfClass:[NSSlider class]]) {
        [self.shininessTextField setDoubleValue:[sender doubleValue]];
    }else{
        [self.shininessSlider setDoubleValue:[sender doubleValue]];
    }
    [self updateShaderValues];
}

- (IBAction)updateDiffuseColor:(id)sender {
    [self updateShaderValues];
}

- (IBAction)updateSpecularColor:(id)sender {
    [self updateShaderValues];
}

- (IBAction)updateScatterColor:(id)sender {
    [self updateShaderValues];
}

-(void)updateShaderValues
{
    
    CWHLUTSkinProgram *program = [CWHLUTSkinProgram program];
    

    program.diffuseColor = [self.diffuseColorWell color];
    program.specularColor = [self.specularColorWell color];
    program.scatterColor = [self.scatterColorWell color];
    program.wrap = [self.wrapSlider  doubleValue];
    program.scatterWidth = [self.scatterWidthSlider  doubleValue];
    program.shininess  = [self.shininessSlider  doubleValue];
    
    [self.delegate updateShaderValues:program];
}

@end
