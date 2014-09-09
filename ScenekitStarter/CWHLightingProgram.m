//
//  CWHLightingProgram.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 9/9/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHLightingProgram.h"

@implementation CWHLightingProgram

- (id)initWithProgram:(NSString *)program {
    self = [super init];
    if (self) {
      
        NSURL *vertexShaderURL   = [[NSBundle mainBundle] URLForResource:program withExtension:@"vsh"];
        NSURL *fragmentShaderURL = [[NSBundle mainBundle] URLForResource:program withExtension:@"fsh"];
        
        NSString *vertexShader = [[NSString alloc] initWithContentsOfURL:vertexShaderURL
                                                                encoding:NSUTF8StringEncoding
                                                                   error:NULL];
        NSString *fragmentShader = [[NSString alloc] initWithContentsOfURL:fragmentShaderURL
                                                                  encoding:NSUTF8StringEncoding
                                                                     error:NULL];
        // Assign the shader
        self.vertexShader   = vertexShader;
        self.fragmentShader = fragmentShader;
        
        // Bind geometry source semantics to the vertex shader attributes
        [self setSemantic:SCNGeometrySourceSemanticVertex forSymbol:@"a_srcPos" options:nil];
        [self setSemantic:SCNGeometrySourceSemanticNormal forSymbol:@"a_normPos" options:nil];
        [self setSemantic:SCNGeometrySourceSemanticTexcoord forSymbol:@"a_texcoord" options:nil];
        
        // Bind the uniforms that can benefit from "automatic" values, computed and assigned by Scene Kit at each frame
        [self setSemantic:SCNModelViewTransform forSymbol:@"u_mv" options:nil];
        [self setSemantic:SCNModelViewProjectionTransform forSymbol:@"u_mvproj" options:nil];
        [self setSemantic:SCNProjectionTransform forSymbol:@"u_proj" options:nil];
        [self setSemantic:SCNNormalTransform forSymbol:@"u_norm" options:nil];
    }
    return self;
}

- (id)init {
    //default program
    return [self initWithProgram:@"PhongPointLight"];
}

@end
