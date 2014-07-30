//
//  CWHVelvetProgram.h
//  ScenekitStarter
//
//  Created by Super on 7/30/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface CWHVelvetProgram : SCNProgram<SCNProgramDelegate>

@property (strong) SCNNode *lightnode;
@property (strong) NSColor *underColor;
@property (strong) NSColor *fuzzColor;
@property (assign) double rolloff;
@property (strong) NSColor *primaryColor;

@end
