//
//  RosanControllerManager.h
//  Rosan
//
//  Created by Levante on 2017/9/26.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParameterHeader.h"

@interface RosanControllerManager : NSObject

SYNTHESIZE_SINGLETON_FOR_HEADER(RosanControllerManager)

- (void)popToLogin;

- (void)createTabbarController;
@end
