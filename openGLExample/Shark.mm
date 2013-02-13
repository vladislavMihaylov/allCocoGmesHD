//
//  Shark.m
//  openGLExample
//
//  Created by Mac on 05.08.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Shark.h"
#import "Common.h"
#import "GameConfig.h"

@implementation Shark

@synthesize gameLayer;
@synthesize sprite;

- (void) dealloc
{
    [super dealloc];
}

- (id) init
{
    if ((self = [super init]))
    {
        if(CurrentDifficulty == 1)
        {
            height = arc4random() % 190 + 30; 
        }
        else if(CurrentDifficulty == 2)
        {
            height = 130;
        }
        
        sprite = [CCSprite spriteWithFile: @"5fish.png"];
        self.position = ccp(0, height);
        [self addChild: sprite];
        self.scale = 1.2;
    }
    
    return self;
}

- (void) swim
{
    [self runAction: 
     [CCCallFunc actionWithTarget: self 
                         selector: @selector(swimAnimation)]];
    
    CCAction *sharkMoveAction;
    
    if(CurrentDifficulty == 1)
    {
        sharkMoveAction = [CCMoveTo actionWithDuration: 5.0 
                                              position: ccp(600, self.position.y)];
    }
    else if(CurrentDifficulty == 2)
    {
        sharkMoveAction = [CCSequence actions:
                                    [CCJumpTo actionWithDuration: 2.5 
                                                        position: ccp(200, self.position.y) 
                                                          height: 100 
                                                           jumps: 1], 
                                    [CCJumpTo actionWithDuration: 2.5 
                                                        position: ccp(400, self.position.y) 
                                                          height: -100 
                                                           jumps: 1],
                                    [CCJumpTo actionWithDuration: 2.5 
                                                        position: ccp(600, self.position.y) 
                                                          height: 100 
                                                           jumps: 1],
                           nil];
    }
    
    [self runAction: 
                [CCSequence actions: 
                            sharkMoveAction, 
                            [CCCallFuncO actionWithTarget: gameLayer 
                                                 selector: @selector(removeShark:) 
                                                   object: self], 
                 nil]
     ];
}

- (void) eatingFish
{
    [self runAction: 
     [CCCallFunc actionWithTarget: self 
                         selector: @selector(eatingAnimation)]];
}

- (void) swimAnimation
{
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: [NSString stringWithFormat: @"shark.plist"]];
        
        [Common loadAnimationWithPlist: @"walkAnimation" andName: [NSString stringWithFormat: @"shark"]];
        
        [sprite runAction:
         [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache] animationByName: [NSString stringWithFormat: @"shark"]]
                                                      restoreOriginalFrame: YES]]];

}

- (void) eatingAnimation
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: [NSString stringWithFormat: @"eat.plist"]];
    
    [Common loadAnimationWithPlist: @"walkAnimation" andName: [NSString stringWithFormat: @"eat"]];
    
    [sprite runAction: [CCAnimate actionWithAnimation: [[CCAnimationCache sharedAnimationCache] animationByName: [NSString stringWithFormat: @"eat"]]
                                                  restoreOriginalFrame: YES]];
}

+ (Shark *) createShark
{
    Shark *shark = [[[Shark alloc] init] autorelease];
    return shark;
}

@end
