//
//  Fish.h
//  openGLExample
//
//  Created by Mac on 29.07.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameLayer;

@interface Fish: CCNode 
{
    GameLayer *gameLayer;
    
    CCSprite *sprite;
    
    NSInteger type;
    NSInteger randFish;
    NSInteger height;
    float speed;
}

+ (Fish *) createFish;

- (void) swim;


@property (nonatomic, assign) GameLayer *gameLayer;

@property (nonatomic, assign) CCSprite *sprite;

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger randFish;

@end
