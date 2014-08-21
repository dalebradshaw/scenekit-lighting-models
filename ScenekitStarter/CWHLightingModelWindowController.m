//
//  CWHLightingModelWindowController.m
//  ScenekitStarter
//
//  Created by Super on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHLightingModelWindowController.h"
#import "CWHLightingViewController.h"
#import "CWHParameterViewController.h"
#import "CWHBlinnProgram.h"
#import "CWHBlinnParameterViewController.h"
#import "CWHEdgeFuzzProgram.h"
#import "CWHEdgeFuzzParameterViewController.h"
#import "CWHGoochProgram.h"
#import "CWHGoochParameterViewController.h"
#import "CWHHemisphereParameterViewController.h"
#import "CWHHemisphereProgram.h"
#import "CWHLambSkinProgram.h"
#import "CWHLambSkinParameterViewController.h"
#import "CWHPhongPointLightProgram.h"
#import "CWHPhongPointLightParameterViewController.h"
#import "CWHVelvetParameterViewController.h"
#import "CWHVelvetProgram.h"

@interface CWHLightingModelWindowController ()

@end

@implementation CWHLightingModelWindowController

- (void)awakeFromNib
{
    self.lightingViewController = [[CWHLightingViewController alloc] initWithNibName:@"CWHLightingView" bundle:nil];
    [targetView addSubview:[self.lightingViewController view]];

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

-(void)updateShaderValues:(SCNProgram *)program;
{
    [self.lightingViewController.torusNode updateParameters:program];
}

-(CWHParameterViewController *)parameterViewControllerForLightingModel:(NSString *)lightingModel
{
    CWHParameterViewController *parameterViewController;
    
    if([lightingModel isEqualToString:@"Phong Point Light"]){
        parameterViewController = [[CWHPhongPointLightParameterViewController alloc]
                                   initWithNibName:@"PhongPointLightParameterView" bundle:nil];
    }
    
    if ([lightingModel isEqualToString:@"Blinn"]) {
        parameterViewController = [[CWHBlinnParameterViewController alloc]
                                   initWithNibName:@"BlinnParameterView" bundle:nil];
    }
    
    if ([lightingModel isEqualToString:@"Edge Fuzz"]) {
        parameterViewController = [[CWHEdgeFuzzParameterViewController alloc]
                                   initWithNibName:@"EdgeFuzzParameterView" bundle:nil];
    }
    
    if([lightingModel isEqualToString:@"Gooch"]){
        parameterViewController = [[CWHGoochParameterViewController alloc]
                                   initWithNibName:@"GoochParameterView" bundle:nil];
    }
    
    if([lightingModel isEqualToString:@"Hemisphere"]){
        parameterViewController = [[CWHHemisphereParameterViewController alloc]
                                   initWithNibName:@"HemisphereParameterView" bundle:nil];
    }
    
    if([lightingModel isEqualToString:@"Lamb Skin"]){
        parameterViewController = [[CWHLambSkinParameterViewController alloc]
                                   initWithNibName:@"LambSkinParameterView" bundle:nil];
    }
    if ([lightingModel isEqualToString:@"Velvet"]) {
        parameterViewController = [[CWHVelvetParameterViewController alloc]
                                   initWithNibName:@"VelvetParameterView" bundle:nil];
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
        double viewHeight = parameterViewController.view.frame.size.height;
        //NSLog(@" viewHeight %f", viewHeight);
        viewHeight = 180;//calc min height here
        
        [self.lightingViewController presentViewController:parameterViewController
                                       asPopoverRelativeToRect:NSMakeRect(targetRect.origin.x / 2,
                                                                          targetRect.size.height - viewHeight / 2,
                                                                          targetRect.size.width,
                                                                          targetRect.size.height / 2)
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
    
    if ([lightingModel isEqualToString:@"Blinn"]) {
        program = [CWHBlinnProgram program];
    }
    
    if ([lightingModel isEqualToString:@"Edge Fuzz"]) {
        program = [CWHEdgeFuzzProgram program];
    }
    
    if ([lightingModel isEqualToString:@"Gooch"]) {
        program = [CWHGoochProgram program];
    }
  
    if ([lightingModel isEqualToString:@"Hemisphere"]) {
        program = [CWHHemisphereProgram program];
    }
    
    if ([lightingModel isEqualToString:@"Lamb Skin"]) {
        program = [CWHLambSkinProgram program];
    }
    
    if ([lightingModel isEqualToString:@"Velvet"]) {
        program = [CWHVelvetProgram program];
    }
    
    return program;
}

- (IBAction)updateLightingModel:(id)sender {
    NSString *updatedModel = [sender titleOfSelectedItem];
    
    NSLog(@" updateLightingModel %@", updatedModel);
    //NSLog(@"self.currentLightingProgram %@", self.currentLightingProgram);
    if(![self.currentLightingProgram isEqualToString:updatedModel]){
      
        [self.lightingViewController.torusNode updateLightingModel:[self programForLightingModel:updatedModel]];
         self.currentLightingProgram = updatedModel;
    }
   
}

@end
