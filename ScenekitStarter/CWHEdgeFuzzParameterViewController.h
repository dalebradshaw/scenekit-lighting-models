//
//  CWHEdgeFuzzParameterViewController.h
//  ScenekitStarter
//
//  Created by Super on 8/15/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWHParameterViewProtocol.h"
#import "CWHEdgeFuzzProgram.h"
#import "CWHParameterViewController.h"

@interface CWHEdgeFuzzParameterViewController : CWHParameterViewController

@property (weak) IBOutlet NSTextField *fuzzinessTextField;
@property (weak) IBOutlet NSSlider *fuzzinessCircularSlider;
@property (weak) IBOutlet NSColorWell *surfaceColorWell;
@property (weak) IBOutlet NSTextField *edgeFadeTextField;
@property (weak) IBOutlet NSSlider *edgeFadeCircularSlider;
@property (weak) IBOutlet NSTextField *specularityTextField;
@property (weak) IBOutlet NSSlider *specularityCircularSlider;
@property (weak) IBOutlet NSColorWell *edgeColorWell;
@property (weak) IBOutlet NSColorWell *lightColorWell;
@property (weak) IBOutlet NSColorWell *ambientColorWell;

@property (assign) double fuzziness;
- (IBAction)updateFuzziness:(id)sender;

@property (strong) NSColor *surfaceColor;
- (IBAction)updateSurfaceColor:(id)sender;

@property (assign) double edgeFade;
- (IBAction)updateEdgeFade:(id)sender;

@property (assign) double specularity;
- (IBAction)updateSpecularity:(id)sender;

@property (strong) NSColor *edgeColor;
- (IBAction)updateEdgeColor:(id)sender;

@property (strong) NSColor *lightColor;
- (IBAction)lightColor:(id)sender;

@property (strong) NSColor *ambientColor;
- (IBAction)updateAmbientColor:(id)sender;

@end
