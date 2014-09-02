//
//  CWHThinFilmProgram.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/28/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface CWHThinFilmProgram : SCNProgram<SCNProgramDelegate>
@property (strong) SCNNode *lightnode;
@property (assign) double filmDepth;
@property (strong) NSColor *diffuseColor;
@end
