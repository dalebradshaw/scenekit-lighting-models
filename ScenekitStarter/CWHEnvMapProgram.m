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
    self = [super initWithProgram:@"EnvMap"];
    
    if ( self != nil )
    {
        NSColor *diffuseColor = [NSColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.];
        self.diffuseColor = diffuseColor;
        NSColor *ambientColor = [NSColor colorWithRed:0. green:0. blue:0. alpha:1.];
        self.ambientColor = ambientColor;
        self.ratio = 0.875;
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"EnvMapInterior" ofType:@"png"];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithProgram:@"EnvMap"]) {
        self.diffuseColor =[decoder decodeObjectForKey:@"diffuseColor"];
        self.ambientColor  = [decoder decodeObjectForKey:@"ambientColor"];
        self.ratio  = [decoder decodeDoubleForKey:@"ratio"];
        self.imagePath = [decoder decodeObjectForKey:@"imagePath"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_diffuseColor forKey:@"diffuseColor"];
    [encoder encodeObject:_ambientColor forKey:@"ambientColor"];
    [encoder encodeDouble:_ratio forKey:@"ratio"];
    [encoder encodeObject:_imagePath forKey:@"imagePath"];
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
