//
//  CWHLambSkinProgram.h
//  ScenekitStarter
//
//  Created by Super on 7/31/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface CWHLambSkinProgram : SCNProgram<SCNProgramDelegate>

@property (strong) SCNNode *lightnode;
@property (strong) NSColor *diffuseColor;
@property (strong) NSColor *ambientColor;
@property (assign) double rolloff;

@end
