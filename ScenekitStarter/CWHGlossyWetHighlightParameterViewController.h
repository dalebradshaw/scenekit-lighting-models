//
//  CWHGlossyWetHighlightParameterViewController.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 9/12/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import "CWHGlossyWetHighlightProgram.h"
#import "CWHParameterViewController.h"


@interface CWHGlossyWetHighlightParameterViewController : CWHParameterViewController
@property (weak) IBOutlet NSSlider *glossMinSlider;
@property (weak) IBOutlet NSTextField *glossMinTextField;
@property (weak) IBOutlet NSSlider *glossMaxSlider;
@property (weak) IBOutlet NSTextField *glossMaxTextField;
@property (weak) IBOutlet NSSlider *glossDropSlider;
@property (weak) IBOutlet NSTextField *glossDropTextField;
@property (weak) IBOutlet NSSlider *specularExponentSlider;
@property (weak) IBOutlet NSTextField *specularExponentTextField;
@property (weak) IBOutlet NSSlider *specularitySlider;
@property (weak) IBOutlet NSTextField *specularityTextField;
@property (weak) IBOutlet NSColorWell *diffuseColorWell;
@property (weak) IBOutlet NSColorWell *ambientColorWell;
@property (weak) IBOutlet NSColorWell *specularColorWell;


- (IBAction)updateGlossMin:(id)sender;
- (IBAction)updateGlossMax:(id)sender;
- (IBAction)updateGlossDrop:(id)sender;
- (IBAction)updateSpecularExponent:(id)sender;
- (IBAction)updateSpecularity:(id)sender;
- (IBAction)updateDiffuseColor:(id)sender;
- (IBAction)updateAmbientColor:(id)sender;
- (IBAction)updateSpecularColor:(id)sender;

@end
