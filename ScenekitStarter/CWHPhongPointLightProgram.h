//
//  CWHBlinnProgram.h
//  ScenekitStarter
//
//  Created by Super on 7/29/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface CWHPhongPointLightProgram: SCNProgram<SCNProgramDelegate>

@property (strong) SCNNode *lightnode;
@property (strong) NSColor *lightColor;
@property (strong) NSColor *ambientColor;

@property (assign) double   shininess;
@property (assign) double materialSpecularity;
@end
