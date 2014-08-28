//
//  CWHEnvMapParameterViewController.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/25/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWHParameterViewProtocol.h"
#import "CWHEnvMapProgram.h"
#import "CWHParameterViewController.h"

@interface CWHEnvMapParameterViewController : CWHParameterViewController
@property (weak) IBOutlet NSSlider *ratioSlider;
@property (weak) IBOutlet NSTextField *ratioTextField;
@property (weak) IBOutlet NSColorWell *ambientColorWell;
@property (weak) IBOutlet NSColorWell *diffuseColorWell;
@property (weak) IBOutlet NSPopUpButton *envMapMenu;

@property (assign) double ratio;
- (IBAction)updateRatio:(id)sender;

@property (strong) NSColor *ambientColor;
- (IBAction)updateAmbientColor:(NSColorWell *)sender;

@property (strong) NSColor *diffuseColor;
- (IBAction)updateDiffuseColor:(NSColorWell *)sender;

@property (strong) NSString *imagePath;
- (IBAction)updateEnvMap:(id)sender;
@end
