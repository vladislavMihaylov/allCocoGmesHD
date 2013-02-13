//
//  Chest.h
//  openGLExample
//
//  Created by Vlad on 02.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Chest: CCLayer
{
    CCSprite *sprite;
}

+ (Chest *) create;

- (BOOL) onTaped: (CGPoint) location;

@end
