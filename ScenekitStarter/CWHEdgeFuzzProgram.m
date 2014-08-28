//
//  CWHEdgeFuzzProgram.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/31/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHEdgeFuzzProgram.h"
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>

@implementation CWHEdgeFuzzProgram

-(instancetype)init
{
    
    self = [super init];
    
    if ( self != nil )
    {
        
        NSURL *vertexShaderURL   = [[NSBundle mainBundle] URLForResource:@"EdgeFuzz" withExtension:@"vsh"];
        NSURL *fragmentShaderURL = [[NSBundle mainBundle] URLForResource:@"EdgeFuzz" withExtension:@"fsh"];
        
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
        NSColor *surfaceColor = [NSColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:1.];
        self.surfaceColor = surfaceColor;
        NSColor *edgeColor = [NSColor colorWithRed:0.4 green:0.8 blue:1. alpha:1.];
        self.edgeColor = edgeColor;
        NSColor *lightColor = [NSColor colorWithRed:1. green:1. blue:1. alpha:1.];
        self.lightColor = lightColor;
        NSColor *ambientColor = [NSColor colorWithRed:0. green:0. blue:0. alpha:1.];
        self.ambientColor = ambientColor;
        
        self.fuzziness = 0.166;
        self.edgeFade = 3.868;
        self.specularity = 0.1488;
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
    
    if ([symbol isEqualToString:@"EdgeColor"]) {
        
        if(self.edgeColor){
            glUniform4f(location,[self.edgeColor redComponent] , [self.edgeColor greenComponent] , [self.edgeColor blueComponent], 1.);
        }
        
        return YES;
    }

    if ([symbol isEqualToString:@"SurfaceColor"]) {
        
        if(self.surfaceColor){
            glUniform4f(location,[self.surfaceColor redComponent] , [self.surfaceColor greenComponent] , [self.surfaceColor blueComponent], 1.);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"LightColor"]) {
        
        if(self.lightColor){
            glUniform4f(location,[self.lightColor redComponent] , [self.lightColor greenComponent] , [self.lightColor blueComponent], [self.lightColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"AmbientColor"]) {
        
        if(self.ambientColor){
            glUniform4f(location,[self.ambientColor redComponent] , [self.ambientColor greenComponent] , [self.ambientColor blueComponent], [self.ambientColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"Fuzziness"]) {
        
        if(self.fuzziness){
            glUniform1f(location,self.fuzziness);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"EdgeFade"]) {
        
        if(self.edgeFade){
            glUniform1f(location,self.edgeFade);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"Specularity"]) {
        
        if(self.specularity){
            glUniform1f(location,self.specularity);
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
