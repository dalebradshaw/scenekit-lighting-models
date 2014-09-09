//
//  CWHThinFilmProgram.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/28/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHThinFilmProgram.h"


@implementation CWHThinFilmProgram
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *vertexShaderURL   = [[NSBundle mainBundle] URLForResource:@"ThinFilm" withExtension:@"vsh"];
        NSURL *fragmentShaderURL = [[NSBundle mainBundle] URLForResource:@"ThinFilm" withExtension:@"fsh"];
        
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
        
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"FringeMap" ofType:@"png"];
        
        NSError *error = nil;
        GLuint gError = glGetError();
        self.texture = [GLKTextureLoader textureWithContentsOfFile:imagePath  options:nil error:&error];
        if (gError != 0) {
            NSLog(@"error %@", error);
            NSLog(@"GL Error = %u", gError);
        }
        
        self.filmDepth = 1.35;
        self.diffuseColor = [NSColor grayColor];
        
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
    
    if ([symbol isEqualToString:@"diffColor"]) {
        
        if(self.diffuseColor){
            NSLog(@" self.diffuseColor red %f green %f blue %f", [self.diffuseColor redComponent], [self.diffuseColor greenComponent], [self.diffuseColor blueComponent]);
            glUniform3f(location,[self.diffuseColor redComponent] , [self.diffuseColor greenComponent] , [self.diffuseColor blueComponent]);
            
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"FringeMap"]) {
        
        //NSLog(@" self.texture %@", self.texture);
        if(!self.texture){
            NSError *error = nil;
            GLuint gError = glGetError();
            NSLog(@"GL Error = %u", gError);
            NSLog(@"Error loading file %@", [error localizedDescription] );
        }
        
        glBindTexture(GL_TEXTURE_2D, self.texture.name);
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"FilmDepth"]) {
        
        if(self.filmDepth){
            //NSLog(@" self.filmDepth %f", self.filmDepth);
            glUniform1f(location,self.filmDepth);
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
