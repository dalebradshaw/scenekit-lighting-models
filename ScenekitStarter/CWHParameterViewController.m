//
//  CWHParameterViewController.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/14/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHParameterViewController.h"


@interface CWHParameterViewController ()

@end

@implementation CWHParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)popoverWillClose:(NSNotification *)notification
{

    if ([self.delegate respondsToSelector:@selector(parameterViewWillClose)]) {
        [self.delegate parameterViewWillClose];
    }
    
    NSString *closeReason = [[notification userInfo] valueForKey:NSPopoverCloseReasonKey];
    if (closeReason)
    {
        // closeReason can be:
        //      NSPopoverCloseReasonStandard
        //      NSPopoverCloseReasonDetachToWindow
        //
        // add new code here if you want to respond "before" the popover closes
        //
    }
}

@end
