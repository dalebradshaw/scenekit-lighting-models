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
    if(self.program){
        NSColor *diffuseColor = [self.program valueForKey:@"diffuseColor"];
        
        if (diffuseColor) {
            [self.diffuseColorWell setColor:diffuseColor];
            self.diffuseColor = diffuseColor;
        }
        
        double filmDepth = [[self.program valueForKey:@"filmDepth"] doubleValue];
        if (filmDepth >= 0) {
            [self.filmDepthSlider setDoubleValue:filmDepth];
            [self.filmDepthTextField setDoubleValue:filmDepth];
            self.filmDepth = filmDepth;
        }
    }
}

- (IBAction)updateFilmDepth:(id)sender {
    self.filmDepth = [sender doubleValue];
    if ([sender isKindOfClass:[NSSlider class]]) {
       [self.filmDepthTextField setDoubleValue:[sender doubleValue]];
    }else{
       [self.filmDepthSlider setDoubleValue:[sender doubleValue]];
    }
    [self updateShaderValues];
}

- (IBAction)updateDiffuseColor:(id)sender {
    NSColorWell *colorWell = sender;
    NSColor *color = [colorWell color];
    
    self.diffuseColor = color;
    [self updateShaderValues];
}

-(void)updateShaderValues
{
    CWHThinFilmProgram *program = [CWHThinFilmProgram program];
    
    program.filmDepth= self.filmDepth;
    program.diffuseColor = self.diffuseColor;
    
    [self.delegate updateShaderValues:program];
}

@end
