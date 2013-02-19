//
//  RunningCoco.m
//  testApp
//
//  Created by Mac on 29.09.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RunningCoco.h"
#import "MorphGameConfig.h"


@implementation RunningCoco

@synthesize body;

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithSpeed: (float) speed
{
    if(self = [super init])
    {
        CGPoint positionBody = ccp(420, 350);
        CGPoint anchorBody = ccp(0.5, 0.4);
        NSInteger zBody = 2;
        
        CGPoint positionHead = ccp(35, 130);
        CGPoint anchorHead = ccp(0.5, 0.3);
        
        CGPoint positionTail = ccp(20, 26);
        CGPoint anchorTail = ccp(1, 0);
        
        CGPoint positionRightHandUp = ccp(50, 60); 
        CGPoint anchorRightHandUp = ccp(0.5, 1.0);
        
        CGPoint positionRightHandDown = ccp(20, 6);
        CGPoint anchorRightHandDown = ccp(0.5, 1.0);
        
        CGPoint positionLeftHandUp = ccp(50, 60);
        CGPoint anchorLeftHandUp = ccp(0.5, 1.0);
        
        CGPoint positionLeftHandDown = ccp(20, 6);
        CGPoint anchorLeftHandDown = ccp(0.5, 1.0);
        
        CGPoint positionRightFootUp = ccp(46, 20);
        CGPoint anchorRightFootUp = ccp(0.5, 1.0);
        
        CGPoint positionRightFootMiddle = ccp(20, 8);
        CGPoint anchorRightFootMiddle = ccp(0.5, 0.9);
        
        CGPoint positionRightFootDown = ccp(3, 6);
        CGPoint anchorRightFootDown = ccp(0, 0.5);
        
        CGPoint positionLeftFootUp = ccp(54, 30);
        CGPoint anchorLeftFootUp = ccp(0.5, 1.0);
        
        CGPoint positionLeftFootMiddle = ccp(20, 8);
        CGPoint anchorLeftFootMiddle = ccp(0.5, 0.9);
        
        CGPoint positionLeftFootDown = ccp(3, 6);
        CGPoint anchorLeftFootDown = ccp(0, 0.5);
        
        body = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoBody.png"] position: positionBody anchorPoint: anchorBody andSpeed: speed];
        [body addFrame: AFrame(0, 0)];
        [body addFrame: AFrame(1, 3)];
        [body addFrame: AFrame(2, 0)];
        [body addFrame: AFrame(3, -3)];
        [body addFrame: AFrame(4, 0)];
        
        head = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoHead.png"]  position: positionHead anchorPoint: anchorHead andSpeed: speed];
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
        [rightHandUp addFrame: AFrame(0, -120)];
        [rightHandUp addFrame: AFrame(1, 0)];
        [rightHandUp addFrame: AFrame(2, 90)];
        [rightHandUp addFrame: AFrame(3, 0)];
        [rightHandUp addFrame: AFrame(4, -120)];
        
        rightHandDown = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftHandDown.png"]  position: positionRightHandDown anchorPoint: anchorRightHandDown andSpeed: speed];
        [rightHandDown addFrame: AFrame(0, -100)];
        [rightHandDown addFrame: AFrame(1, -45)];
        [rightHandDown addFrame: AFrame(2, 0)];
        [rightHandDown addFrame: AFrame(3, -45)];
        [rightHandDown addFrame: AFrame(4, -100)];
        
        leftHandUp = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftHandUp.png"]  position: positionLeftHandUp anchorPoint: anchorLeftHandUp andSpeed: speed];
        [leftHandUp addFrame: AFrame(0, 90)];
        [leftHandUp addFrame: AFrame(1, 0)];
        [leftHandUp addFrame: AFrame(2, -120)];
        [leftHandUp addFrame: AFrame(3, 0)];
        [leftHandUp addFrame: AFrame(4, 90)];
        
        leftHandDown = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftHandDown.png"]  position: positionLeftHandDown anchorPoint: anchorLeftHandDown andSpeed: speed];
        [leftHandDown addFrame: AFrame(0, 0)];
        [leftHandDown addFrame: AFrame(1, -45)];
        [leftHandDown addFrame: AFrame(2, -100)];
        [leftHandDown addFrame: AFrame(3, -45)];
        [leftHandDown addFrame: AFrame(4, 0)];
        
        rightFootUp = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootUp.png"]  position: positionRightFootUp anchorPoint: anchorRightFootUp andSpeed: speed];
        [rightFootUp addFrame: AFrame(0, 60)];
        [rightFootUp addFrame: AFrame(1, 10)];
        [rightFootUp addFrame: AFrame(2, -50)];
        [rightFootUp addFrame: AFrame(3, 10)];
        [rightFootUp addFrame: AFrame(4, 60)];
        
        rightFootMiddle = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootMiddle.png"]  position: positionRightFootMiddle anchorPoint: anchorRightFootMiddle andSpeed: speed];
        [rightFootMiddle addFrame: AFrame(0, 30)];
        [rightFootMiddle addFrame: AFrame(1, 0)];
        [rightFootMiddle addFrame: AFrame(2, 50)];
        [rightFootMiddle addFrame: AFrame(3, 0)];
        [rightFootMiddle addFrame: AFrame(4, 30)];
        
        rightFootDown = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootDown.png"]  position: positionRightFootDown anchorPoint: anchorRightFootDown andSpeed: speed];
        [rightFootDown addFrame: AFrame(0, 20)];
        [rightFootDown addFrame: AFrame(1, 0)];
        [rightFootDown addFrame: AFrame(2, -20)];
        [rightFootDown addFrame: AFrame(3, 0)];
        [rightFootDown addFrame: AFrame(4, 20)];
        
        leftFootUp = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootUp.png"]  position: positionLeftFootUp anchorPoint: anchorLeftFootUp andSpeed: speed];
        [leftFootUp addFrame: AFrame(0, -50)];
        [leftFootUp addFrame: AFrame(1, 10)];
        [leftFootUp addFrame: AFrame(2, 60)];
        [leftFootUp addFrame: AFrame(3, 10)];
        [leftFootUp addFrame: AFrame(4, -50)];
        
        leftFootMiddle = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootMiddle.png"]  position: positionLeftFootMiddle anchorPoint: anchorLeftFootMiddle andSpeed: speed];
        [leftFootMiddle addFrame: AFrame(0, 50)];
        [leftFootMiddle addFrame: AFrame(1, 0)];
        [leftFootMiddle addFrame: AFrame(2, 25)];
        [leftFootMiddle addFrame: AFrame(3, 0)];
        [leftFootMiddle addFrame: AFrame(4, 50)];
        
        leftFootDown = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"CocoLeftFootDown.png"]  position: positionLeftFootDown anchorPoint: anchorLeftFootDown andSpeed: speed];
        [leftFootDown addFrame: AFrame(0, -20)];
        [leftFootDown addFrame: AFrame(1, 0)];
        [leftFootDown addFrame: AFrame(2, 20)];
        [leftFootDown addFrame: AFrame(3, 0)];
        [leftFootDown addFrame: AFrame(4, -20)];
        
        leftHandUp.scale = 0.9;
        leftHandDown.scale = 0.9;
        
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
        
        
        [self addChild: body z: zBody];
        [body addChildToNode: head withZ: 1];
        [body addChildToNode: tail withZ: -1];
        [body addChildToNode: rightHandUp withZ: 2];
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

