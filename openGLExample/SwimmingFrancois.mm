//
//  SwimmingCoco.m
//  testApp
//
//  Created by Mac on 30.09.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SwimmingFrancois.h"
#import "MorphGameConfig.h"

@implementation SwimmingFrancois

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
        
        CGPoint positionPanzer = ccp(25, 33);
        CGPoint anchorPanzer = ccp(0.5, 0.5);
        
        CGPoint positionLeftEye = ccp(40, 50);
        CGPoint anchorLeftEye = ccp(0.5, 0);
        
        CGPoint positionRightEye = ccp(58, 48);
        CGPoint anchorRightEye = ccp(0.5, 0);
        
        
        
        body = [AnimationNode createWithSprite: [CCSprite spriteWithFile: @"francoisBodySwim.png"] position: positionBody anchorPoint: anchorBody andSpeed: speed];
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
        
        
        [self addChild: body z: -2];
        [body addChildToNode: panzer withZ: -1];
        [body addChildToNode: leftEye withZ: -1];
        [body addChildToNode: rightEye withZ: -1];
    }
    
    return self;
}

- (void) showTransitionAnimation
{
    [body runAction:
     [CCJumpTo actionWithDuration: 2
                         position: ccp(body.position.x, 110)
                           height: 100
                            jumps: 1]
     
     ];
    
    afterSwim = YES;
    
    //[body runAction: [CCRotateTo actionWithDuration: 2 angle: -90]];
    //[head runAction: [CCRotateTo actionWithDuration: 2 angle: 90]];
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
    [rightEye increaseSpeedAnimation];
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
    //[head pauseSchedulerAndActions];
}

- (void) unPauseAllActions
{
    [body resumeSchedulerAndActions];
    //[head resumeSchedulerAndActions];
}



+ (SwimmingFrancois *) createWithSpeed: (float) speed
{
    SwimmingFrancois *swimmingFrancois = [[[SwimmingFrancois alloc] initWithSpeed: speed] autorelease];
    
    return swimmingFrancois;
}

@end
