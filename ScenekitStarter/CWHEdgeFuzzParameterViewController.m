//
//  CWHEdgeFuzzParameterViewController.m
//  ScenekitStarter
//
//  Created by Super on 8/15/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHEdgeFuzzParameterViewController.h"

@interface CWHEdgeFuzzParameterViewController ()

@end

@implementation CWHEdgeFuzzParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)updateFuzziness:(id)sender {
    //NSLog(@" update Fuzziness %f", [sender doubleValue]);
    self.fuzziness = [sender doubleValue];
    if ([sender isKindOfClass:[NSSlider class]]) {
        [self.fuzzinessTextField setDoubleValue:[sender doubleValue]];
    }
    [self updateShaderValues];
}

- (IBAction)updateSurfaceColor:(id)sender {
    self.surfaceColor = [sender color];
    [self updateShaderValues];
}

- (IBAction)updateEdgeFade:(id)sender {
    self.edgeFade= [sender doubleValue];
    if ([sender isKindOfClass:[NSSlider class]]) {
        [self.edgeFadeTextField setDoubleValue:[sender doubleValue]];
    }
    [self updateShaderValues];
}

- (IBAction)updateSpecularity:(id)sender {
    self.specularity = [sender doubleValue];
    if ([sender isKindOfClass:[NSSlider class]]) {
        [self.specularityTextField setDoubleValue:[sender doubleValue]];
    }
    
    [self updateShaderValues];
}

- (IBAction)updateEdgeColor:(id)sender {
    self.edgeColor = [sender color];
    [self updateShaderValues];
}

- (IBAction)lightColor:(id)sender {
    self.lightColor = [sender color];
    [self updateShaderValues];
}

- (IBAction)updateAmbientColor:(id)sender {
    self.ambientColor = [sender color];
    [self updateShaderValues];
}

-(void)updateShaderValues
{
    CWHEdgeFuzzProgram *program = [CWHEdgeFuzzProgram program];
    
    program.fuzziness = self.fuzziness;
    program.surfaceColor = self.surfaceColor;
    program.edgeFade = self.edgeFade;
    program.specularity = self.specularity;
    program.edgeColor = self.edgeColor;
    program.lightColor = self.lightColor;
    program.ambientColor = self.ambientColor;
    
    [self.delegate updateShaderValues:program];
}

@end
