//
//  CWHBlinnProgram.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/29/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHBlinnProgram.h"
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>

@implementation CWHBlinnProgram

-(instancetype)init
{
    
    self = [super init];
    
    if ( self != nil )
    {
        
        NSURL *vertexShaderURL   = [[NSBundle mainBundle] URLForResource:@"Blinn" withExtension:@"vsh"];
        NSURL *fragmentShaderURL = [[NSBundle mainBundle] URLForResource:@"Blinn" withExtension:@"fsh"];
        
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
        self.ambientColor = [NSColor colorWithRed:0. green:0. blue:0. alpha:1.];
        self.lightColor = [NSColor redColor];
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
    
    if ([symbol isEqualToString:@"light_color"]) {

        if(self.lightColor){
            
            glUniform3f(location,[self.lightColor redComponent] , [self.lightColor greenComponent] , [self.lightColor blueComponent]);
            
        }else{
            if(self.lightnode){
                glUniform3f(location,[self.lightnode.light.color redComponent] , [self.lightnode.light.color greenComponent] , [self.lightnode.light.color blueComponent]);
            }
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"light_ambient"]) {
        
        if(self.ambientColor){
            //NSLog(@" self.ambient red %f green %f blue %f", [self.ambientColor redComponent], [self.ambientColor greenComponent], [self.ambientColor blueComponent]);
            glUniform3f(location,[self.ambientColor redComponent] , [self.ambientColor greenComponent] , [self.ambientColor blueComponent]);
            
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
