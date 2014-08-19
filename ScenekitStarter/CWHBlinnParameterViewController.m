//
//  CWHBlinnParameterViewController.m
//  ScenekitStarter
//
//  Created by Super on 8/15/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHBlinnParameterViewController.h"

@interface CWHBlinnParameterViewController ()

@end

@implementation CWHBlinnParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)updateLightColor:(id)sender {
    NSColorWell *colorWell = sender;
    NSColor *color = [colorWell color];
    
    self.lightColor = color;
    [self updateShaderValues];
}

- (IBAction)updateAmbientColor:(id)sender {
    NSColorWell *colorWell = sender;
    NSColor *color = [colorWell color];
    
    self.ambientColor = color;
    [self updateShaderValues];
}

-(void)updateShaderValues
{
    CWHBlinnProgram *program = [CWHBlinnProgram program];
    
    program.lightColor = self.lightColor;
    program.ambientColor = self.ambientColor;
    
    [self.delegate updateShaderValues:program];
}

@end
