//
//  SBNavigationController.m
//  MrDoCanKit
//
//  Created by 王灿 on 3/10/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "SBNavigationController.h"

@implementation SBNavigationController

+ (void)load
{
	[MLBlackTransition validatePanPackWithMLBlackTransitionGestureRecognizerType:MLBlackTransitionGestureRecognizerTypePan
																		   class:self];
}

@end
