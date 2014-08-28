//
//  CWHEnvMapParameterViewController.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/25/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWHEnvMapParameterViewController.h"
#import "CWHParameterViewProtocol.h"
#import "CWHEnvMapProgram.h"
#import "CWHParameterViewController.h"

@interface CWHEnvMapParameterViewController ()

@end

@implementation CWHEnvMapParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.imagePath = [[NSBundle mainBundle] pathForResource:@"EnvMapInterior" ofType:@"png"];
    self.ratio = 0.875;
    [self.ratioTextField setDoubleValue:self.ratio];
    [self.ratioSlider setDoubleValue:self.ratio];
    NSColor *diffuseColor = [NSColor colorWithRed:1. green:1. blue:1. alpha:1.];
    self.diffuseColor = diffuseColor;
    [self.diffuseColorWell setColor:diffuseColor];
    NSColor *ambientColor = [NSColor colorWithRed:0. green:0. blue:0. alpha:1.];
    self.ambientColor = ambientColor;
    [self.ambientColorWell setColor:ambientColor];
}

- (IBAction)updateRatio:(id)sender {
    self.ratio = [sender doubleValue];
    if ([sender isKindOfClass:[NSSlider class]]) {
        [self.ratioTextField setDoubleValue:[sender doubleValue]];
    }else{
        [self.ratioSlider setDoubleValue:[sender doubleValue]];
    }
    [self updateShaderValues];
}

- (IBAction)updateAmbientColor:(NSColorWell *)sender {
    self.ambientColor = [sender color];
    [self updateShaderValues];
}

- (IBAction)updateDiffuseColor:(NSColorWell *)sender {
    self.diffuseColor = [(NSColorWell *)sender color];
    [self updateShaderValues];
}

- (IBAction)updateEnvMap:(id)sender {
   NSString *updatedMap = [sender titleOfSelectedItem];
   NSLog(@"updateEnvMap %@", updatedMap);
   self.imagePath = [[NSBundle mainBundle] pathForResource:updatedMap ofType:@"png"];
}

-(void)updateShaderValues
{
    CWHEnvMapProgram *program = [CWHEnvMapProgram program];
    
    program.ratio = self.ratio;
    program.ambientColor = self.ambientColor;
    program.diffuseColor = self.diffuseColor;
    program.imagePath = self.imagePath;
    
    [self.delegate updateShaderValues:program];

}


@end
