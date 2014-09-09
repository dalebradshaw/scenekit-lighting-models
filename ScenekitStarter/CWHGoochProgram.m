//
//  CWHBlinnProgram.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/29/14.
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
        NSColor *surfaceColor = [NSColor redColor];
        self.surfaceColor = surfaceColor;
        
        NSColor *coolColor = [NSColor colorWithRed:0.2 green:1. blue:0.2 alpha:1.];
        self.coolColor = coolColor;

        NSColor *warmColor = [NSColor purpleColor];
        self.warmColor = warmColor;
       
        
        self.diffuseCool = 0.;
        self.diffuseWarm = 1.;
        
    }
    
    return self;
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.coolColor =[decoder decodeObjectForKey:@"coolColor"];
        self.warmColor  = [decoder decodeObjectForKey:@"warmColor"];
        self.diffuseCool  = [decoder decodeDoubleForKey:@"diffuseCool"];
        self.diffuseWarm  = [decoder decodeDoubleForKey:@"diffuseWarm"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_coolColor forKey:@"coolColor"];
    [encoder encodeObject:_warmColor forKey:@"warmColor"];
    [encoder encodeDouble:_diffuseCool forKey:@"diffuseCool"];
    [encoder encodeDouble:_diffuseWarm forKey:@"diffuseWarm"];
    
     self.delegate = self;
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
       
        if(self.surfaceColor){
             //NSLog(@"self.surfaceColor %f %f %f", [self.surfaceColor redComponent], [self.surfaceColor blueComponent], [self.surfaceColor greenComponent]);
             glUniform4f(location,[self.surfaceColor redComponent] , [self.surfaceColor greenComponent] , [self.surfaceColor blueComponent], [self.surfaceColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"WarmColor"]) {
        
        if(self.warmColor){
            //NSLog(@"self.warmColor %f %f %f", [self.warmColor redComponent], [self.warmColor blueComponent], [self.warmColor greenComponent]);
            glUniform4f(location,[self.warmColor redComponent] , [self.warmColor greenComponent] , [self.warmColor blueComponent], [self.warmColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"CoolColor"]) {
        
        if(self.coolColor){
            //NSLog(@"self.coolColor %f %f %f", [self.coolColor redComponent], [self.coolColor blueComponent], [self.coolColor greenComponent]);
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
