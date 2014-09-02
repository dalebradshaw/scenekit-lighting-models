//
//  CWHLightingModelWindowController.m
//  ScenekitStarter
//
//  Created by Dale Bradshaw on 8/1/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHLightingModelWindowController.h"
#import "CWHLightingViewController.h"
#import "CWHParameterViewController.h"
#import "CWHBlinnProgram.h"
#import "CWHBlinnParameterViewController.h"
#import "CWHEdgeFuzzProgram.h"
#import "CWHEdgeFuzzParameterViewController.h"
#import "CWHEnvMapProgram.h"
#import "CWHEnvMapParameterViewController.h"
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
    
    if ([lightingModel isEqualToString:@"EnvMap"]) {
        parameterViewController = [[CWHEnvMapParameterViewController alloc]
                                   initWithNibName:@"EnvMapParameterView" bundle:nil];
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
    Class programClass;
    NSString *strippedString = [lightingModel stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *programString = [NSString stringWithFormat:@"CWH%@Program", strippedString];
    NSLog(@"programString %@", programString);
   
    programClass = NSClassFromString(programString);
    if(programClass){
        program = (SCNProgram *)[programClass program];
    }
      
    //Key/Value coding for light node since we pass around Superclass
    [program  setValue:self.lightingViewController.lightNode forKey:@"lightnode"];
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
