//
//  CWHVelvetProgram.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/30/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHVelvetProgram.h"
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>

@implementation CWHVelvetProgram

-(instancetype)init
{
    
    self = [super initWithProgram:@"Velvet"];
    
    if ( self != nil )
    {
        
        //defaults
        NSColor *underColor = [NSColor colorWithRed:0.7 green:0.7 blue:0 alpha:1.];
        self.underColor = underColor;
        NSColor *fuzzColor = [NSColor colorWithRed:0.9 green:0.7 blue:0.5 alpha:1.];
        self.fuzzColor = fuzzColor;
        self.rolloff = 0.528;
    }
    
    return self;
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithProgram:@"Velvet"]) {
        self.underColor  = [decoder decodeObjectForKey:@"underColor"];
        self.fuzzColor  = [decoder decodeObjectForKey:@"fuzzColor"];
        self.primaryColor  = [decoder decodeObjectForKey:@"primaryColor"];
        self.rolloff = [decoder decodeDoubleForKey:@"rolloff"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_underColor forKey:@"underColor"];
    [encoder encodeObject:_fuzzColor forKey:@"fuzzColor"];
    [encoder encodeObject:_primaryColor forKey:@"primaryColor"];
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
    
    if ([symbol isEqualToString:@"PrimaryColor"]) {
        
        if(self.lightnode){
            glUniform4f(location,[self.lightnode.light.color redComponent] , [self.lightnode.light.color greenComponent] , [self.lightnode.light.color blueComponent], 1.);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"UnderColor"]) {
        
        if(self.underColor){
            glUniform4f(location,[self.underColor redComponent] , [self.underColor greenComponent] , [self.underColor blueComponent], [self.underColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"FuzzColor"]) {
        
        if(self.fuzzColor){
            glUniform4f(location,[self.fuzzColor redComponent] , [self.fuzzColor greenComponent] , [self.fuzzColor blueComponent], [self.fuzzColor alphaComponent]);
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
