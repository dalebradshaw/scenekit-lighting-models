//
//  ParameterViewProtocol.h
//  ScenekitStarter
//
//  Created by Super on 8/4/14.
//  Copyright (c) 2014 Creative Workflow Hacks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParameterViewProtocol <NSObject>
-(void)parameterViewDidClose;
-(void)updateShaderValues:(NSDictionary *)values;
@end
