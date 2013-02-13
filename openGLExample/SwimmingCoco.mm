//
//  SwimmingCoco.m
//  testApp
//
//  Created by Mac on 30.09.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SwimmingCoco.h"
#import "MorphGameConfig.h"

@implementation SwimmingCoco

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithSpeed: (float) speed
{
    if(self = [super init])
    {CGPoint positionBody = ccp(210, 105);
        CGPoint anchorBody = ccp(0.5, 0.4);
        //NSInteger zBody = 2;
        
        CGPoint positionHead = ccp(23, 60);
        CGPoint anchorHead = ccp(0.5, 0.3);
        
        CGPoint positionTail = ccp(15, 13);
        CGPoint anchorTail = ccp(1, 0);
        
        CGPoint positionRightHand = ccp(15, 25);
        CGPoint anchorRightHand = ccp(0.5, 1.0);
        
        CGPoint positionLeftHand = ccp(25, 15);
        CGPoint anchorLeftHand = ccp(0.5, 1.0);
        
        CGPoint positionRightFootUp = ccp(25, 15);
        CGPoint anchorRightFootUp = ccp(0.5, 1.0);
        
        CGPoint positionRightFootDown = ccp(9, 5);
        CGPoint anchorRightFootDown = ccp(0.1, 0.9);
        
        CGPoint positionLeftFootUp = ccp(25, 15);
        CGPoint anchorLeftFootUp = ccp(0.5, 1.0);
        
        CGPoint positionLeftFootDown = ccp(9, 5);
        CGPoint anchorLeftFootDown = ccp(0.1, 0.9);
        
        body = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoBody.png"] position: positionBody anchorPoint: anchorBody andSpeed: speed];
        [body addFrame: AFrame(0, 90)];
        [body addFrame: AFrame(1, 87)];
        [body addFrame: AFrame(2, 90)];
        [body addFrame: AFrame(3, 93)];
        [body addFrame: AFrame(4, 90)];
        
        head = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoSwimHead.png"]  position: positionHead anchorPoint: anchorHead andSpeed: speed];
        [head addFrame: AFrame(0, -90)];
        [head addFrame: AFrame(1, -95)];
        [head addFrame: AFrame(2, -90)];
        [head addFrame: AFrame(3, -85)];
        [head addFrame: AFrame(4, -90)];
        
        tail = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoTail.png"]  position: positionTail anchorPoint: anchorTail andSpeed: speed];
        [tail addFrame: AFrame(0, -50)];
        [tail addFrame: AFrame(1, -45)];
        [tail addFrame: AFrame(2, -50)];
        [tail addFrame: AFrame(3, -45)];
        [tail addFrame: AFrame(4, -50)];
        
        
        rightHand = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoRightHand.png"]  position: positionRightHand anchorPoint: anchorRightHand andSpeed: speed];
        [rightHand addFrame: AFrame(0, 180)];
        [rightHand addFrame: AFrame(1, 270)];
        [rightHand addFrame: AFrame(2, 360)];
        [rightHand addFrame: AFrame(3, 450)];
        [rightHand addFrame: AFrame(4, 540)];
        
        leftHand = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftHand.png"]  position: positionLeftHand anchorPoint: anchorLeftHand andSpeed: speed];
        [leftHand addFrame: AFrame(0, 0)];
        [leftHand addFrame: AFrame(1, 90)];
        [leftHand addFrame: AFrame(2, 180)];
        [leftHand addFrame: AFrame(3, 270)];
        [leftHand addFrame: AFrame(4, 360)];
        
        rightFootUp = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootUp.png"]  position: positionRightFootUp anchorPoint: anchorRightFootUp andSpeed: speed];
        [rightFootUp addFrame: AFrame(0, 0)];
        [rightFootUp addFrame: AFrame(1, 15)];
        [rightFootUp addFrame: AFrame(2, 0)];
        [rightFootUp addFrame: AFrame(3, -15)];
        [rightFootUp addFrame: AFrame(4, 0)];
        
        rightFootDown = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoSwimLeftFootDown.png"]  position: positionRightFootDown anchorPoint: anchorRightFootDown andSpeed: speed];
        [rightFootDown addFrame: AFrame(0, 10)];
        [rightFootDown addFrame: AFrame(1, 40)];
        [rightFootDown addFrame: AFrame(2, 10)];
        [rightFootDown addFrame: AFrame(3, 40)];
        [rightFootDown addFrame: AFrame(4, 10)];
        
        leftFootUp = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootUp.png"]  position: positionLeftFootUp anchorPoint: anchorLeftFootUp andSpeed: speed];
        [leftFootUp addFrame: AFrame(0, 0)];
        [leftFootUp addFrame: AFrame(1, -15)];
        [leftFootUp addFrame: AFrame(2, 0)];
        [leftFootUp addFrame: AFrame(3, 15)];
        [leftFootUp addFrame: AFrame(4, 0)];
        
        leftFootDown = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoSwimLeftFootDown.png"]  position: positionLeftFootDown anchorPoint: anchorLeftFootDown andSpeed: speed];
        [leftFootDown addFrame: AFrame(0, 10)];
        [leftFootDown addFrame: AFrame(1, 40)];
        [leftFootDown addFrame: AFrame(2, 10)];
        [leftFootDown addFrame: AFrame(3, 40)];
        [leftFootDown addFrame: AFrame(4, 10)];
        
        body.position = positionBody;
        head.position = positionHead;
        tail.position = positionTail;
        rightHand.position = positionRightHand;
        leftHand.position = positionLeftHand;
        rightFootUp.position = positionRightFootUp;
        rightFootDown.position = positionRightFootDown;
        leftFootUp.position = positionLeftFootUp;
        leftFootDown.position = positionLeftFootDown;
        
        
        [self addChild: body z: -2];
        [body addChildToNode: head withZ: 1];
        [body addChildToNode: tail withZ: -1];
        [body addChildToNode: rightHand withZ: 1];
        [body addChildToNode: leftHand withZ: -1];
        [body addChildToNode: rightFootUp withZ: 1];
        [rightFootUp addChildToNode: rightFootDown withZ: 1];
        [body addChildToNode: leftFootUp withZ: -1];
        [leftFootUp addChildToNode: leftFootDown withZ: 1];
    }
    
    return self;
}

