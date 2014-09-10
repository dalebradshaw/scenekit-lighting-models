//
//  CWHVelvetProgram.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/30/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "CWHLightingProgram.h"
@interface CWHVelvetProgram : CWHLightingProgram<SCNProgramDelegate>

@property (strong) SCNNode *lightnode;
@property (strong) NSColor *underColor;
@property (strong) NSColor *fuzzColor;
@property (assign) double rolloff;
@property (strong) NSColor *primaryColor;

@end
