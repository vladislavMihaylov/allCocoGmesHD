//
//  SelectGameLayer.h
//  openGLExample
//
//  Created by Mac on 05.08.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SelectGameLayer :CCLayer 
{
    CCSprite *labelSprite;
    
    CCMenu *selectGameMenu;
}

+ (CCScene *) scene;

@end