- (float) getCurrentCocoSpeed
{
    currentSpeed = [body getCurrentSpeed];
    //CCLOG(@"currentSpeed = %f", currentSpeed);
    
    return currentSpeed;
}

- (void) hide
{
    [self runAction: [CCHide action]];//setVisible: NO];
}

- (void) show
{
    [self runAction: [CCShow action]];
}

- (void) showTransitionAnimation
{
    if(IsMorphGameActive == YES)
    {
        CCLOG(@"%i", afterSwim);
        if(!afterSwim)
        {
    [self reorderChild: body z: -2];
        }
        else
        {
            afterSwim = NO;
        }
    
    [body runAction: [CCSequence actions:
                                [CCSpawn actions:
                                            [CCJumpTo actionWithDuration: 1.5
                                                                position: ccp(body.position.x, 195)
                                                                  height: 180
                                                                   jumps: 1],
                                          [CCRotateTo actionWithDuration: 1
                                                                   angle: 90],
                                 nil],
                                [CCJumpTo actionWithDuration: 0.5
                                                    position: ccp(body.position.x, 240)
                                                      height: -90
                                                       jumps: 1],
                      nil]
     
     ];
        
        [head runAction: [CCRotateTo actionWithDuration: 1 angle: -90]];
        
        [head runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 1.97], [CCRotateTo actionWithDuration: 0 angle: 0], nil]];
    
    [self setSpeed: 14];
        
        
    }
}

- (void) jumpFromMountain
{
    [body runAction: [CCSpawn actions:
                      [CCJumpTo actionWithDuration: 2
                                          position: ccp(300, 195)
                                            height: 100
                                             jumps: 1],
                      [CCScaleTo actionWithDuration: 2
                                             scaleX: -1
                                             scaleY: 1],
                      nil]
     
     ];

}

- (void) setYposition
{
    [body setPosition: ccp(body.position.x, 180)];
}

- (void) setYposForMountain
{
    [body setPosition: ccp(320, 240)];
}

- (void) setLastYPosition
{
    [body setPosition: ccp(body.position.x, 100)];

}

- (void) doUnvisible
{
    [self setVisible: NO];
}

- (void) doVisible
{
    [self setVisible: YES];
}

- (void) setNormalOrientation
{
    [body setPosition: ccp(body.position.x, 155)];
    [body runAction: [CCRotateTo actionWithDuration: 0 angle: 0]];
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

+ (RunningCoco *) createWithSpeed: (float) speed
{
    RunningCoco *runningCoco = [[[RunningCoco alloc] initWithSpeed: speed] autorelease];
    
    return runningCoco;
}

@end
