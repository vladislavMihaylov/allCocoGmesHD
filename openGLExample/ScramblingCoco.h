//
//  JumpingCoco.h
//  morphing
//
//  Created by Vlad on 12.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


#import "AnimationNode.h"

@interface ScramblingCoco : CCNode
{
    AnimationNode *body;
    AnimationNode *head;
    AnimationNode *tail;
    AnimationNode *rightHandUp;
    AnimationNode *rightHandDown;
    AnimationNode *leftHandUp;
    AnimationNode *leftHandDown;
    AnimationNode *rightFootUp;
    AnimationNode *rightFootMiddle;
    AnimationNode *rightFootDown;
    AnimationNode *leftFootUp;
    AnimationNode *leftFootMiddle;
    AnimationNode *leftFootDown;
    
    float currentSpeed;
}

+ (ScramblingCoco *) createWithSpeed: (float) speed;
- (void) increaseSpeed;
- (float) getCurrentCocoSpeed;
- (void) showTransitionAnimation;
- (void) jumpOnMountain;
- (void) setSpeed: (float) speedParam;

- (void) pauseAllActions;
- (void) unPauseAllActions;


@end
