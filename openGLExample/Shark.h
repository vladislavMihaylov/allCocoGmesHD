//
//  Shark.h
//  openGLExample
//
//  Created by Mac on 05.08.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameLayer;

@interface Shark: CCNode 
{
    GameLayer *gameLayer;
    
    CCSprite *sprite;
    
    NSInteger type;
    NSInteger randFish;
    NSInteger height;
    float speed;
}

+ (Shark *) createShark;

- (void) swim;
- (void) eatingFish;


@property (nonatomic, assign) GameLayer *gameLayer;

@property (nonatomic, assign) CCSprite *sprite;


@end
