//
//  GameViewController.m
//  ScenekitStarter
//
//  Created by Super on 7/24/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

-(void)awakeFromNib
{
    // create a new scene
    SCNScene *scene = [SCNScene scene];

    // create and add a camera to the scene
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    [scene.rootNode addChildNode:cameraNode];
    
    // place the camera
    cameraNode.position = SCNVector3Make(0, 0, 15);
    
    // create and add an ambient light to the scene
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.name = @"light";
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.position = SCNVector3Make(0, 10, 10);
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [NSColor redColor];
    [scene.rootNode addChildNode:ambientLightNode];
    
    
    SCNAction *moveByAction = [SCNAction moveBy:SCNVector3Make(20, 30, 10) duration:2];
    moveByAction.timingMode = SCNActionTimingModeEaseInEaseOut;
    SCNAction *reversed = [moveByAction reversedAction];
    
    [ambientLightNode  runAction:[SCNAction repeatActionForever:[SCNAction sequence:@[moveByAction, reversed]]]];

    SCNTorus *torusShape = [SCNTorus torusWithRingRadius:3.
                                              pipeRadius:1.];
    
    
    CWHShadingNode *torusNode = [[CWHShadingNode alloc] initWithGeometry:torusShape];
    torusNode.position = SCNVector3Make(0., 0., 0.);
    torusNode.scale = SCNVector3Make(1., 1., 1.);
    
    [torusNode runAction:[SCNAction repeatActionForever:[SCNAction rotateByX:2 y:0 z:0 duration:1]]];
    
    self.torusNode = torusNode;
    
    [scene.rootNode addChildNode:self.torusNode];
    
    
    // set the scene to the view
    self.gameView.scene = scene;
    
    // allows the user to manipulate the camera
    self.gameView.allowsCameraControl = YES;
    
    // show statistics such as fps and timing information
    self.gameView.showsStatistics = YES;
    
    // configure the view
    self.gameView.backgroundColor = [NSColor blackColor];  
}

@end
