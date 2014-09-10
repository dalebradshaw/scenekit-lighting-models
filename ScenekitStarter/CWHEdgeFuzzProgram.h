//
//  CWHEdgeFuzzProgram.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/31/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "CWHLightingProgram.h"

@interface CWHEdgeFuzzProgram : CWHLightingProgram<SCNProgramDelegate, NSCoding>

@property (strong) SCNNode *lightnode;
@property (strong) NSColor *surfaceColor;
@property (strong) NSColor *edgeColor;
@property (strong) NSColor *lightColor;
@property (strong) NSColor *ambientColor;
@property (assign) double fuzziness;
@property (assign) double edgeFade;
@property (assign) double specularity;

@end
