//
//  CWHGlossyWetHighlightProgram.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/31/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "CWHLightingProgram.h"

@interface CWHGlossyWetHighlightProgram : CWHLightingProgram<SCNProgramDelegate>

@property (strong) SCNNode *lightnode;
@property (strong) NSColor *ambientColor;
@property (strong) NSColor *specularColor;
@property (assign) double specularity;
@property (assign) double specularExponent;
@property (assign) double glossMax;
@property (assign) double glossMin;
@property (assign) double glossDrop;

@end
