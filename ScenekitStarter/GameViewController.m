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
    
    // create and add a light to the scene
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, 10, 10);
    [scene.rootNode addChildNode:lightNode];
    
    // create and add an ambient light to the scene
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [NSColor darkGrayColor];
    [scene.rootNode addChildNode:ambientLightNode];
    
    
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
