//
//  CWHLUTSkinProgram.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/31/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface CWHLUTSkinProgram : SCNProgram<SCNProgramDelegate, NSCoding>

@property (strong) SCNNode *lightnode;
@property (strong) NSColor *diffuseColor;
@property (strong) NSColor *specularColor;
@property (strong) NSColor *scatterColor;
@property (assign) double wrap;
@property (assign) double scatterWidth;
@property (assign) double shininess;

@end
