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
#import "CWHEdgeFuzzProgram.h"
#import "CWHGoochProgram.h"
#import "CWHHemisphereProgram.h"
#import "CWHLambSkinProgram.h"
#import "CWHVelvetProgram.h"
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

-(void)updateParameters:(NSDictionary*)parameters
{
    NSLog(@"updateParameters: %@", parameters);
    SCNMaterial *programMaterial = [SCNMaterial material];
    CWHPhongPointLightProgram *program = [CWHPhongPointLightProgram program];
    
    if(parameters[@"light_color"]){
        program.lightColor = parameters[@"light_color"];
    }
    
    if (parameters[@"shininess"]) {
        program.shininess = [parameters[@"shininess"] doubleValue];
    }
    
    programMaterial.program = program;
    self.geometry.materials = @[programMaterial];
}

-(void)prepareProgramWithGeometry:(SCNGeometry *)geometry
                            light:(SCNNode *)light
{
   
    self.geometry = geometry;
    
    // Create a material
    SCNMaterial *programMaterial = [SCNMaterial material];
    
    //CWHBlinnProgram *program = [CWHBlinnProgram program];
    CWHPhongPointLightProgram *program = [CWHPhongPointLightProgram program];
    /*
    CWHGoochProgram *program = [CWHGoochProgram program];
    
    NSColor *warmColor = [NSColor colorWithRed:1. green:.3 blue:.3 alpha:1.];
    program.warmColor = warmColor;
    NSColor *coolColor = [NSColor colorWithRed:0.2 green:0.2 blue:1. alpha:1.];
   
    program.coolColor = coolColor;
   
    program.diffuseCool = 0.;
    program.diffuseWarm = 1.;
    */
    
   /*
    CWHVelvetProgram *program = [CWHVelvetProgram program];

    NSColor *underColor = [NSColor colorWithRed:0.7 green:0.7 blue:0 alpha:1.];
    program.underColor = underColor;
    NSColor *fuzzColor = [NSColor colorWithRed:0.9 green:0.7 blue:0.5 alpha:1.];
    program.fuzzColor = fuzzColor;
    program.rolloff = 0.528;
   
   
    CWHHemisphereProgram *program = [CWHHemisphereProgram program];
    NSColor *skyColor = [NSColor colorWithRed:0.0 green:0.7 blue:1. alpha:1.];
    program.skyColor = skyColor;
    NSColor *groundColor = [NSColor colorWithRed:0.7 green:0.5 blue:0.2 alpha:1.];
    program.groundColor = groundColor;
     
    CWHLambSkinProgram *program = [CWHLambSkinProgram program];
    NSColor *diffuseColor = [NSColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.];
    program.diffuseColor = diffuseColor;
    NSColor *ambientColor = [NSColor colorWithRed:0. green:0. blue:0. alpha:1.];
    program.ambientColor = ambientColor;
    program.rolloff = 0.575;
   
    CWHEdgeFuzzProgram *program = [CWHEdgeFuzzProgram program];
    NSColor *surfaceColor = [NSColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:1.];
    program.surfaceColor = surfaceColor;
    NSColor *edgeColor = [NSColor colorWithRed:0.4 green:0.8 blue:1. alpha:1.];
    program.edgeColor = edgeColor;
    NSColor *lightColor = [NSColor colorWithRed:1. green:1. blue:1. alpha:1.];
    program.lightColor = lightColor;
    NSColor *ambientColor = [NSColor colorWithRed:0. green:0. blue:0. alpha:1.];
    program.ambientColor = ambientColor;
    
    program.fuzziness = 0.166;
    program.edgeFade = 3.868;
    program.specularity = 0.1488;
     */
    program.lightnode = light;
  
    // Set program on geometry
    programMaterial.program = program;
    self.geometry.materials = @[programMaterial];
   
}


@end
