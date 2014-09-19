//
//  CWHGlossyWetHighlightParameterViewController.m
//  ScenekitStarter
//
//  Created by Super on 9/12/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import "CWHGlossyWetHighlightParameterViewController.h"

@interface CWHGlossyWetHighlightParameterViewController ()

@end

@implementation CWHGlossyWetHighlightParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    NSColor *ambientColor = [self.program valueForKey:@"ambientColor"];
    
    if (ambientColor) {
        [self.ambientColorWell setColor:ambientColor];
        
    }
    
    NSColor *diffuseColor = [self.program valueForKey:@"diffuseColor"];
    
    if (diffuseColor) {
        [self.diffuseColorWell setColor:diffuseColor];
        
    }
    
    NSColor *specularColor = [self.program valueForKey:@"specularColor"];
    
    if (specularColor) {
        [self.diffuseColorWell setColor:specularColor];
        
    }
    
    double glossMin = [[self.program valueForKey:@"glossMin"] doubleValue];
    if (glossMin >= 0) {
        [self.glossMinSlider setDoubleValue:glossMin];
        [self.glossMinTextField setDoubleValue:glossMin];
        
    }
    
    double glossMax = [[self.program valueForKey:@"glossMax"] doubleValue];
    if (glossMax >= 0) {
        [self.glossMaxSlider setDoubleValue:glossMax];
        [self.glossMaxTextField setDoubleValue:glossMax];
        
    }
    
    double glossDrop = [[self.program valueForKey:@"glossDrop"] doubleValue];
    if (glossDrop >= 0) {
        [self.glossDropSlider setDoubleValue:glossDrop];
        [self.glossDropTextField setDoubleValue:glossDrop];
        
    }
    
    double specularity = [[self.program valueForKey:@"specularity"] doubleValue];
    if (specularity >= 0) {
        [self.specularitySlider setDoubleValue:specularity];
        [self.specularityTextField setDoubleValue:specularity];
        
    }
    
    double specularExponent = [[self.program valueForKey:@"specularExponent"] doubleValue];
    if (specularExponent >= 0) {
        [self.specularExponentSlider setDoubleValue:specularExponent];
        [self.specularExponentTextField setDoubleValue:specularExponent];
        
    }
}

- (IBAction)updateGlossMin:(id)sender {
    if ([sender isKindOfClass:[NSSlider class]]) {
       [self.glossMinTextField setDoubleValue:[sender doubleValue]];
    }else{
       [self.glossMinSlider setDoubleValue:[sender doubleValue]];
    }
    
    [self updateShaderValues];
    
}

- (IBAction)updateGlossMax:(id)sender {
    if ([sender isKindOfClass:[NSSlider class]]) {
       [self.glossMaxTextField setDoubleValue:[sender doubleValue]];
    }else{
       [self.glossMaxSlider setDoubleValue:[sender doubleValue]];
    }
    
    [self updateShaderValues];
}

- (IBAction)updateGlossDrop:(id)sender {
    if ([sender isKindOfClass:[NSSlider class]]) {
       [self.glossDropTextField setDoubleValue:[sender doubleValue]];
    }else{
       [self.glossDropSlider setDoubleValue:[sender doubleValue]];
    }
    
    [self updateShaderValues];
    
}

- (IBAction)updateSpecularExponent:(id)sender {
    
    if ([sender isKindOfClass:[NSSlider class]]) {
       [self.specularExponentTextField setDoubleValue:[sender doubleValue]];
    }else{
       [self.specularExponentSlider setDoubleValue:[sender doubleValue]];
    }
    
    [self updateShaderValues];
}

- (IBAction)updateSpecularity:(id)sender {
    
    if ([sender isKindOfClass:[NSSlider class]]) {
       [self.specularityTextField setDoubleValue:[sender doubleValue]];
    }else{
       [self.specularitySlider setDoubleValue:[sender doubleValue]];
    }
    
    [self updateShaderValues];
}

- (IBAction)updateDiffuseColor:(id)sender {
    [self updateShaderValues];
}

- (IBAction)updateAmbientColor:(id)sender {
    [self updateShaderValues];
}

- (IBAction)updateSpecularColor:(id)sender {
    [self updateShaderValues];
}

-(void)updateShaderValues
{
    CWHGlossyWetHighlightProgram *program = [CWHGlossyWetHighlightProgram program];
    program.glossMin = [self.glossMinSlider doubleValue];
    program.glossMax = [self.glossMaxSlider doubleValue];
    program.glossDrop = [self.glossDropSlider doubleValue];
    program.specularExponent = [self.specularExponentSlider doubleValue];
    program.specularity = [self.specularitySlider doubleValue];
    program.specularColor = [self.specularColorWell color];
    program.ambientColor = [self.ambientColorWell color];
    program.diffuseColor = [self.diffuseColorWell color];
    
    [self.delegate updateShaderValues:program];
}
@end
