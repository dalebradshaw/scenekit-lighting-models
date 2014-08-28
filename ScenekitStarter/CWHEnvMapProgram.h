//
//  CWHEnvMapProgram.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/25/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>

@interface CWHEnvMapProgram : SCNProgram<SCNProgramDelegate>

@property (strong) SCNNode *lightnode;
@property (strong) NSColor *diffuseColor;
@property (strong) NSColor *ambientColor;
@property (assign) double ratio;
@property (strong) NSString *imagePath;

@end
