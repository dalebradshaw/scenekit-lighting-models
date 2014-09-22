//
//  CWHGlossyWetHighlightProgram.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/31/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHGlossyWetHighlightProgram.h"
#import <GLKit/GLKit.h>
#import <OpenGL/gl.h>
#import <OpenGL/glext.h>

@implementation CWHGlossyWetHighlightProgram

-(instancetype)init
{
    
    self = [super initWithProgram:@"GlossyWetHighlight"];
    
    if ( self != nil )
    {
      
        self.ambientColor = [NSColor colorWithRed:0. green:0. blue:0. alpha:1.];
        self.diffuseColor = [NSColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.];
        self.specularColor = [NSColor colorWithRed:1. green:0. blue:0. alpha:1.];
        self.specularity = 0.3;
        self.specularExponent = 3.0;
        self.glossMax = 1.349;
        self.glossMin = 1.199;
        self.glossDrop = 2.661;
    }
    
    return self;
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithProgram:@"GlossyWetHighlight"]) {
       
        self.ambientColor  = [decoder decodeObjectForKey:@"ambientColor"];
        self.diffuseColor = [decoder decodeObjectForKey:@"diffuseColor"];
        self.specularColor = [decoder decodeObjectForKey:@"specularColor"];
        self.specularity = [decoder decodeDoubleForKey:@"specularity"];
        self.specularExponent= [decoder decodeDoubleForKey:@"specularExponent"];
        self.glossMax= [decoder decodeDoubleForKey:@"glossMax"];
        self.glossMin= [decoder decodeDoubleForKey:@"glossMin"];
        self.glossDrop = [decoder decodeDoubleForKey:@"glossDrop"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_ambientColor forKey:@"ambientColor"];
    [encoder encodeObject:_diffuseColor forKey:@"diffuseColor"];
    [encoder encodeObject:_specularColor forKey:@"specularColor"];
    [encoder encodeDouble:_specularity forKey:@"specularity"];
    [encoder encodeDouble:_specularExponent forKey:@"specularExponent"];
    [encoder encodeDouble:_glossMax forKey:@"glossMax"];
    [encoder encodeDouble:_glossMin forKey:@"glossMin"];
    [encoder encodeDouble:_glossDrop forKey:@"glossDrop"];
    
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
    
    if ([symbol isEqualToString:@"AmbientColor"]) {
        
        if(self.ambientColor){
            glUniform4f(location,[self.ambientColor redComponent] , [self.ambientColor greenComponent] , [self.ambientColor blueComponent], [self.ambientColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"SpecularColor"]) {
        
        if(self.specularColor){
            glUniform4f(location,[self.specularColor redComponent] , [self.specularColor greenComponent] , [self.specularColor blueComponent], [self.specularColor alphaComponent]);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"diffuseColor"]) {
        
        if(self.diffuseColor){
            glUniform4f(location,[self.diffuseColor redComponent] , [self.diffuseColor greenComponent] , [self.diffuseColor blueComponent], [self.diffuseColor alphaComponent]);
        }
        
        return YES;
    }
 
    
    if ([symbol isEqualToString:@"Specularity"]) {
        
        if(self.specularity){
            glUniform1f(location,self.specularity);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"SpecularExponent"]) {
        
        if(self.specularExponent){
            glUniform1f(location,self.specularExponent);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"GlossMin"]) {
        
        if(self.glossMin){
            glUniform1f(location,self.glossMin);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"GlossMax"]) {
        
        if(self.glossMax){
            glUniform1f(location,self.glossMax);
        }
        
        return YES;
    }
    
    if ([symbol isEqualToString:@"GlossDrop"]) {
        
        if(self.glossDrop){
            glUniform1f(location,self.glossDrop);
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
