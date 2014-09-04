//
//  CWHThinFilmParameterViewController.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 9/4/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHThinFilmParameterViewController.h"

@interface CWHThinFilmParameterViewController ()

@end

@implementation CWHThinFilmParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)updateFilmDepth:(id)sender {
    
}

- (IBAction)updateDiffuseColor:(id)sender {
    
}

-(void)updateShaderValues
{
    CWHThinFilmProgram *program = [CWHThinFilmProgram program];
    
    program.filmDepth= self.filmDepth;
    program.diffuseColor = self.diffuseColor;
    
    [self.delegate updateShaderValues:program];
}

@end
