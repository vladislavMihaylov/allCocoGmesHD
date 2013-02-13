//
//  RunningCoco.m
//  testApp
//
//  Created by Mac on 29.09.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RunningFrancois.h"
#import "MorphGameConfig.h"


@implementation RunningFrancois

@synthesize body;

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithSpeed: (float) speed
{
    if(self = [super init])
    {
        CGPoint positionBody = ccp(210, 110);
        //CGPoint positionBody = ccp(0, 0);
        CGPoint anchorBody = ccp(0.5, 0.5);
        NSInteger zBody = 2;
        
        CGPoint positionPanzer = ccp(25, 33);
        CGPoint anchorPanzer = ccp(0.5, 0.5);
        
        CGPoint positionLeftEye = ccp(40, 50);
        CGPoint anchorLeftEye = ccp(0.5, 0);
        
        CGPoint positionRightEye = ccp(58, 48);
        CGPoint anchorRightEye = ccp(0.5, 0);
        
        
        
        body = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"francoisBody.png"] position: positionBody anchorPoint: anchorBody andSpeed: speed];
        [body addFrame: AFrame(0, 0)];
        [body addFrame: AFrame(1, 3)];
        [body addFrame: AFrame(2, 0)];
        [body addFrame: AFrame(3, -3)];
        [body addFrame: AFrame(4, 0)];
        
        panzer = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"francoisPanzer.png"]  position: positionPanzer anchorPoint: anchorPanzer andSpeed: speed];
        [panzer addFrame: AFrame(0, 0)];
        [panzer addFrame: AFrame(1, 5)];
        [panzer addFrame: AFrame(2, 0)];
        [panzer addFrame: AFrame(3, -5)];
        [panzer addFrame: AFrame(4, 0)];
        
        leftEye = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"francoisEye.png"]  position: positionLeftEye anchorPoint: anchorLeftEye andSpeed: speed];
        [leftEye addFrame: AFrame(0, -5)];
        [leftEye addFrame: AFrame(1, -10)];
        [leftEye addFrame: AFrame(2, -5)];
        [leftEye addFrame: AFrame(3, 10)];
        [leftEye addFrame: AFrame(4, -5)];
        
        
        rightEye = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"francoisEye.png"]  position: positionRightEye anchorPoint: anchorRightEye andSpeed: speed];
        [rightEye addFrame: AFrame(0, 5)];
        [rightEye addFrame: AFrame(1, -10)];
        [rightEye addFrame: AFrame(2, 5)];
        [rightEye addFrame: AFrame(3, 10)];
        [rightEye addFrame: AFrame(4, 5)];
       
                
        body.position = positionBody;
        panzer.position = positionPanzer;
        leftEye.position = positionLeftEye;
        rightEye.position = positionRightEye;
        
        
        [self addChild: body z: zBody];
        [body addChildToNode: panzer withZ: -1];
        [body addChildToNode: leftEye withZ: -1];
        [body addChildToNode: rightEye withZ: -1];
        
    }
    
    return self;
}

- (void) setFinishZZ
{
    [self reorderChild: body z: 2000];
}

- (void) setSpeed: (float) speedParam
{
    [body setSpeedOfAnimation: speedParam];
    [panzer setSpeedOfAnimation: speedParam];
    [leftEye setSpeedOfAnimation: speedParam];
    [rightEye setSpeedOfAnimation: speedParam];
}

- (void) increaseSpeed
{
    [body increaseSpeedAnimation];
    [panzer increaseSpeedAnimation];
    [leftEye increaseSpeedAnimation];
    [rightEye increaseSpeedAnimation];}

- (float) getCurrentCocoSpeed
{
    currentSpeed = [body getCurrentSpeed];
    
    return currentSpeed;
}

- (void) hide
{
    [self runAction: [CCHide action]];
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
            afterSwim = YES;
        }
        else
        {
            afterSwim = NO;
        }
        
        
        [self runAction: [CCSequence actions:
                          [CCSpawn actions:
                           [CCJumpTo actionWithDuration: 1.5
                                               position: ccp(self.position.x, self.position.y)
                                                 height: 100
                                                  jumps: 1],
                           [CCRotateTo actionWithDuration: 1
                                                    angle: 0],
                           nil],
                          [CCJumpTo actionWithDuration: 0.5
                                              position: ccp(self.position.x, self.position.y)
                                                height: -50
                                                 jumps: 1],
                          nil]
        
         ];
        
        
        [self setSpeed: 5];
    }
}

- (void) reorderTo: (NSInteger) order
{
    [self reorderChild: body z: order];
}

- (void) jumpFromMountain
{
    [body runAction: [CCSpawn actions:
                      [CCJumpTo actionWithDuration: 2
                                          position: ccp(250, 155)
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

- (void) setLastYPosition
{
    [body setPosition: ccp(body.position.x, 50)];
    
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
    [body setPosition: ccp(body.position.x, 110)];
    [body runAction: [CCRotateTo actionWithDuration: 0 angle: 0]];
}

- (void) pauseAllActions
{
    [body pauseSchedulerAndActions];
}

- (void) unPauseAllActions
{
    [body resumeSchedulerAndActions];
}

+ (RunningFrancois *) createWithSpeed: (float) speed
{
    RunningFrancois *runningFrancois = [[[RunningFrancois alloc] initWithSpeed: speed] autorelease];
    
    return runningFrancois;
}

@end
