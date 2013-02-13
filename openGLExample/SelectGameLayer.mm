//
//  SelectGameLayer.m
//  openGLExample
//
//  Created by Mac on 05.08.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectGameLayer.h"
#import "CocoGameLayer.h"
#import "MainMenuLayer.h"
#import "GameConfig.h"
#import "GameLayer.h"
#import "SettingsLayer.h"
#import "SimpleAudioEngine.h"
#import "MorphMainMenu.h"

@implementation SelectGameLayer

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    SelectGameLayer *selectLayer = [SelectGameLayer node];
    
    [scene addChild: selectLayer];
    
    return scene;
}

- (void) dealloc
{
    [super dealloc];
}

- (id) init
{
    if((self = [super init]))
    {
        CCSprite *bgSprite = [CCSprite spriteWithFile: @"settingsBg.jpg"];
        bgSprite.position = ccp(GameCenterX, GameCenterY);
        [self addChild: bgSprite];
        
        labelSprite = [CCSprite spriteWithFile: @"selectGameLogo.png"];
        labelSprite.position = ccp(GameCenterX, GameHeight - 30);
        [self addChild: labelSprite];
        
        CCMenuItemImage *fishingGame = [CCMenuItemImage itemFromNormalImage: @"cocoFishingPlayBtn.png" 
                                                              selectedImage: @"cocoFishingPlayBtnTap.png"
                                                                     target: self 
                                                                   selector: @selector(playGame:)];
        fishingGame.tag = 10;
        
        CCMenuItemImage *catchCocoGame = [CCMenuItemImage itemFromNormalImage: @"catchCocoPlayBtn.png" 
                                                                selectedImage: @"catchCocoPlayBtnTap.png"
                                                                       target: self 
                                                                     selector: @selector(playGame:)];
        catchCocoGame.tag = 11;
        
        CCMenuItemImage *morphingGame = [CCMenuItemImage itemFromNormalImage: @"CocoFrancoisPlayBtn.png"
                                                               selectedImage: @"CocoFrancoisPlayBtnTap.png"
                                                                        target: self
                                                                      selector: @selector(playGame:)];
        
        morphingGame.tag = 12;
        
        CCMenuItemImage *BackToMainMenu = [CCMenuItemImage itemFromNormalImage: @"backBtn.png" 
                                                                 selectedImage: @"backBtnOn.png"
                                                                        target: self 
                                                                      selector: @selector(goToMainMenu:)];
        fishingGame.scale = 0.9;
        catchCocoGame.scale = 0.9;
        morphingGame.scale = 0.9;
        
        fishingGame.position = ccp(GameCenterX, GameCenterY + 90);
        catchCocoGame.position = ccp(GameCenterX, GameCenterY - 20);
        morphingGame.position = ccp(GameCenterX, GameCenterY - 130);
        BackToMainMenu.position = ccp(GameWidth * 0.04, GameHeight * 0.05);
        
        selectGameMenu = [CCMenu menuWithItems: fishingGame, catchCocoGame, morphingGame, BackToMainMenu, nil];
        selectGameMenu.position = ccp(0,0);
        selectGameMenu.scale = 0.8;
        [self addChild: selectGameMenu];
    }
    
    return self;
}

- (void) playGame: (CCMenuItem *) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [SettingsLayer sceneWithNumberOfGame: sender.tag]]];
}

- (void) goToMainMenu: (id) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [MainMenuLayer scene]]];
}

@end
