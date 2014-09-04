//
//  CWHThinFilmParameterViewController.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 9/4/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "CWHParameterViewProtocol.h"
#import "CWHThinFilmProgram.h"
#import "CWHParameterViewController.h"

@interface CWHThinFilmParameterViewController : CWHParameterViewController

@property (weak) IBOutlet NSSlider *filmDepthSlider;
@property (weak) IBOutlet NSTextField *filmDepthTextField;
@property (weak) IBOutlet NSColorWell *diffuseColorWell;

@property (assign) double filmDepth;
- (IBAction)updateFilmDepth:(id)sender;

@property (strong) NSColor *diffuseColor;
- (IBAction)updateDiffuseColor:(id)sender;

@end
