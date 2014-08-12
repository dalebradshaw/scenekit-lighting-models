//
//  CWHBlinnProgram.m
//  ScenekitStarter
//
//  Created by Super on 7/29/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHGoochProgram.h"
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>

@implementation CWHGoochProgram

-(instancetype)init
{
    
    self = [super init];
    
    if ( self != nil )
    {
        
        NSURL *vertexShaderURL   = [[NSBundle mainBundle] URLForResource:@"Gooch" withExtension:@"vsh"];
        NSURL *fragmentShaderURL = [[NSBundle mainBundle] URLForResource:@"Gooch" withExtension:@"fsh"];
        
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
        
        //defaults
        NSColor *warmColor = [NSColor colorWithRed:1. green:.3 blue:.3 alpha:1.];
        self.warmColor = warmColor;
        NSColor *coolColor = [NSColor colorWithRed:0.2 green:0.2 blue:1. alpha:1.];
        
        self.coolColor = coolColor;
        
        self.diffuseCool = 0.;
        self.diffuseWarm = 1.;
        
    }
    
    return self;
    
    
}

- (BOOL)    program:(SCNProgram *)program
 bindValueForSymbol:(NSString *)symbol
         atLocation:(unsigned int)location
          programID:(unsigned int)programID
           renderer:(SCNRenderer *)renderer
{
    
    //NSLog(@" symbol %@", symbol);
    
    if ([symbol isEqualToString:@"light_position"]) {
        //NSLog(@" lightnode %@", self.lightnode);
        if(self.lightnode){
            //NSLog(@" lightnode position %f, %f, %f " , self.lightnode.position.x, self.lightnode.position.y, self.lightnode.position.z);
            glUniform3f(location, self.lightnode.position.x, self.lightnode.position.y, self.lightnode.position.z);
        }
        
        return YES; // indicate that the symbol was bound successfully.
    }
    
    if ([symbol isEqualToString:@"SurfaceColor"]) {

        if(self.lightnode){
            glUniform4f(location,[self.lightnode.light.color redComponent] , [self.lightnode.light.color greenComponent] , [self.lightnode.light.color blueComponent], 1.);
        }
        
        return YES;
    }
    if ([symbol isEqualToString:@"WarmColor"]) {
        
        if(self.warmColor){
            glUniform4f(location,[self.warmColor redComponent] , [self.warmColor greenComponent] , [self.warmColor blueComponent], [self.warmColor alphaComponent]);
        }
        
        return YES;
    }
    if ([symbol isEqualToString:@"CoolColor"]) {
        
        if(self.coolColor){
            glUniform4f(location,[self.coolColor redComponent] , [self.coolColor greenComponent] , [self.coolColor blueComponent], [self.coolColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"DiffuseCool"]) {
        
        if(self.diffuseCool){
            glUniform1f(location,self.diffuseCool);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"DiffuseWarm"]) {
        
        if(self.diffuseWarm){
            glUniform1f(location,self.diffuseWarm);
        }
        
        return YES;
    }
    
    return NO; // no symbol was bound.
}

#pragma  mark SCNProgramDelegate Protocol Methods
- (void)program:(SCNProgram*)program handleError:(NSError*)error {
    // Log the shader compilation error
    NSLog(@"SceneKit compilation error: %@", error);
}



@end
