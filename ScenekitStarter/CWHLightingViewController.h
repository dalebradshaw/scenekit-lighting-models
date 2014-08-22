//
//  GameViewController.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/24/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>

#import "CWHLightingView.h"
#import "CWHShadingNode.h"

@interface CWHLightingViewController : NSViewController

@property (weak) IBOutlet CWHLightingView *lightingView;
@property (strong) SCNNode *lightNode;
@property (nonatomic, retain) CWHShadingNode *torusNode;

@end
