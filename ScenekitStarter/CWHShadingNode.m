//
//  CWHShadingNode.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/28/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHShadingNode.h"
#import "CWHBlinnProgram.h"
#import "CWHPhongPointLightProgram.h"
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>

@implementation CWHShadingNode
-(instancetype)init
{
    
    self = [super init];
    
    if ( self != nil )
    {
        //default light and plane
        SCNPlane *plane = [SCNPlane planeWithWidth:1 height:1];
        
        SCNNode *ambientLightNode = [SCNNode node];
        ambientLightNode.name = @"light";
        ambientLightNode.light = [SCNLight light];
        ambientLightNode.position = SCNVector3Make(0, 10, 10);
        ambientLightNode.light.type = SCNLightTypeAmbient;
        ambientLightNode.light.color = [NSColor redColor];
        
        [self prepareProgramWithGeometry:plane
                                   light:ambientLightNode];
    }
    
    return self;
    
    
}
-(instancetype)initWithGeometry:(SCNGeometry *)geometry
                          light:(SCNNode *)light
{
    self = [super init];
    
    if ( self != nil )
    {
        
        [self prepareProgramWithGeometry:geometry
                                   light:light];
    }
    
    return self;
}


-(void)prepareProgramWithGeometry:(SCNGeometry *)geometry
                            light:(SCNNode *)light
{
   
    self.geometry = geometry;
    
    // Create a material
    SCNMaterial *programMaterial = [SCNMaterial material];
    
    //CWHBlinnProgram *program = [CWHBlinnProgram program];
    CWHPhongPointLightProgram *program = [CWHPhongPointLightProgram program];
    program.lightnode = light;
    
    // Set program on geometry
    programMaterial.program = program;
    self.geometry.materials = @[programMaterial];
   
}


@end
