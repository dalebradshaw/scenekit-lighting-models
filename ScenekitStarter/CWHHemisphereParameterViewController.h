//
//  CWHHemisphereParameterViewController.h
//  ScenekitStarter
//
//  Created by Super on 8/21/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWHParameterViewProtocol.h"
#import "CWHHemisphereProgram.h"
#import "CWHParameterViewController.h"

@interface CWHHemisphereParameterViewController : CWHParameterViewController

@property (strong) NSColor *skyColor;
- (IBAction)updateSkyColor:(id)sender;

@property (strong) NSColor *groundColor;
- (IBAction)updateGroundColor:(id)sender;

@end
