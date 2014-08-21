//
//  CWHHemisphereParameterViewController.m
//  ScenekitStarter
//
//  Created by Super on 8/21/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHHemisphereParameterViewController.h"

@interface CWHHemisphereParameterViewController ()

@end

@implementation CWHHemisphereParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)updateSkyColor:(id)sender {
    self.skyColor = [sender color];
    [self updateShaderValues];
}

- (IBAction)updateGroundColor:(id)sender {
    self.groundColor = [sender color];
    [self updateShaderValues];
}

-(void)updateShaderValues
{
    
    CWHHemisphereProgram *program = [CWHHemisphereProgram program];
    
    program.skyColor = self.skyColor;
    program.groundColor = self.groundColor;

    [self.delegate updateShaderValues:program];
}


@end
