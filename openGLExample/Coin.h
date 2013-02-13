//
//  Coin.h
//  openGLExample
//
//  Created by Vlad on 02.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Coin: CCLayer
{
    CCSprite *sprite;
    BOOL isCanTap;
}

+ (Coin *) create;

- (BOOL) onTapped:(CGPoint)location;
- (void) coinJump;

@property (nonatomic, assign) BOOL isCanTap;

@end
