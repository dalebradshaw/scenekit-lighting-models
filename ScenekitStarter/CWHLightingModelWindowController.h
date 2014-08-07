//
//  CWHLightingModelWindowController.h
//  ScenekitStarter
//
//  Created by Super on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWHPhongPointLightParameterViewController.h"
@class LightingViewController;

@interface CWHLightingModelWindowController : NSWindowController<ParameterViewProtocol>
{
    __weak IBOutlet NSView *targetView;
}

-(IBAction)showInputParameters:(id)sender;
@property (strong) LightingViewController *lightingViewController;
@property (assign) BOOL lightingParameterState;

@end
