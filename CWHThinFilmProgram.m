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
    self = [super initWithProgram:@"ThinFilm"];
    
    if ( self != nil )
    {
        
        self.imagePath = [[NSBundle mainBundle] pathForResource:@"FringeMap" ofType:@"png"];
        
        NSError *error = nil;
        GLuint gError = glGetError();
        self.texture = [GLKTextureLoader textureWithContentsOfFile:self.imagePath  options:nil error:&error];
        if (gError != 0) {
            NSLog(@"error %@", error);
            NSLog(@"GL Error = %u", gError);
        }
        
       //defaults
        self.filmDepth = 0.75;
        self.diffuseColor = [NSColor grayColor];
        
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithProgram:@"ThinFilm"]) {
        NSString *imagePath =[decoder decodeObjectForKey:@"imagePath"];
        if (imagePath) {
           self.imagePath  = imagePath;
        }else{
            self.imagePath = [[NSBundle mainBundle] pathForResource:@"FringeMap" ofType:@"png"];
        }
        
        self.diffuseColor  = [decoder decodeObjectForKey:@"diffuseColor"];
        self.filmDepth = [decoder decodeDoubleForKey:@"filmDepth"];
        
        NSError *error = nil;
        GLuint gError = glGetError();
        self.texture = [GLKTextureLoader textureWithContentsOfFile:self.imagePath  options:nil error:&error];
        if (gError != 0) {
            NSLog(@"error %@", error);
            NSLog(@"GL Error = %u", gError);
        }
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_imagePath forKey:@"imagePath"];
    [encoder encodeObject:_diffuseColor forKey:@"diffuseColor"];
    [encoder encodeDouble:_filmDepth  forKey:@"filmDepth"];
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
            //NSLog(@" self.diffuseColor red %f green %f blue %f", [self.diffuseColor redComponent], [self.diffuseColor greenComponent], [self.diffuseColor blueComponent]);
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
