//
//  CWHPhongPointLightParameterViewController.h
//  ScenekitStarter
//
//  Created by Super on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CWHPhongPointLightParameterViewController : NSViewController

@property (weak) IBOutlet NSSlider *specularitySlider;
@property (weak) IBOutlet NSSlider *shininessSlider;

@property (weak) IBOutlet NSTextField *specularityTextField;
@property (weak) IBOutlet NSTextField *shininessTextField;

@property (weak) IBOutlet NSColorWell *ambientColorWell;
@property (weak) IBOutlet NSColorWell *lightColorWell;

@end
