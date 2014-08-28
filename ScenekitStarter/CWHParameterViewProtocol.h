//
//  ParameterViewProtocol.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/4/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h> 

@protocol CWHParameterViewProtocol <NSObject>
-(void)parameterViewDidClose;
-(void)updateShaderValues:(SCNProgram *)program;
@end
