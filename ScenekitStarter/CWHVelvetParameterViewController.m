//
//  CWHVelvetParamterViewController.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/15/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHVelvetParameterViewController.h"

@interface CWHVelvetParameterViewController ()

@end

@implementation CWHVelvetParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.program){
        double rolloff = [[self.program valueForKey:@"rolloff"] doubleValue];
        if (rolloff >= 0) {
            [self.rolloffCircularSlider setDoubleValue:rolloff];
            [self.rolloffTextField setDoubleValue:rolloff];
            self.rolloff = rolloff;
        }
        
        NSColor *underColor = [self.program valueForKey:@"underColor"];
        
        if (underColor) {
            [self.underColorWell setColor:underColor];
            self.underColor = underColor;
        }
        
        NSColor *fuzzColor = [self.program valueForKey:@"fuzzColor"];
        
        if(fuzzColor){
            [self.fuzzColorWell setColor:fuzzColor];
            self.fuzzColor= fuzzColor;
        }
        
        NSColor *primaryColor = [self.program valueForKey:@"primaryColor"];
        
        if(primaryColor){
            [self.primaryColorWell setColor:primaryColor];
            self.primaryColor = primaryColor;
        }
        
      
        
    }
}

- (IBAction)updateRolloff:(id)sender {
    self.rolloff = [sender doubleValue];
    if ([sender isKindOfClass:[NSSlider class]]) {
        [self.rolloffTextField setDoubleValue:[sender doubleValue]];
    }
    
    [self updateShaderValues];
}

- (IBAction)updateUnderColor:(id)sender {
    self.underColor = [sender color];
    [self updateShaderValues];
}

- (IBAction)updateFuzzColor:(id)sender {
    self.fuzzColor = [sender color];
    [self updateShaderValues];
}

- (IBAction)updatePrimaryColor:(id)sender {
    self.primaryColor = [sender color];
    [self updateShaderValues];
}

-(void)updateShaderValues
{
    CWHVelvetProgram *program = [CWHVelvetProgram program];
    
    program.rolloff = self.rolloff;
    program.underColor = self.underColor;
    program.fuzzColor = self.fuzzColor;
    program.primaryColor = self.primaryColor;
    
    [self.delegate updateShaderValues:program];
}
@end
