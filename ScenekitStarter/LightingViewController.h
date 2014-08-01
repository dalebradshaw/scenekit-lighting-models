//
//  GameViewController.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/24/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>

#import "GameView.h"
#import "CWHShadingNode.h"

@interface LightingViewController : NSViewController
@property (weak) IBOutlet GameView *gameView;

@property (nonatomic, retain) CWHShadingNode *torusNode;

@end
