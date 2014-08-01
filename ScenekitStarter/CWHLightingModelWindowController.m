//
//  CWHLightingModelWindowController.m
//  ScenekitStarter
//
//  Created by Super on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHLightingModelWindowController.h"
#import "LightingViewController.h"

@interface CWHLightingModelWindowController ()

@end

@implementation CWHLightingModelWindowController

- (void)awakeFromNib
{
    self.lightingViewController = [[LightingViewController alloc] initWithNibName:@"LightingView" bundle:nil];
    //NSLog(@"self.lightingViewController %@", self.lightingViewController);
    [targetView addSubview:[self.lightingViewController view]];
    //NSLog(@"self.scene %@", self.lightingViewController.view);
    //NSLog(@"self.window.contentView %@", self.window.contentView);
}

- (void)windowDidLoad {
    [super windowDidLoad];
   
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}



@end
