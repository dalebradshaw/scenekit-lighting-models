//
//  CWHShadingNode.m
//  ScenekitStarter
//
//  Created by Super on 7/28/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHShadingNode.h"

@implementation CWHShadingNode
-(instancetype)init
{
    
    self = [super init];
    
    if ( self != nil )
    {
        SCNPlane *plane = [SCNPlane planeWithWidth:1 height:1];
        [self prepareProgramWithGeometry:plane];
    }
    
    return self;
    
    
}
-(instancetype)initWithGeometry:(SCNGeometry *)geometry
{
    self = [super init];
    
    if ( self != nil )
    {
        [self prepareProgramWithGeometry:geometry];
    }
    
    return self;
}


-(void)prepareProgramWithGeometry:(SCNGeometry *)geometry
{

    self.geometry = geometry;
    
    // Create a material
    SCNMaterial *programMaterial = [SCNMaterial material];
    
    // Create a program
    SCNProgram *program = [SCNProgram program];
    
    // Read the shader files from your bundle
    
    NSURL *vertexShaderURL   = [[NSBundle mainBundle] URLForResource:@"PhongPointLight" withExtension:@"vsh"];
    NSURL *fragmentShaderURL = [[NSBundle mainBundle] URLForResource:@"PhongPointLight" withExtension:@"fsh"];
    
    NSString *vertexShader = [[NSString alloc] initWithContentsOfURL:vertexShaderURL
                                                            encoding:NSUTF8StringEncoding
                                                               error:NULL];
    NSString *fragmentShader = [[NSString alloc] initWithContentsOfURL:fragmentShaderURL
                                                              encoding:NSUTF8StringEncoding
                                                                 error:NULL];
    // Assign the shader
    program.vertexShader   = vertexShader;
    program.fragmentShader = fragmentShader;
    
    // Bind geometry source semantics to the vertex shader attributes
    [program setSemantic:SCNGeometrySourceSemanticVertex forSymbol:@"a_srcPos" options:nil];
    [program setSemantic:SCNGeometrySourceSemanticNormal forSymbol:@"a_normPos" options:nil];
    [program setSemantic:SCNGeometrySourceSemanticTexcoord forSymbol:@"a_texcoord" options:nil];
    
    // Bind the uniforms that can benefit from "automatic" values, computed and assigned by Scene Kit at each frame
    [program setSemantic:SCNModelViewTransform forSymbol:@"u_mv" options:nil];
    [program setSemantic:SCNModelViewProjectionTransform forSymbol:@"u_mvproj" options:nil];
    [program setSemantic:SCNProjectionTransform forSymbol:@"u_proj" options:nil];
    [program setSemantic:SCNNormalTransform forSymbol:@"u_norm" options:nil];

    // Become the program delegate so that you get the binding callback
    program.delegate = self;
    
    // Set program on geometry
    programMaterial.program = program;
    self.geometry.materials = @[programMaterial];
}
@end
