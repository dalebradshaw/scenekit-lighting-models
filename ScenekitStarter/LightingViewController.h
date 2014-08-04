//
//  GameViewController.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/24/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>

#import "LightingView.h"
#import "CWHShadingNode.h"

@interface LightingViewController : NSViewController
@property (weak) IBOutlet LightingView *lightingView;

@property (nonatomic, retain) CWHShadingNode *torusNode;

@end
