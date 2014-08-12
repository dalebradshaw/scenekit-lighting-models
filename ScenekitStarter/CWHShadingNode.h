//
//  CWHShadingNode.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/28/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <SceneKit/SceneKit.h>


@interface CWHShadingNode : SCNNode<SCNProgramDelegate>

-(void)updateParameters:(NSDictionary*)parameters;
-(instancetype)initWithGeometry:(SCNGeometry *)geometry
                          light:(SCNNode *)light;
-(void)prepareProgramWithGeometry:(SCNGeometry *)geometry
                            light:(SCNNode *)light;
-(void)updateLightingModel:(NSString*)lightingModel;
@end
