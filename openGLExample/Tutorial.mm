//
//  Tutorial.m
//  openGLExample
//
//  Created by Vlad on 12.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Tutorial.h"
#import "GameConfig.h"

#import "GameLayer.h"
#import "CocoGameLayer.h"
#import "MorphGameLayer.h"

@implementation Tutorial

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Tutorial *layer = [Tutorial node];
    
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) dealloc
{
    [super dealloc];
}

- (id) init
{
    if(self = [super init])
    {
        CCSprite *bg;
        
        if(CurrentGame == 11)
        {
            bg = [CCSprite spriteWithFile: @"cocoTutorial.jpg"];
        }
        else
        {
            bg = [CCSprite spriteWithFile: [NSString stringWithFormat: @"%i%i.jpg", CurrentGame, CurrentDifficulty]];
        }
        
        bg.position = ccp(GameCenterX, GameCenterY);
        
        [self addChild: bg];
        
        
        CCMenuItemImage *okBtn = [CCMenuItemImage itemFromNormalImage: @"okBtn.png"
                                                        selectedImage: @"okBtnTap.png"
                                                               target: self
                                                             selector: @selector(playGame)];
        
        okBtn.position = ccp(400, 50);
        
        CCMenu *okMenu = [CCMenu menuWithItems: okBtn, nil];
        okMenu.position = ccp(0,0);
        [self addChild: okMenu];
    }
    
    return self;
}

- (void) playGame
{
    if(CurrentGame == 10)
     {
     [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 0.5 scene: [GameLayer scene]]];
     }
     if(CurrentGame == 11)
     {
     [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 0.5 scene: [CocoGameLayer scene]]];
     }
     if(CurrentGame == 12)
     {
     [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 0.5 scene: [MorphGameLayer scene]]];
     }

}



@end
