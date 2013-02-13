//
//  JumpingCoco.m
//  morphing
//
//  Created by Vlad on 12.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GoingDownCoco.h"
#import "MorphGameConfig.h"

@implementation GoingDownCoco

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithSpeed: (float) speed
{
    if(self = [super init])
    {
        CGPoint positionBody = ccp(235, 140);
        CGPoint anchorBody = ccp(0.5, 0.4);
        NSInteger zBody = 2;
        
        CGPoint positionHead = ccp(15, 65);
        CGPoint anchorHead = ccp(0.5, 0.3);
        
        CGPoint positionTail = ccp(10, 13);
        CGPoint anchorTail = ccp(1, 0);
        
        CGPoint positionRightHandUp = ccp(25, 30);
        CGPoint anchorRightHandUp = ccp(0.5, 1.0);
        
        CGPoint positionRightHandDown = ccp(10, 3);
        CGPoint anchorRightHandDown = ccp(0.5, 1.0);
        
        CGPoint positionLeftHandUp = ccp(25, 30);
        CGPoint anchorLeftHandUp = ccp(0.5, 1.0);
        
        CGPoint positionLeftHandDown = ccp(10, 3);
        CGPoint anchorLeftHandDown = ccp(0.5, 1.0);
        
        CGPoint positionRightFootUp = ccp(23, 15);
        CGPoint anchorRightFootUp = ccp(0.5, 1.0);
        
        CGPoint positionRightFootMiddle = ccp(7, 5);
        CGPoint anchorRightFootMiddle = ccp(0.5, 0.9);
        
        CGPoint positionRightFootDown = ccp(3, 3);
        CGPoint anchorRightFootDown = ccp(0, 0.5);
        
        CGPoint positionLeftFootUp = ccp(27, 15);
        CGPoint anchorLeftFootUp = ccp(0.5, 1.0);
        
        CGPoint positionLeftFootMiddle = ccp(7, 5);
        CGPoint anchorLeftFootMiddle = ccp(0.5, 0.9);
        
        CGPoint positionLeftFootDown = ccp(3, 3);
        CGPoint anchorLeftFootDown = ccp(0, 0.5);
        
        body = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoBody.png"] position: positionBody anchorPoint: anchorBody andSpeed: speed];
        [body addFrame: AFrame(0, 13)];
        [body addFrame: AFrame(1, 10)];
        [body addFrame: AFrame(2, 13)];
        [body addFrame: AFrame(3, 10)];
        [body addFrame: AFrame(4, 13)];
        
        head = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"roosterMinerHead.png"]  position: positionHead anchorPoint: anchorHead andSpeed: speed];
        [head addFrame: AFrame(0, 0)];
        [head addFrame: AFrame(1, 5)];
        [head addFrame: AFrame(2, 0)];
        [head addFrame: AFrame(3, -5)];
        [head addFrame: AFrame(4, 0)];
        
        tail = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoTail.png"]  position: positionTail anchorPoint: anchorTail andSpeed: speed];
        [tail addFrame: AFrame(0, 0)];
        [tail addFrame: AFrame(1, 5)];
        [tail addFrame: AFrame(2, 0)];
        [tail addFrame: AFrame(3, -5)];
        [tail addFrame: AFrame(4, 0)];
        
        
        rightHandUp = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftHandUp.png"]  position: positionRightHandUp anchorPoint: anchorRightHandUp andSpeed: speed];
        [rightHandUp addFrame: AFrame(0, -135)];
        [rightHandUp addFrame: AFrame(1, -45)];
        [rightHandUp addFrame: AFrame(2, 20)];
        [rightHandUp addFrame: AFrame(3, -45)];
        [rightHandUp addFrame: AFrame(4, -135)];
        
        rightHandDown = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftHandDown.png"]  position: positionRightHandDown anchorPoint: anchorRightHandDown andSpeed: speed];
        [rightHandDown addFrame: AFrame(0, 0)];
        [rightHandDown addFrame: AFrame(1, -150)];
        [rightHandDown addFrame: AFrame(2, -120)];
        [rightHandDown addFrame: AFrame(3, -90)];
        [rightHandDown addFrame: AFrame(4, 0)];
        
        leftHandUp = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftHandUp.png"]  position: positionLeftHandUp anchorPoint: anchorLeftHandUp andSpeed: speed];
        [leftHandUp addFrame: AFrame(0, 20)];
        [leftHandUp addFrame: AFrame(1, -45)];
        [leftHandUp addFrame: AFrame(2, -135)];
        [leftHandUp addFrame: AFrame(3, -45)];
        [leftHandUp addFrame: AFrame(4, 20)];
        
        leftHandDown = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftHandDown.png"]  position: positionLeftHandDown anchorPoint: anchorLeftHandDown andSpeed: speed];
        [leftHandDown addFrame: AFrame(0, -120)];
        [leftHandDown addFrame: AFrame(1, -90)];
        [leftHandDown addFrame: AFrame(2, 0)];
        [leftHandDown addFrame: AFrame(3, -150)];
        [leftHandDown addFrame: AFrame(4, -120)];
        
        rightFootUp = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootUp.png"]  position: positionRightFootUp anchorPoint: anchorRightFootUp andSpeed: speed];
        [rightFootUp addFrame: AFrame(0, 0)];
        [rightFootUp addFrame: AFrame(1, -90)];
        [rightFootUp addFrame: AFrame(2, -60)];
        [rightFootUp addFrame: AFrame(3, -30)];
        [rightFootUp addFrame: AFrame(4, 0)];
        
        rightFootMiddle = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootMiddle.png"]  position: positionRightFootMiddle anchorPoint: anchorRightFootMiddle andSpeed: speed];
        [rightFootMiddle addFrame: AFrame(0, 0)];
        [rightFootMiddle addFrame: AFrame(1, 100)];
        [rightFootMiddle addFrame: AFrame(2, 120)];
        [rightFootMiddle addFrame: AFrame(3, 100)];
        [rightFootMiddle addFrame: AFrame(4, 0)];
        
        rightFootDown = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootDown.png"]  position: positionRightFootDown anchorPoint: anchorRightFootDown andSpeed: speed];
        [rightFootDown addFrame: AFrame(0, 0)];
        [rightFootDown addFrame: AFrame(1, -20)];
        [rightFootDown addFrame: AFrame(2, 0)];
        [rightFootDown addFrame: AFrame(3, 0)];
        [rightFootDown addFrame: AFrame(4, 0)];
        
        leftFootUp = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootUp.png"]  position: positionLeftFootUp anchorPoint: anchorLeftFootUp andSpeed: speed];
        [leftFootUp addFrame: AFrame(0, -60)];
        [leftFootUp addFrame: AFrame(1, -30)];
        [leftFootUp addFrame: AFrame(2, 0)];
        [leftFootUp addFrame: AFrame(3, -90)];
        [leftFootUp addFrame: AFrame(4, -60)];
        
        leftFootMiddle = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootMiddle.png"]  position: positionLeftFootMiddle anchorPoint: anchorLeftFootMiddle andSpeed: speed];
        [leftFootMiddle addFrame: AFrame(0, 120)];
        [leftFootMiddle addFrame: AFrame(1, 100)];
        [leftFootMiddle addFrame: AFrame(2, 0)];
        [leftFootMiddle addFrame: AFrame(3, 100)];
        [leftFootMiddle addFrame: AFrame(4, 120)];
        
        leftFootDown = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootDown.png"]  position: positionLeftFootDown anchorPoint: anchorLeftFootDown andSpeed: speed];
        [leftFootDown addFrame: AFrame(0, -20)];
        [leftFootDown addFrame: AFrame(1, 0)];
        [leftFootDown addFrame: AFrame(2, 0)];
        [leftFootDown addFrame: AFrame(3, 0)];
        [leftFootDown addFrame: AFrame(4, -20)];
        
        body.position = positionBody;
        head.position = positionHead;
        tail.position = positionTail;
        rightHandUp.position = positionRightHandUp;
        rightHandDown.position = positionRightHandDown;
        leftHandUp.position = positionLeftHandUp;
        leftHandDown.position = positionLeftHandDown;
        rightFootUp.position = positionRightFootUp;
        rightFootMiddle.position = positionRightFootMiddle;
        rightFootDown.position = positionRightFootDown;
        leftFootUp.position = positionLeftFootUp;
        leftFootMiddle.position = positionLeftFootMiddle;
        leftFootDown.position = positionLeftFootDown;
        
        body.scaleX = -1;
        
        [self addChild: body z: zBody];
        [body addChildToNode: head withZ: 1];
        [body addChildToNode: tail withZ: -1];
        [body addChildToNode: rightHandUp withZ: 3];
        [rightHandUp addChildToNode: rightHandDown withZ: 1];
        [body addChildToNode: leftHandUp withZ: -1];
        [leftHandUp addChildToNode: leftHandDown withZ: 1];
        [body addChildToNode: rightFootUp withZ: 1];
        [rightFootUp addChildToNode: rightFootMiddle withZ: 1];
        [rightFootMiddle addChildToNode: rightFootDown withZ: 1];
        [body addChildToNode: leftFootUp withZ: -1];
        [leftFootUp addChildToNode: leftFootMiddle withZ: 1];
        [leftFootMiddle addChildToNode: leftFootDown withZ: 1];
    }
    
    return self;
}

