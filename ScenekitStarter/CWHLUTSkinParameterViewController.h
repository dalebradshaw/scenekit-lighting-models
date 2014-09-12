//
//  CWHLUTSkinParameterViewController.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 9/12/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHParameterViewController.h"
#import "CWHLUTSkinProgram.h"

@interface CWHLUTSkinParameterViewController : CWHParameterViewController
@property (weak) IBOutlet NSSlider *wrapSlider;
@property (weak) IBOutlet NSTextField *wrapTextField;
@property (weak) IBOutlet NSSlider *scatterWidthSlider;
@property (weak) IBOutlet NSTextField *scatterWidthTextField;
@property (weak) IBOutlet NSSlider *shininessSlider;
@property (weak) IBOutlet NSTextField *shininessTextField;
@property (weak) IBOutlet NSColorWell *diffuseColorWell;
@property (weak) IBOutlet NSColorWell *specularColorWell;
@property (weak) IBOutlet NSColorWell *scatterColorWell;


- (IBAction)updateWrap:(id)sender;
- (IBAction)updateScatterWidth:(id)sender;
- (IBAction)updateShininess:(id)sender;
- (IBAction)updateDiffuseColor:(id)sender;
- (IBAction)updateSpecularColor:(id)sender;
- (IBAction)updateScatterColor:(id)sender;


@end
