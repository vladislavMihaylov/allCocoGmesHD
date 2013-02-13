//
//  Coco.m
//  testApp
//
//  Created by Mac on 30.09.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MorphCoco.h"
#import "MorphGameLayer.h"
#import "MorphGameConfig.h"

@implementation MorphCoco

@synthesize gameLayer;
@synthesize runningCoco;

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithSpeed: (float) speed
{
    if(self = [super init])
    {
        swimmingCoco = [SwimmingCoco createWithSpeed: 0];
        runningCoco = [RunningCoco createWithSpeed: 0];
        scramblingCoco = [ScramblingCoco createWithSpeed: 0];
        goingDownCoco = [GoingDownCoco createWithSpeed: 0];
        
        [swimmingCoco retain];
        swimmingCoco.tag = kSwimmingAction;
        
        [runningCoco retain];
        runningCoco.tag = kRunningAction;
        
        [scramblingCoco retain];
        scramblingCoco.tag = kScramblingAction;
        
        [goingDownCoco retain];
        goingDownCoco.tag = kGoingDownAction;
        //goingDownCoco.scaleX = -1;
        
        currentGroundSpeed = 0;
        
        
    }
    
    return self;
}

- (void) hideCoco
{
    [runningCoco hide];
}

- (void) rotate: (NSInteger) type andCurrentGround: (NSInteger) curGround
{
    CCLOG(@"Type: %i", type);
    if(type == 1000)
    {
        if(curGround == 1004)
        {
            [goingDownCoco jumpFromMountain];
            [goingDownCoco setSpeed: currentGroundSpeed];

            //[runningCoco jumpFromMountain];
        }
        else
        {
            [runningCoco showTransitionAnimation];
        }
                //[self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 2], [CCCallFunc actionWithTarget: self selector: @selector(setNormalCocoOrientation)], nil]];
    }
    if(type == 1001)
    {
        [runningCoco hide];
        [swimmingCoco showTransitionAnimation];
        [self runAction:
                [CCSequence actions:
                        [CCDelayTime actionWithDuration: 2],
                        [CCCallFunc actionWithTarget: self
                                            selector: @selector(setNormalCocoOrientation)],
                        [CCDelayTime actionWithDuration: 0.02],
                        [CCCallFunc actionWithTarget: self
                                            selector: @selector(doVisibleCoco)],
                 nil]
         ];
    }
    if(type == 1002)
    {
        
        [scramblingCoco showTransitionAnimation];
        [scramblingCoco setSpeed: currentGroundSpeed];
        //[self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 2], [CCCallFunc actionWithTarget: self selector: @selector(setNormalCocoOrientation)], nil]];
    }
    if(type == 1003)
    {
        [scramblingCoco jumpOnMountain];
    }
    if(curGround == 1004)
    {
        //[runningCoco jumpFromMountain];
        //[goingDownCoco jumpFromMountain];
        //[goingDownCoco setSpeed: currentGroundSpeed];
    }
    if(type == 1004)
    {
        [goingDownCoco jumpOnAGround];
        [runningCoco setLastYPosition];
    }

}

- (void) runScramblCoco
{
    //[goingDownCoco setSpeed: groundSpeed];
}

- (void) setNormalCocoOrientation
{
    [runningCoco setNormalOrientation];
}

- (void) doVisibleCoco
{
    [runningCoco show];
}

- (void) stopRun
{
    [runningCoco setSpeed: 0];
}

- (void) doAction: (NSInteger) numberOfAction withSpeed: (float) speed
{
    groundSpeed = currentGroundSpeed;
    
    if(numberOfAction == 0)
    {
        if(currentAction != kRunningAction)
        {
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: runningCoco z: 2];
            currentAction = kRunningAction;
        }
        [runningCoco increaseSpeed];
        currentGroundSpeed = [runningCoco getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }
    else if(numberOfAction == 1)
    {        
        if(currentAction != kSwimmingAction)
        {
            
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: swimmingCoco z: -5];
            currentAction = kSwimmingAction;
        }
        
        [swimmingCoco increaseSpeed];
        currentGroundSpeed = [swimmingCoco getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }
    else if(numberOfAction == 2)
    {
        if(currentAction == kRunningAction)
        {
            ICanJump = NO;
            currentGroundSpeed = 7;//[runningCoco getCurrentCocoSpeed];
            [runningCoco setSpeed: currentGroundSpeed];
            [runningCoco runAction: [CCJumpTo actionWithDuration: 0.7 position: self.position height: 50 jumps: 1]];
            [self runAction:
                    [CCSequence actions:
                                [CCDelayTime actionWithDuration: 0.7],
                                [CCCallFunc actionWithTarget: self
                                                    selector: @selector(solveJump)],
                     nil]
             ];
        }
    }
    else if(numberOfAction == 3)
    {
        if(currentAction != kScramblingAction)
        {
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: scramblingCoco z: 2];
            currentAction = kScramblingAction;
        }
        
        [scramblingCoco increaseSpeed];
        currentGroundSpeed = [scramblingCoco getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }
    else if(numberOfAction == 4)
    {
        if(currentAction != kGoingDownAction)
        {
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: goingDownCoco z: 2];
            currentAction = kGoingDownAction;
        }
        //[goingDownCoco setSpeed: groundSpeed];
        [goingDownCoco increaseSpeed];
        currentGroundSpeed = [goingDownCoco getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }

}

- (void) pauseAll
{
    [runningCoco pauseSchedulerAndActions];
    [swimmingCoco pauseSchedulerAndActions];
    [scramblingCoco pauseSchedulerAndActions];
    [goingDownCoco pauseSchedulerAndActions];
}

- (void) transitionsPause
{
    [runningCoco pauseAllActions];
    [swimmingCoco pauseAllActions];
    [scramblingCoco pauseAllActions];
    [goingDownCoco pauseAllActions];
}

- (void) transitionsUnPause
{
    [runningCoco unPauseAllActions];
    [swimmingCoco unPauseAllActions];
    [scramblingCoco unPauseAllActions];
    [goingDownCoco unPauseAllActions];
}

- (float) getCurrentGroundSpeed
{
    return currentGroundSpeed;
}

- (void) solveJump
{
    ICanJump = YES;
}

- (void) increaseSpeed
{
    [body increaseSpeedAnimation];
    [head increaseSpeedAnimation];
    [rightHand increaseSpeedAnimation];
    [leftHand increaseSpeedAnimation];
    [rightFoot increaseSpeedAnimation];
    [leftFoot increaseSpeedAnimation];
}

- (void) stopCoco
{
    [body setSpeed: 0];
    [head setSpeed: 0];
    [rightHand setSpeed: 0];
    [leftHand setSpeed: 0];
    [rightFoot setSpeed: 0];
    [leftFoot setSpeed: 0];
}


+ (MorphCoco *) createWithSpeed: (float) speed
{
    MorphCoco *coco = [[[MorphCoco alloc] initWithSpeed: speed] autorelease];
    
    return coco;
}

@end
