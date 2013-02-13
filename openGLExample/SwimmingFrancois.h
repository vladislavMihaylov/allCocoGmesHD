//
//  SwimmingCoco.h
//  testApp
//
//  Created by Mac on 30.09.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "AnimationNode.h"

@interface SwimmingFrancois : CCNode
{
    AnimationNode *body;
    AnimationNode *panzer;
    AnimationNode *leftEye;
    AnimationNode *rightEye;
    
    float currentSpeed;
}

@property (nonatomic, assign) AnimationNode *body;

+ (SwimmingFrancois *) createWithSpeed: (float) speed;
- (void) increaseSpeed;
- (float) getCurrentCocoSpeed;
- (void) pauseAllActions;
- (void) unPauseAllActions;
- (void) setFinishZZ;


- (void) showTransitionAnimation;


@end
