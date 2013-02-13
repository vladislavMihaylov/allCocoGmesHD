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

@interface ScramblingFrancois : CCNode
{
    AnimationNode *body;
    AnimationNode *panzer;
    AnimationNode *leftEye;
    AnimationNode *rightEye;
    
    float currentSpeed;
}

@property (nonatomic, assign) AnimationNode *body;

+ (ScramblingFrancois *) createWithSpeed: (float) speed;
- (void) increaseSpeed;
- (float) getCurrentCocoSpeed;
- (void) showTransitionAnimation;
- (void) jumpOnMountain;
- (void) setSpeed: (float) speedParam;

- (void) pauseAllActions;
- (void) unPauseAllActions;


@end
