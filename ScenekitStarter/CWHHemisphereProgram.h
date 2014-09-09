//
//  CWHHemisphereProgram.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/31/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface CWHHemisphereProgram : SCNProgram<SCNProgramDelegate, NSCoding>

@property (strong) SCNNode *lightnode;

@property (strong) NSColor *skyColor;
@property (strong) NSColor *groundColor;

@end
