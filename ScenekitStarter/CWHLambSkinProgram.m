//
//  CWHLambSkinProgram.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/31/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHLambSkinProgram.h"
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>

@implementation CWHLambSkinProgram

-(instancetype)init
{
    
    self = [super initWithProgram:@"LambSkin"];
    
    if ( self != nil )
    {
        
        // Become the program delegate so that you get the binding callback
        self.delegate = self;
        
        NSColor *diffuseColor = [NSColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.];
        self.diffuseColor = diffuseColor;
        NSColor *ambientColor = [NSColor colorWithRed:0. green:0. blue:0. alpha:1.];
        self.ambientColor = ambientColor;
        NSColor *subColor = [NSColor colorWithRed:1. green:0. blue:0. alpha:1.];
        self.subColor = subColor;
        self.rolloff = 0.575;
    }
    
    return self;
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.diffuseColor =[decoder decodeObjectForKey:@"diffuseColor"];
        self.ambientColor  = [decoder decodeObjectForKey:@"ambientColor"];
        self.subColor = [decoder decodeObjectForKey:@"subColor"];
        self.rolloff = [decoder decodeDoubleForKey:@"rolloff"];
        
        self.delegate = self;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_diffuseColor forKey:@"diffuseColor"];
    [encoder encodeObject:_ambientColor forKey:@"ambientColor"];
    [encoder encodeObject:_subColor forKey:@"subColor"];
    [encoder encodeDouble:_rolloff forKey:@"rolloff"];
    
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
        
        if(self.lightnode){
            //NSLog(@" light_color %f, %f, %f", [self.lightnode.light.color redComponent], [self.lightnode.light.color greenComponent], [self.lightnode.light.color blueComponent]);
            glUniform3f(location,[self.lightnode.light.color redComponent] , [self.lightnode.light.color greenComponent] , [self.lightnode.light.color blueComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"DiffuseColor"]) {
        
        if(self.diffuseColor){
            glUniform4f(location,[self.diffuseColor redComponent] , [self.diffuseColor greenComponent] , [self.diffuseColor blueComponent], [self.diffuseColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"AmbientColor"]) {
        
        if(self.ambientColor){
            glUniform4f(location,[self.ambientColor redComponent] , [self.ambientColor greenComponent] , [self.ambientColor blueComponent], [self.ambientColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"SubColor"]) {
        
        if(self.subColor){
            glUniform4f(location,[self.subColor redComponent] , [self.subColor greenComponent] , [self.subColor blueComponent], [self.subColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"Rolloff"]) {
        
        if(self.rolloff){
            glUniform1f(location,self.rolloff);
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
