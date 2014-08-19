//
//  CWHBlinnParameterViewController.h
//  ScenekitStarter
//
//  Created by Super on 8/15/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHParameterViewProtocol.h"
#import "CWHParameterViewController.h"
#import "CWHBlinnProgram.h"

@interface CWHBlinnParameterViewController : CWHParameterViewController

@property (weak) IBOutlet NSColorWell *ambientColorWell;
@property (weak) IBOutlet NSColorWell *lightColorWell;

@property (strong) NSColor *ambientColor;
- (IBAction)updateAmbientColor:(id)sender;

@property (strong) NSColor *lightColor;
- (IBAction)updateLightColor:(id)sender;


@end
