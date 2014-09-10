//
//  CWHBlinnParameterViewController.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/15/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHBlinnParameterViewController.h"

@interface CWHBlinnParameterViewController ()

@end

@implementation CWHBlinnParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    }
}

- (IBAction)updateAmbientColor:(id)sender {
    
    NSColorWell *colorWell = sender;
    NSColor *color = [colorWell color];

    self.ambientColor = color;
    [self updateShaderValues];

}

- (IBAction)updateLightColor:(id)sender {
    NSColorWell *colorWell = sender;
    NSColor *color = [colorWell color];
    
    self.lightColor = color;
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
