//
//  CWHBlinnProgram.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/29/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "CWHLightingProgram.h"

@interface CWHGoochProgram : CWHLightingProgram<SCNProgramDelegate, NSCoding>

@property (strong) SCNNode *lightnode;
@property (strong) NSColor *surfaceColor;
@property (strong) NSColor *warmColor;
@property (strong) NSColor *coolColor;
@property (assign) double diffuseWarm;
@property (assign) double diffuseCool;

@end
