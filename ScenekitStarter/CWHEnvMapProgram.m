//
//  CWHEnvMapProgram.m
//  ScenekitStarter
//
//  Created by Super on 8/25/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHEnvMapProgram.h"
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>
@implementation CWHEnvMapProgram
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *vertexShaderURL   = [[NSBundle mainBundle] URLForResource:@"EnvMap" withExtension:@"vsh"];
        NSURL *fragmentShaderURL = [[NSBundle mainBundle] URLForResource:@"EnvMap" withExtension:@"fsh"];
        
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
        
        // Become the program delegate so that you get the binding callback
        self.delegate = self;
        
    }
    return self;
}

-(BOOL)    program:(SCNProgram *)program
bindValueForSymbol:(NSString *)symbol
        atLocation:(unsigned int)location
         programID:(unsigned int)programID
          renderer:(SCNRenderer *)renderer
{

    if ([symbol isEqualToString:@"light_position"]) {
        //NSLog(@" lightnode %@", self.lightnode);
        if(self.lightnode){
            //NSLog(@" lightnode position %f, %f, %f " , self.lightnode.position.x, self.lightnode.position.y, self.lightnode.position.z);
            glUniform3f(location, self.lightnode.position.x, self.lightnode.position.y, self.lightnode.position.z);
        }
        
        return YES; // indicate that the symbol was bound successfully.
    }
   
    if ([symbol isEqualToString:@"env_map"]) {
        NSError *error = nil;
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"EnvMap" ofType:@"png"];
        GLKTextureInfo *texture = [GLKTextureLoader textureWithContentsOfFile:imagePath options:nil error:&error];
        
        if(!texture){
            NSLog(@"Error loading file %@", [error localizedDescription] );
        }
        
        glBindTexture(GL_TEXTURE_2D, texture.name);
        
        return YES;
    }
    
    return NO;
}

@end
