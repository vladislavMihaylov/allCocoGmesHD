//
//  Coco.m
//  testApp
//
//  Created by Mac on 30.09.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MorphFrancois.h"
#import "MorphGameLayer.h"
#import "MorphGameConfig.h"

@implementation MorphFrancois

@synthesize gameLayer;
@synthesize runningFrancois;

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithSpeed: (float) speed
{
    if(self = [super init])
    {
        swimmingFrancois = [SwimmingFrancois createWithSpeed: 0];
        runningFrancois = [RunningFrancois createWithSpeed: 0];
        scramblingFrancois = [ScramblingFrancois createWithSpeed: 0];
        goingDownFrancois = [GoingDownFrancois createWithSpeed: 0];
        
        [swimmingFrancois retain];
        swimmingFrancois.tag = kSwimmingAction;
        
        [runningFrancois retain];
        runningFrancois.tag = kRunningAction;
        
        [scramblingFrancois retain];
        scramblingFrancois.tag = kScramblingAction;
        
        [goingDownFrancois retain];
        goingDownFrancois.tag = kGoingDownAction;
        //goingDownCoco.scaleX = -1;
        
        currentGroundSpeed = 0;
    }
    
    return self;
}

- (void) setFinishZ
{
    [runningFrancois setFinishZZ];
    [swimmingFrancois setFinishZZ];
}

- (void) hideCoco
{
    [runningFrancois hide];
}

- (void) rotate: (NSInteger) type andCurrentGround: (NSInteger) curGround
{
    CCLOG(@"Type: %i", type);
    if(type == 1000)
    {
        if(curGround == 1004)
        {
            if(iCanDown)
            {
                [goingDownFrancois jumpFromMountain];
                [goingDownFrancois setSpeed: currentGroundSpeed];
                
                iCanDown = NO;
            }
            
            //[runningCoco jumpFromMountain];
        }
        else
        {
            if(iCanDown)
            {
                [runningFrancois showTransitionAnimation];
            }
        }
        //[self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 2], [CCCallFunc actionWithTarget: self selector: @selector(setNormalCocoOrientation)], nil]];
    }
    if(type == 1001)
    {
        [runningFrancois hide];
        [swimmingFrancois showTransitionAnimation];
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
        
        [scramblingFrancois showTransitionAnimation];
        [scramblingFrancois setSpeed: currentGroundSpeed];
        //[self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 2], [CCCallFunc actionWithTarget: self selector: @selector(setNormalCocoOrientation)], nil]];
    }
    if(type == 1003)
    {
        [scramblingFrancois jumpOnMountain];
    }
    if(curGround == 1004)
    {
        //[runningFrancois jumpFromMountain];
        //[goingDownFrancois jumpFromMountain];
        //[goingDownFrancois setSpeed: currentGroundSpeed];
    }
    if(type == 1004)
    {
        [goingDownFrancois jumpOnAGround];
        [runningFrancois setLastYPosition];
    }
    
}

- (void) runScramblCoco
{
    //[goingDownCoco setSpeed: groundSpeed];
}

- (void) setNormalCocoOrientation
{
    [runningFrancois setNormalOrientation];
}

- (void) doVisibleCoco
{
    [runningFrancois show];
}

- (void) stopRun
{
    [runningFrancois setSpeed: 0];
}

- (void) doAction: (NSInteger) numberOfAction withSpeed: (float) speed
{
    groundSpeed = currentGroundSpeed;
    
    if(numberOfAction == 0)
    {
        if(currentAction != kRunningAction)
        {
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: runningFrancois z: 2];
            currentAction = kRunningAction;
            francoisPosition = runningFrancois.body.position;
            
            if(afterJump)
            {
                afterJump = NO;
                runningFrancois.body.position = ccp(runningFrancois.body.position.x, 155);
            }
        }
        
        [runningFrancois increaseSpeed];
        currentGroundSpeed = [runningFrancois getCurrentCocoSpeed];
        //[currentCoco increaseSpeed];
    }
    else if(numberOfAction == 1)
    {
        if(currentAction != kSwimmingAction)
        {
            
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: swimmingFrancois z: -5];
            currentAction = kSwimmingAction;
            francoisPosition = swimmingFrancois.body.position;
        }
        
        [swimmingFrancois increaseSpeed];
        currentGroundSpeed = [swimmingFrancois getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }
    else if(numberOfAction == 2)
    {
        if(currentAction == kRunningAction)
        {
            ICanJump = NO;
            
            currentGroundSpeed = 7;//[runningCoco getCurrentCocoSpeed];
            [runningFrancois reorderTo: 2];
            [runningFrancois setSpeed: currentGroundSpeed];
            [runningFrancois runAction: [CCJumpTo actionWithDuration: 0.7 position: self.position height: 50 jumps: 1]];
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
            [self addChild: scramblingFrancois z: 2];
            currentAction = kScramblingAction;
        }
        
        [scramblingFrancois increaseSpeed];
        currentGroundSpeed = [scramblingFrancois getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }
    else if(numberOfAction == 4)
    {
        if(currentAction != kGoingDownAction)
        {
            [self removeChildByTag: currentAction cleanup: NO];
            [self addChild: goingDownFrancois z: 2];
            currentAction = kGoingDownAction;
        }
        //[goingDownCoco setSpeed: groundSpeed];
        [goingDownFrancois increaseSpeed];
        currentGroundSpeed = [goingDownFrancois getCurrentCocoSpeed];
        
        //[currentCoco increaseSpeed];
    }
    
}

- (void) pauseAll
{
    [runningFrancois pauseSchedulerAndActions];
    [swimmingFrancois pauseSchedulerAndActions];
    [scramblingFrancois pauseSchedulerAndActions];
    [goingDownFrancois pauseSchedulerAndActions];
}

- (void) transitionsPause
{
    [runningFrancois pauseAllActions];
    [swimmingFrancois pauseAllActions];
    [scramblingFrancois pauseAllActions];
    [goingDownFrancois pauseAllActions];
}

- (void) transitionsUnPause
{
    [runningFrancois unPauseAllActions];
    [swimmingFrancois unPauseAllActions];
    [scramblingFrancois unPauseAllActions];
    [goingDownFrancois unPauseAllActions];
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


+ (MorphFrancois *) createWithSpeed: (float) speed
{
    MorphFrancois *francois = [[[MorphFrancois alloc] initWithSpeed: speed] autorelease];
    
    return francois;
}

@end
