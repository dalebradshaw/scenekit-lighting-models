//
//  AppDelegate.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 7/24/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "AppDelegate.h"
#import "CWHLightingModelWindowController.h"

@implementation AppDelegate


// -------------------------------------------------------------------------------
//	newDocument:sender
// -------------------------------------------------------------------------------
- (IBAction)newDocument:(id)sender
{
    if(windowController == nil)
    {
       windowController = [[CWHLightingModelWindowController alloc] initWithWindowNibName:@"LightingModelWindow"];
    }
    
    [windowController showWindow:self];
}

// -------------------------------------------------------------------------------
//	applicationDidFinishLaunching:notification
// -------------------------------------------------------------------------------
- (void)applicationDidFinishLaunching:(NSNotification*)notification
{
    [self newDocument:self];
}


// -------------------------------------------------------------------------------
//	validateMenuItem:theMenuItem
// -------------------------------------------------------------------------------
- (BOOL)validateMenuItem:(NSMenuItem *)theMenuItem
{
    BOOL enable = [self respondsToSelector:[theMenuItem action]];
    
    // disable "New" if the window is already up
    if ([theMenuItem action] == @selector(newDocument:))
    {
        if ([[windowController window] isKeyWindow])
        {
            enable = NO;
        }
    }
    return enable;
}


@end
