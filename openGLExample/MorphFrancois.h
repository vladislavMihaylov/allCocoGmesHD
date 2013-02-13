//
//  Coco.h
//  testApp
//
//  Created by Mac on 30.09.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "AnimationNode.h"

#import "RunningFrancois.h"
#import "SwimmingFrancois.h"
#import "ScramblingFrancois.h"
#import "GoingDownFrancois.h"

@class MorphGameLayer;

@interface MorphFrancois : CCNode
{
    MorphGameLayer *gameLayer;
    
    RunningFrancois *runningFrancois;
    SwimmingFrancois *swimmingFrancois;
    ScramblingFrancois *scramblingFrancois;
    GoingDownFrancois *goingDownFrancois;
    
    AnimationNode *body;
    AnimationNode *head;
    AnimationNode *rightHand;
    AnimationNode *leftHand;
    AnimationNode *rightFoot;
    AnimationNode *leftFoot;
    
    NSInteger groundSpeed;
    NSInteger currentAction;
    float currentGroundSpeed;
    
    CGPoint francoisPosition;
    
}

@property (nonatomic, assign) MorphGameLayer *gameLayer;
@property (nonatomic, assign) RunningFrancois *runningFrancois;

+ (MorphFrancois *) createWithSpeed: (float) speed;

- (void) setFinishZ;
- (void) doAction: (NSInteger) numberOfAction withSpeed: (float) speed;
- (float) getCurrentGroundSpeed;
- (void) stopCoco;
- (void) rotate: (NSInteger) type andCurrentGround: (NSInteger) curGround;
- (void) hideCoco;
- (void) stopRun;
- (void) pauseAll;
- (void) transitionsPause;
- (void) transitionsUnPause;

@end
