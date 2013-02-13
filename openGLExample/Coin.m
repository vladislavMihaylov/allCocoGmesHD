//
//  Coin.m
//  openGLExample
//
//  Created by Vlad on 02.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Coin.h"


@implementation Coin

@synthesize isCanTap;

- (void) dealloc
{
    [super dealloc];
}

- (id) init
{
    if(self = [super init])
    {
        sprite = [CCSprite spriteWithFile: @"coin.png"];
        [self addChild: sprite];
        
        self.contentSize = sprite.contentSize;
        isCanTap = NO;
    }
    
    return self;
}

+ (Coin *) create
{
    Coin *coin = [[[Coin alloc] init] autorelease];
    
    return coin;
}

- (BOOL) onTapped: (CGPoint) location
{
    CCLOG(@"coin");
    
    BOOL isTap = NO;
    
    if( fabs(location.x - self.position.x) < (self.contentSize.width / 2) && fabs(location.y - self.position.y) < (self.contentSize.height / 2) && self.isCanTap == YES)
    {
        isTap = YES;
    }
    
    return isTap;
}

- (void) coinJump
{
    NSInteger x = arc4random() % 400 + 40;
    
    NSInteger height = arc4random() % 50 + 90;
    
    [self runAction: [CCSequence actions: [CCJumpTo actionWithDuration: 1
                                                             position: ccp(x, 30)
                                                               height: height
                                                                jumps: 1],
                                         [CCCallFunc actionWithTarget: self selector: @selector(switchState)], nil]
     ];
}

- (void) switchState
{
    self.isCanTap = YES;
}

@end
