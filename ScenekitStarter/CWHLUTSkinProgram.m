//
//  CWHLUTSkinProgram.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/31/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHLUTSkinProgram.h"
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>

@implementation CWHLUTSkinProgram

-(instancetype)init
{
    
    self = [super initWithProgram:@"LUTSkin"];
    
    if ( self != nil )
    {

        //some defaults

        self.diffuseColor = [NSColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.];;
        self.specularColor = [NSColor whiteColor];
        self.scatterColor = [NSColor redColor];
        self.wrap = 0.58;
        self.scatterWidth = 0.10;
        self.shininess = 0.35;
        
    }
    
    return self;
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithProgram:@"LUTSkin"]) {
        self.diffuseColor  = [decoder decodeObjectForKey:@"diffuseColor"];
        self.specularColor  = [decoder decodeObjectForKey:@"specularColor"];
        self.scatterColor  = [decoder decodeObjectForKey:@"scatterColor"];
        self.wrap = [decoder decodeDoubleForKey:@"wrap"];
        self.scatterWidth = [decoder decodeDoubleForKey:@"scatterWidth"];
        self.shininess = [decoder decodeDoubleForKey:@"shininess"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_diffuseColor forKey:@"diffuseColor"];
    [encoder encodeObject:_specularColor forKey:@"specularColor"];
    [encoder encodeObject:_scatterColor forKey:@"scatterColor"];
    [encoder encodeDouble:_wrap forKey:@"wrap"];
    [encoder encodeDouble:_scatterWidth forKey:@"scatterWidth"];
    [encoder encodeDouble:_shininess forKey:@"shininess"];
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
    
    if ([symbol isEqualToString:@"diffuseColor"]) {
        
        if(self.diffuseColor){
            
            glUniform3f(location,[self.diffuseColor redComponent] , [self.diffuseColor greenComponent] , [self.diffuseColor blueComponent]);
            
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"specularColor"]) {
        
        if(self.specularColor){
            //NSLog(@" self.ambient red %f green %f blue %f", [self.ambientColor redComponent], [self.ambientColor greenComponent], [self.ambientColor blueComponent]);
            glUniform3f(location,[self.specularColor redComponent] , [self.specularColor greenComponent] , [self.specularColor blueComponent]);
            
        }
        
        return YES;
    }
    if ([symbol isEqualToString:@"scatterColor"]) {
        
        if(self.scatterColor){
            //NSLog(@" self.ambient red %f green %f blue %f", [self.ambientColor redComponent], [self.ambientColor greenComponent], [self.ambientColor blueComponent]);
            glUniform3f(location,[self.scatterColor redComponent] , [self.scatterColor greenComponent] , [self.scatterColor blueComponent]);
            
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"wrap"]) {
        
        if(self.wrap){
            //NSLog(@" self.materialSpecularity %f", self.materialSpecularity);
            glUniform1f(location, self.wrap);
        }
        
        return YES; // indicate that the symbol was bound successfully.
    }
    
    if ([symbol isEqualToString:@"scatterWidth"]) {
        
        if(self.scatterWidth){
            //NSLog(@" self.materialSpecularity %f", self.materialSpecularity);
            glUniform1f(location, self.scatterWidth);
        }
        
        return YES; // indicate that the symbol was bound successfully.
    }
    
    
    if ([symbol isEqualToString:@"shininess"]) {
        
        if(self.shininess){
            //NSLog(@" self.shininess %f", self.shininess);
            glUniform1f(location, self.shininess);
        }
        
        return YES; // indicate that the symbol was bound successfully.
    }
    

    
    
    return NO; // no symbol was bound.
}

#pragma  mark SCNProgramDelegate Protocol Methods
- (void)program:(SCNProgram*)program handleError:(NSError*)error {
    // Log the shader compilation error
    NSLog(@"SceneKit compilation error: %@", error);
}


@end
