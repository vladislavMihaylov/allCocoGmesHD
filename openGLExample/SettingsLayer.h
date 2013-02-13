//
//  SettingsLayer.h
//  catchCoco
//
//  Created by Mac on 14.04.12.
//  Copyright 2012 spotGames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SettingsLayer : CCLayer {
    
    CCSprite *selection;
    CCSprite *difSelection;
    
}

-(id) initWithNumberOfGame: (NSInteger) number;
+(CCScene *) sceneWithNumberOfGame: (NSInteger) number;

@end