- (void) setSpeed: (float) speedParam
{
    [body setSpeedOfAnimation: speedParam];
    [head setSpeedOfAnimation: speedParam];
    [tail setSpeedOfAnimation: speedParam];
    [rightHandUp setSpeedOfAnimation: speedParam];
    [rightHandDown setSpeedOfAnimation: speedParam];
    [leftHandUp setSpeedOfAnimation: speedParam];
    [leftHandDown setSpeedOfAnimation: speedParam];
    [rightFootUp setSpeedOfAnimation: speedParam];
    [rightFootMiddle setSpeedOfAnimation: speedParam];
    [rightFootDown setSpeedOfAnimation: speedParam];
    [leftFootUp setSpeedOfAnimation: speedParam];
    [leftFootMiddle setSpeedOfAnimation: speedParam];
    [leftFootDown setSpeedOfAnimation: speedParam];
}


- (void) increaseSpeed
{
    [body increaseSpeedAnimation];
    [head increaseSpeedAnimation];
    [tail increaseSpeedAnimation];
    [rightHandUp increaseSpeedAnimation];
    [rightHandDown increaseSpeedAnimation];
    [leftHandUp increaseSpeedAnimation];
    [leftHandDown increaseSpeedAnimation];
    [rightFootUp increaseSpeedAnimation];
    [rightFootMiddle increaseSpeedAnimation];
    [rightFootDown increaseSpeedAnimation];
    [leftFootUp increaseSpeedAnimation];
    [leftFootMiddle increaseSpeedAnimation];
    [leftFootDown increaseSpeedAnimation];
}

- (void) jumpFromMountain
{
    body.scaleX = 1;
       
    [body runAction: [CCSpawn actions:
                      [CCJumpTo actionWithDuration: 2
                                          position: ccp(body.position.x + 15, 155)
                                            height: -50
                                             jumps: 1],
                      [CCScaleTo actionWithDuration: 0.25 scaleX: -1
                                             scaleY: 1],
                      nil]
     
     ];
    
}

- (void) jumpOnAGround
{
    [body runAction: [CCSpawn actions:
                      [CCJumpTo actionWithDuration: 1
                                          position: ccp(body.position.x - 15, 105)
                                            height: 50
                                             jumps: 1],
                      [CCScaleTo actionWithDuration: 0.25 scaleX: 1
                                             scaleY: 1],
                      nil]
     
     ];
    
    isMoveDownBackGround = YES;
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

+ (GoingDownCoco *) createWithSpeed: (float) speed
{
    GoingDownCoco *goingDownCoco = [[[GoingDownCoco alloc] initWithSpeed: speed] autorelease];
    
    return goingDownCoco;
}



@end