- (void) showTransitionAnimation
{
    [body runAction:
     [CCJumpTo actionWithDuration: 2
                         position: ccp(body.position.x, 155)
                           height: 100
                            jumps: 1]
     
     ];
    
    [body runAction: [CCRotateTo actionWithDuration: 2 angle: -90]];
    [head runAction: [CCRotateTo actionWithDuration: 2 angle: 90]];
    
    afterSwim = YES;
}


- (void) setSpeed: (float) speedParam
{
    [body setSpeedOfAnimation: speedParam];
    [head setSpeedOfAnimation: speedParam];
    [tail setSpeedOfAnimation: speedParam];
    [rightHand setSpeedOfAnimation: speedParam];
    //[leftHand setSpeedOfAnimation: speedParam];
    [rightFootUp setSpeedOfAnimation: speedParam];
    [rightFootDown setSpeedOfAnimation: speedParam];
    [leftFootUp setSpeedOfAnimation: speedParam];
    [leftFootDown setSpeedOfAnimation: speedParam];
}

- (void) increaseSpeed
{
    [body increaseSpeedAnimation];
    [head increaseSpeedAnimation];
    [tail increaseSpeedAnimation];
    [rightHand increaseSpeedAnimation];
    [leftHand increaseSpeedAnimation];
    [rightFootUp increaseSpeedAnimation];
    [rightFootDown increaseSpeedAnimation];
    [leftFootUp increaseSpeedAnimation];
    [leftFootDown increaseSpeedAnimation];
}

- (float) getCurrentCocoSpeed
{
    currentSpeed = [body getCurrentSpeed];
    //CCLOG(@"currentSpeed = %f", currentSpeed);
    
    return currentSpeed;
    
}

- (void) pauseAllActions
{
    [body pauseSchedulerAndActions];
    [head pauseSchedulerAndActions];
}

- (void) unPauseAllActions
{
    [body resumeSchedulerAndActions];
    [head resumeSchedulerAndActions];
}



+ (SwimmingCoco *) createWithSpeed: (float) speed
{
    SwimmingCoco *swimmingCoco = [[[SwimmingCoco alloc] initWithSpeed: speed] autorelease];
    
    return swimmingCoco;
}

@end
