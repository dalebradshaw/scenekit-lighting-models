//
//  CWHHemisphereParameterViewController.h
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/21/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWHParameterViewProtocol.h"
#import "CWHHemisphereProgram.h"
#import "CWHParameterViewController.h"

@interface CWHHemisphereParameterViewController : CWHParameterViewController

@property (weak) IBOutlet NSColorWell *skyColorWell;
@property (strong) NSColor *skyColor;
- (IBAction)updateSkyColor:(id)sender;

@property (weak) IBOutlet NSColorWell *groundColorWell;
@property (strong) NSColor *groundColor;
- (IBAction)updateGroundColor:(id)sender;

@end
