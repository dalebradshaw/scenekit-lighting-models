//
//  CWHLambSkinParameterViewController.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/21/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHLambSkinParameterViewController.h"

@interface CWHLambSkinParameterViewController ()

@end

@implementation CWHLambSkinParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)updateRolloff:(id)sender {
    self.rolloff = [sender doubleValue];
    if ([sender isKindOfClass:[NSSlider class]]) {
        [self.rolloffTextField setDoubleValue:[sender doubleValue]];
    }else{
        [self.rolloffSlider setDoubleValue:[sender doubleValue]];
    }
    
    [self updateShaderValues];
}

- (IBAction)updateAmbientColor:(id)sender {
    self.ambientColor = [sender color];
    [self updateShaderValues];
}

- (IBAction)updateDiffuseColor:(id)sender {
    self.diffuseColor = [sender color];
    [self updateShaderValues];
}

- (IBAction)updateSubColor:(id)sender {
    self.subColor = [sender color];
    [self updateShaderValues];
}

-(void)updateShaderValues
{
    
    CWHLambSkinProgram *program = [CWHLambSkinProgram program];
    
    program.rolloff = self.rolloff;
    program.ambientColor = self.ambientColor;
    program.diffuseColor = self.diffuseColor;
    
    [self.delegate updateShaderValues:program];
}
@end
