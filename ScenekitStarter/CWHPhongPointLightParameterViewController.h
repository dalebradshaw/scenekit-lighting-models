//
//  CWHPhongPointLightParameterViewController.h
//  ScenekitStarter
//
//  Created by Super on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ParameterViewProtocol.h"
#import "CWHPhongPointLightProgram.h"
#import "CWHParameterViewController.h"

@interface CWHPhongPointLightParameterViewController : CWHParameterViewController


@property (weak) IBOutlet NSSlider *specularitySlider;
@property (weak) IBOutlet NSSlider *shininessSlider;

@property (weak) IBOutlet NSTextField *specularityTextField;
@property (weak) IBOutlet NSTextField *shininessTextField;

@property (weak) IBOutlet NSColorWell *ambientColorWell;
@property (weak) IBOutlet NSColorWell *lightColorWell;

@property (assign) double materialSpecularity;
-(IBAction)updateMaterialSpecularity:(id)sender;

@property (assign) double shininess;
-(IBAction)updateShininess:(id)sender;

@property (strong) NSColor *ambientColor;
-(IBAction)updateAmbientColor:(id)sender;

@property (strong) NSColor *lightColor;
-(IBAction)updateLightColor:(id)sender;


@end
