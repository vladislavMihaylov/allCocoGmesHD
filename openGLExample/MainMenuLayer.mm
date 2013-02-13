//
//  MainMenuLayer.m
//  catchCoco
//
//  Created by Mac on 14.04.12.
//  Copyright 2012 spotGames. All rights reserved.
//

#import "MainMenuLayer.h"
#import "SettingsLayer.h"
#import "SelectGameLayer.h"
#import "GameConfig.h"
#import "SimpleAudioEngine.h"


@implementation MainMenuLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) 
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        //[[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.5f];
        //[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic: @"FishMusic.mp3"];
        
        CCSprite *menuBackground = [CCSprite spriteWithFile:@"menuBg.png"];
        menuBackground.position = ccp(GameCenterX, GameCenterY);
        [self addChild:menuBackground];
        
        CCMenuItemImage *settingsItemMenu = [CCMenuItemImage itemFromNormalImage:@"languagesBtn.png" 
                                                                   selectedImage:@"languagesBtnOn.png"
                                                                          target:self 
                                                                        selector:@selector(showSettings:)
                                            ];
        
        CCMenuItemImage *playItemMenu     = [CCMenuItemImage itemFromNormalImage:@"playMenuBtn.png" 
                                                                   selectedImage:@"playMenuBtnOn.png"
                                                                          target:self 
                                                                        selector:@selector(play:)
                                            ];
        
        playItemMenu.scale = 0.65;
        playItemMenu.position = ccp(GameWidth * 1.7, GameCenterY - 50);
        settingsItemMenu.position = ccp(GameWidth * 1.7, GameCenterY - 80);
        
        CCMenu *mainMenu = [CCMenu menuWithItems: playItemMenu, nil];
        mainMenu.position = ccp(0, 0);
        [self addChild:mainMenu];
        
        
        [playItemMenu runAction: [CCEaseBackOut actionWithAction:
                                        [CCMoveTo actionWithDuration: 0.8f 
                                                            position: ccp(GameWidth * 0.7, GameCenterY - 30)
                                        ]
                                 ]
        ];
        
        [settingsItemMenu runAction: [CCSequence actions:
                                        [CCDelayTime actionWithDuration:0.3], 
                                        [CCEaseBackOut actionWithAction:
                                                [CCMoveTo actionWithDuration: 0.8f 
                                                                    position: ccp(GameWidth * 0.7, GameCenterY - 30)
                                                 ]
                                        ],nil
                                      ]
         ];
        
    }
	return self;
}

-(void)play:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f 
                                                                                  scene: [SelectGameLayer scene]
                                               ]
    ];
}

-(void)showSettings:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f 
                                                                                  scene: [SettingsLayer scene]
                                              ]
   ];
}

- (void) dealloc
{
	[super dealloc];
}

@end
