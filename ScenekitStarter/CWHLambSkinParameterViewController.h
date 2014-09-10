//
//  CWHLambSkinParameterViewController.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/21/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWHParameterViewProtocol.h"
#import "CWHLambSkinProgram.h"
#import "CWHParameterViewController.h"

@interface CWHLambSkinParameterViewController : CWHParameterViewController

@property (assign) double rolloff;
- (IBAction)updateRolloff:(id)sender;
@property (weak) IBOutlet NSSlider *rolloffSlider;
@property (weak) IBOutlet NSTextField *rolloffTextField;

@property (weak) IBOutlet NSColorWell *ambientColorWell;
@property (strong) NSColor *ambientColor;
- (IBAction)updateAmbientColor:(id)sender;

@property (weak) IBOutlet NSColorWell *diffuseColorWell;
@property (strong) NSColor *diffuseColor;
- (IBAction)updateDiffuseColor:(id)sender;


@property (weak) IBOutlet NSColorWell *subColorWell;
@property (strong) NSColor *subColor;
- (IBAction)updateSubColor:(id)sender;

@end
