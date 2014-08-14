//
//  CWHLightingModelWindowController.m
//  ScenekitStarter
//
//  Created by Super on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHLightingModelWindowController.h"
#import "LightingViewController.h"
#import "CWHParameterViewController.h"
#import "CWHGoochParameterViewController.h"
#import "CWHPhongPointLightParameterViewController.h"
#import "CWHPhongPointLightProgram.h"
#import "CWHGoochProgram.h"

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
    self.lightingParameterState = FALSE;
    self.currentLightingProgram = @"Phong Point Light";
}

- (void)windowDidLoad {
    [super windowDidLoad];
   
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)parameterViewDidClose{
    self.lightingParameterState = FALSE;
}

-(void)updateShaderValues:(NSDictionary *)values
{
    [self.lightingViewController.torusNode updateParameters:values];
}

-(CWHParameterViewController *)parameterViewControllerForLightingModel:(NSString *)lightingModel
{
    CWHParameterViewController *parameterViewController;
    
    if([lightingModel isEqualToString:@"Phong Point Light"]){
        parameterViewController = [[CWHPhongPointLightParameterViewController alloc]
                                                                    initWithNibName:@"PhongPointLightParameterView" bundle:nil];
    }

    if([lightingModel isEqualToString:@"Gooch"]){
        parameterViewController = [[CWHGoochParameterViewController alloc]
                                   initWithNibName:@"GoochParameterView" bundle:nil];
    }
    
    return parameterViewController;
}

-(IBAction)showInputParameters:(id)sender
{

    if(self.lightingParameterState == FALSE){

        NSRect targetRect = [targetView frame];
        CGFloat toolbarHeight = 0;
        NSRect  windowFrame;
        windowFrame = [NSWindow contentRectForFrameRect:targetView.window.frame
                                              styleMask:targetView.window.styleMask];
        toolbarHeight = NSHeight(windowFrame) - NSHeight([targetView frame]);
       
        /*
        NSLog(@"toolbarHeight %@", NSStringFromRect(windowFrame));
        NSLog(@"parameterView.frame %@", NSStringFromRect(parameterViewController.view.frame));
        NSLog(@" bounds %@", NSStringFromRect(targetRect));
        */
        
        CWHParameterViewController *parameterViewController = [self parameterViewControllerForLightingModel:self.currentLightingProgram];
        
        [self.lightingViewController presentViewController:parameterViewController
                                       asPopoverRelativeToRect:NSMakeRect(targetRect.origin.x / 2, targetRect.size.height - parameterViewController.view.frame.size.height / 2 + 9, targetRect.size.width, targetRect.size.height / 2)
                                                        ofView:targetView
                                                 preferredEdge:NSMinYEdge
                                                      behavior:NSPopoverBehaviorTransient];
        parameterViewController.delegate = self;
        
       
        self.lightingParameterState = TRUE;
    }else{
        self.lightingParameterState = FALSE;
    }

}

-(SCNProgram *)programForLightingModel:(NSString *)lightingModel
{
    SCNProgram *program;
    if([lightingModel isEqualToString:@"Phong Point Light"]){
        program = [CWHPhongPointLightProgram program];
    }
    
    if ([lightingModel isEqualToString:@"Gooch"]) {
        program = [CWHGoochProgram program];
    }
    
    return program;
}

- (IBAction)updateLightingModel:(id)sender {
    NSString *updatedModel = [sender titleOfSelectedItem];
    
    NSLog(@" updateLightingModel %@", updatedModel);
    if(![self.currentLightingProgram isEqualToString:updatedModel]){
    
        [self.lightingViewController.torusNode updateLightingModel:[self programForLightingModel:updatedModel]];
         self.currentLightingProgram = updatedModel;
    }
   
}

@end
