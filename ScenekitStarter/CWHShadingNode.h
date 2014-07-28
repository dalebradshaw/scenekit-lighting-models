//
//  CWHShadingNode.h
//  ScenekitStarter
//
//  Created by Super on 7/28/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface CWHShadingNode : SCNNode<SCNProgramDelegate>

-(instancetype)initWithGeometry:(SCNGeometry *)geometry;
-(void)prepareProgramWithGeometry:(SCNGeometry *)geometry;
@end
