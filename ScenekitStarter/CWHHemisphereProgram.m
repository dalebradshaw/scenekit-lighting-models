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
    
    self = [super initWithProgram:@"Hemisphere"];
    
    if ( self != nil )
    {
        
        NSColor *skyColor = [NSColor colorWithRed:0.0 green:0.7 blue:1. alpha:1.];
        self.skyColor = skyColor;
        NSColor *groundColor = [NSColor colorWithRed:0.7 green:0.5 blue:0.2 alpha:1.];
        self.groundColor = groundColor;
        
    }
    
    return self;
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
     if (self = [super initWithProgram:@"Hemisphere"]) {
        self.skyColor =[decoder decodeObjectForKey:@"skyColor"];
        self.groundColor  = [decoder decodeObjectForKey:@"groundColor"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_skyColor forKey:@"skyColor"];
    [encoder encodeObject:_groundColor forKey:@"groundColor"];
    
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
