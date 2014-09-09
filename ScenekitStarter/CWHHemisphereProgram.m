//
// CWHHemisphereProgram
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/30/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHHemisphereProgram.h"
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>

@implementation CWHHemisphereProgram

-(instancetype)init
{
    
    self = [super init];
    
    if ( self != nil )
    {
        
        NSURL *vertexShaderURL   = [[NSBundle mainBundle] URLForResource:@"Hemisphere" withExtension:@"vsh"];
        NSURL *fragmentShaderURL = [[NSBundle mainBundle] URLForResource:@"Hemisphere" withExtension:@"fsh"];
        
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
        
        NSColor *skyColor = [NSColor colorWithRed:0.0 green:0.7 blue:1. alpha:1.];
        self.skyColor = skyColor;
        NSColor *groundColor = [NSColor colorWithRed:0.7 green:0.5 blue:0.2 alpha:1.];
        self.groundColor = groundColor;
        
    }
    
    return self;
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.skyColor =[decoder decodeObjectForKey:@"skyColor"];
        self.groundColor  = [decoder decodeObjectForKey:@"groundColor"];
      
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_skyColor forKey:@"skyColor"];
    [encoder encodeObject:_groundColor forKey:@"groundColor"];
    
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
    
    if ([symbol isEqualToString:@"SkyColor"]) {
        
        if(self.skyColor){
            //NSLog(@" skyColor %f, %f, %f", [self.skyColor redComponent], [self.skyColor greenComponent], [self.skyColor blueComponent]);
            glUniform4f(location,[self.skyColor redComponent] , [self.skyColor greenComponent] , [self.skyColor blueComponent], [self.skyColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"GroundColor"]) {
        
        if(self.groundColor){
            //NSLog(@" groundColor %f, %f, %f", [self.groundColor redComponent], [self.groundColor greenComponent], [self.groundColor blueComponent]);
            glUniform4f(location,[self.groundColor redComponent] , [self.groundColor  greenComponent] , [self.groundColor  blueComponent], [self.groundColor  alphaComponent]);
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
