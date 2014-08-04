//
//  CWHPhongPointLightParameterViewController.h
//  ScenekitStarter
//
//  Created by Super on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ParameterViewProtocol.h"

@interface CWHPhongPointLightParameterViewController : NSViewController
@property (nonatomic, retain) id delegate;

@property (weak) IBOutlet NSSlider *specularitySlider;
@property (weak) IBOutlet NSSlider *shininessSlider;

@property (weak) IBOutlet NSTextField *specularityTextField;
@property (weak) IBOutlet NSTextField *shininessTextField;

@property (weak) IBOutlet NSColorWell *ambientColorWell;
@property (weak) IBOutlet NSColorWell *lightColorWell;

-(IBAction)setMaterialSpecularity:(id)sender;
-(IBAction)setShininess:(id)sender;
-(IBAction)setAmbientColor:(id)sender;

@property (strong) NSColor *lightColor;
-(IBAction)updateLightColor:(id)sender;


@end
