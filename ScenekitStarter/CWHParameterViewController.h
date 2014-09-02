//
//  CWHParameterViewController.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/14/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SceneKit/SceneKit.h> 

@interface CWHParameterViewController : NSViewController
@property (nonatomic, retain) id delegate;
@property (strong) SCNProgram *program;
@end
