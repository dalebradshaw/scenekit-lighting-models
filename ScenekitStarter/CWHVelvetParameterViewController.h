//
//  CWHVelvetParamterViewController.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/15/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWHVelvetProgram.h"
#import "CWHParameterViewController.h"

@interface CWHVelvetParameterViewController : CWHParameterViewController

@property (weak) IBOutlet NSTextField *rolloffTextField;
@property (weak) IBOutlet NSSlider *rolloffCircularSlider;
@property (weak) IBOutlet NSColorWell *underColorWell;
@property (weak) IBOutlet NSColorWell *fuzzColorWell;
@property (weak) IBOutlet NSColorWell *primaryColorWell;

@property (assign) double rolloff;
- (IBAction)updateRolloff:(id)sender;

@property (strong) NSColor *underColor;
- (IBAction)updateUnderColor:(id)sender;

@property (strong) NSColor *fuzzColor;
- (IBAction)updateFuzzColor:(id)sender;

@property (strong) NSColor *primaryColor;
- (IBAction)updatePrimaryColor:(id)sender;

@end
