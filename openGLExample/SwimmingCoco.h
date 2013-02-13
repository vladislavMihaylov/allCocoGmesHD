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

@interface SwimmingCoco : CCNode 
{
    AnimationNode *body;
    AnimationNode *head;
    AnimationNode *tail;
    AnimationNode *rightHand;
    AnimationNode *leftHand;
    AnimationNode *rightFootUp;
    AnimationNode *rightFootDown;
    AnimationNode *leftFootUp;
    AnimationNode *leftFootDown;
    
    float currentSpeed;
}

+ (SwimmingCoco *) createWithSpeed: (float) speed;
- (void) increaseSpeed;
- (float) getCurrentCocoSpeed;
- (void) pauseAllActions;
- (void) unPauseAllActions;



- (void) showTransitionAnimation;


@end
