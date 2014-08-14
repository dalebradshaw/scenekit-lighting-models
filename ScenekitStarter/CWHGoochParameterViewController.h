//
//  CWHGoochParameterViewController.h
//  ScenekitStarter
//
//  Created by Super on 8/12/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWHParameterViewProtocol.h"
#import "CWHGoochProgram.h"
#import "CWHParameterViewController.h"

@interface CWHGoochParameterViewController : CWHParameterViewController

@property (weak) IBOutlet NSTextField *diffuseWarmTextField;
@property (weak) IBOutlet NSTextField *diffuseCoolTextField;

@property (weak) IBOutlet NSSlider *diffuseWarmSlider;
@property (weak) IBOutlet NSSlider *diffuseCoolSlider;

@property (weak) IBOutlet NSColorWell *warmColorWell;
@property (weak) IBOutlet NSColorWell *coolColorWell;

@property (assign) double diffuseWarm;
- (IBAction)updateDiffuseWarm:(id)sender;

@property (assign) double diffuseCool;
- (IBAction)updateDiffuseCool:(id)sender;

@property (strong) NSColor *warmColor;
- (IBAction)updateWarmColor:(id)sender;

@property (strong) NSColor *coolColor;
- (IBAction)updateCoolColor:(id)sender;

@end
