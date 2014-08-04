//
//  CWHLightingModelWindowController.h
//  ScenekitStarter
//
//  Created by Super on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LightingViewController;

@interface CWHLightingModelWindowController : NSWindowController
{
    
    __weak IBOutlet NSView *targetView;
}

-(IBAction)showInputParameters:(id)sender;
@property (nonatomic, strong) LightingViewController *lightingViewController;

@end
