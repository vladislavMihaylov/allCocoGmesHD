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

@interface GoingDownFrancois : CCNode
{
    AnimationNode *body;
    AnimationNode *panzer;
    AnimationNode *leftEye;
    AnimationNode *rightEye;
    
    float currentSpeed;
}

@property (nonatomic, assign) AnimationNode *body;

+ (GoingDownFrancois *) createWithSpeed: (float) speed;
- (void) increaseSpeed;
- (float) getCurrentCocoSpeed;
- (void) setSpeed: (float) speedParam;
- (void) jumpFromMountain;
- (void) jumpOnAGround;

- (void) pauseAllActions;
- (void) unPauseAllActions;


@end
