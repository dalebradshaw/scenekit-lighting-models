//
//  CWHEnvMapProgram.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/25/14.
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
        NSColor *diffuseColor = [NSColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.];
        self.diffuseColor = diffuseColor;
        NSColor *ambientColor = [NSColor colorWithRed:0. green:0. blue:0. alpha:1.];
        self.ambientColor = ambientColor;
        self.ratio = 0.875;
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"EnvMapInterior" ofType:@"png"];
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
   
    if ([symbol isEqualToString:@"Environment"]) {

        NSError *error = nil;
        GLuint gError = glGetError();
        GLKTextureInfo *texture = [GLKTextureLoader textureWithContentsOfFile: self.imagePath options:nil error:&error];
        //NSLog(@" texture %@", texture);
        if(!texture){
            NSLog(@"GL Error = %u", gError);
            NSLog(@"Error loading file %@", [error localizedDescription] );
        }
        
        glBindTexture(GL_TEXTURE_2D, texture.name);
        
        return YES;
    }
    if ([symbol isEqualToString:@"DiffuseColor"]) {
        
        if(self.diffuseColor){
             // NSLog(@" self.diffuseColor red %f green %f blue %f", [self.diffuseColor redComponent], [self.diffuseColor greenComponent], [self.diffuseColor blueComponent]);
            glUniform4f(location,[self.diffuseColor redComponent] , [self.diffuseColor greenComponent] , [self.diffuseColor blueComponent], [self.diffuseColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"AmbientColor"]) {
        
        if(self.ambientColor){
            //NSLog(@" self.ambient red %f green %f blue %f", [self.ambientColor redComponent], [self.ambientColor greenComponent], [self.ambientColor blueComponent]);
            glUniform4f(location,[self.ambientColor redComponent] , [self.ambientColor greenComponent] , [self.ambientColor blueComponent], [self.ambientColor alphaComponent]);
        }
        
        return YES;
    }
    
    
    if ([symbol isEqualToString:@"Ratio"]) {
        
        if(self.ratio){
            //NSLog(@" self.ratio %f", self.ratio);
            glUniform1f(location,self.ratio);
        }
        
        return YES;
    }
    
    return NO;
}

@end
