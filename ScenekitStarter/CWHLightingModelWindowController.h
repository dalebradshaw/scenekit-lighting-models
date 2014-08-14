//
//  CWHLightingModelWindowController.h
//  ScenekitStarter
//
//  Created by Super on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWHPhongPointLightParameterViewController.h"
@class CWHLightingViewController;

@interface CWHLightingModelWindowController : NSWindowController<CWHParameterViewProtocol>
{
    __weak IBOutlet NSView *targetView;
}

-(IBAction)showInputParameters:(id)sender;
-(IBAction)updateLightingModel:(id)sender;

@property (strong) CWHLightingViewController *lightingViewController;
@property (assign) BOOL lightingParameterState;
@property (strong) NSString *currentLightingProgram;

@end
