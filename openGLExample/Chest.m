//
//  Chest.m
//  openGLExample
//
//  Created by Vlad on 02.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Chest.h"


@implementation Chest

- (void) dealloc
{
    [super dealloc];
}

- (id) init
{
    if(self = [super init])
    {
        sprite = [CCSprite spriteWithFile: @"chest.png"];
        [self addChild: sprite];
        
        self.contentSize = sprite.contentSize;
    }
    
    return self;
}

+ (Chest *) create
{
    Chest *chest = [[[Chest alloc] init] autorelease];
    
    return chest;
}

- (BOOL) onTaped:(CGPoint)location
{
    BOOL isTap = NO;
    
    if( fabs(location.x - self.position.x) < (self.contentSize.width / 2) && fabs(location.y - self.position.y) < (self.contentSize.height / 2))
    {
        isTap = YES;
    }
    
    return isTap;
}

@end
