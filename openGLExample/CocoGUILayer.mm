//
//  GUILayer.m
//  catchCoco
//
//  Created by Mac on 15.04.12.
//  Copyright 2012 spotGames. All rights reserved.
//

#import "CocoGUILayer.h"
#import "CocoGameLayer.h"
#import "GameConfig.h"
#import "MainMenuLayer.h"


@implementation CocoGUILayer

@synthesize cocoGameLayer;

-(id) init
{
	if( (self=[super init])) 
    {
        
        CCMenuItemImage *menu = [CCMenuItemImage itemFromNormalImage:@"pauseBtn.png" selectedImage:@"pauseBtn.png"
                                                              target:self 
                                                            selector:@selector(showMainMenu:)
                                 ];
        menu.scale = 0.8;
        menu.position = ccp(GameWidth * 0.065f, GameHeight * 0.92f);
        
        CCMenu *backMenu = [CCMenu menuWithItems:menu, nil];
        backMenu.position = ccp(0, 0);
        [self addChild:backMenu z:kZbackButton];
        
        cocoLabel = [CCLabelBMFont labelWithString:@"0" 
                                           fntFile:@"animals40.fnt"
                     ];
        
        cocoLabel.anchorPoint = ccp(0.5, 0.5);
        cocoLabel.position = ccp(GameWidth * 0.96, GameHeight * 0.92);
        [self addChild:cocoLabel];
        
    }
	return self;
}

-(void)formatCocoString:(NSInteger)cocoNumber
{
    cocoLabel.string = [NSString stringWithFormat:@"%i", cocoNumber];
    if (cocoNumber != 10)
    {
    /*[cocoLabel runAction:[CCSequence actions: 
                          [CCMoveTo actionWithDuration:0.4f 
                                              position:ccp(gameWidth * 0.5, gameHeight * 0.1)], 
                          [CCMoveTo actionWithDuration:0.4f 
                                              position:ccp(gameWidth * 0.5, gameHeight * 0.06)],
                          nil]
     ];*/
        
    [cocoLabel runAction:[CCSequence actions: 
                          [CCScaleTo actionWithDuration:0.4f 
                                                  scale:1.2], 
                          [CCScaleTo actionWithDuration:0.4f 
                                                  scale:1.0f], 
                          nil]
     ];
        
    }
}

-(void)showMainMenu:(id)sender
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f 
                                                                                  scene: [MainMenuLayer scene] 
                                                ]
     ];
}

-(void)ShowGameOverLabel
{
    shadow = [CCLayerColor layerWithColor:ccc4(70, 100, 50, 190)];
    shadow.position = ccp(0, 0);
    [self addChild:shadow z:kZShadow tag:kShadowTag];
    
    cocoLabel.position = ccp(-100, -100);
    
    CCLabelBMFont *gameOver = [CCLabelBMFont labelWithString:@"You Caught Coco!" 
                                                     fntFile:@"animals40.fnt"
                               ];
    
    gameOver.position = ccp(GameCenterX, GameHeight + 50);
    [self addChild:gameOver z:kZShadow + 1];
    
    CCSprite *allMiniRoosters = [CCSprite spriteWithFile:@"allMiniRoosters.png"];
    allMiniRoosters.position = ccp(GameWidth * 0.632, 295);
    [self addChild:allMiniRoosters z:kZShadow + 1];
    
    [gameOver runAction: [CCEaseBackOut actionWithAction:
                              [CCMoveTo actionWithDuration: 0.8f 
                                                  position: ccp(GameCenterX, GameCenterY + 40)
                               ]
                         ]
     ];
    id scale = [CCSequence actions:
                [CCScaleTo actionWithDuration:0.5f 
                                        scale:1.2],
                [CCScaleTo actionWithDuration:0.5f 
                                        scale:1.0], 
                nil
                ];
    [allMiniRoosters runAction:[CCMoveTo actionWithDuration:0.5f position:ccp(GameWidth * 0.5f, GameHeight * 0.4)]];
    
    [gameOver runAction:[CCRepeatForever actionWithAction:scale]];
    [allMiniRoosters runAction:[CCRepeatForever actionWithAction:scale]];
}

- (void) dealloc
{
	[super dealloc];
}

@end
