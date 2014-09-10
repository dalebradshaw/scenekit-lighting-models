//
//  CWHBlinnProgram.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/29/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHPhongPointLightProgram.h"
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>

@implementation CWHPhongPointLightProgram

-(instancetype)init
{
    
    self = [super initWithProgram:@"PhongPointLight"];
    
    if ( self != nil )
    {

        //some defaults

        self.ambientColor = [NSColor colorWithRed:0. green:0. blue:0. alpha:1.];
        self.lightColor = [NSColor redColor];
        self.materialSpecularity = 1;
        self.shininess = 10.8;

    }
    
    return self;
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithProgram:@"PhongPointLight"]) {
        self.ambientColor  = [decoder decodeObjectForKey:@"ambientColor"];
        self.lightColor  = [decoder decodeObjectForKey:@"lightColor"];
        self.materialSpecularity = [decoder decodeDoubleForKey:@"materialSpecularity"];
        self.shininess = [decoder decodeDoubleForKey:@"shininess"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_ambientColor forKey:@"ambientColor"];
    [encoder encodeObject:_lightColor forKey:@"lightColor"];
    [encoder encodeDouble:_materialSpecularity forKey:@"materialSpecularity"];
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
    
    if ([symbol isEqualToString:@"shininess"]) {
        
        if(self.shininess){
            //NSLog(@" self.shininess %f", self.shininess);
            glUniform1f(location, self.shininess);
        }
        
        return YES; // indicate that the symbol was bound successfully.
    }
    
    if ([symbol isEqualToString:@"material_specular"]) {

        if(self.materialSpecularity){
            //NSLog(@" self.materialSpecularity %f", self.materialSpecularity);
            glUniform1f(location, self.materialSpecularity);
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
