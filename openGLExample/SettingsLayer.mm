//
//  SettingsLayer.m
//  catchCoco
//
//  Created by Mac on 14.04.12.
//  Copyright 2012 spotGames. All rights reserved.
//

#import "SettingsLayer.h"
#import "GameConfig.h"
#import "MainMenuLayer.h"
#import "SelectGameLayer.h"
#import "SimpleAudioEngine.h"

#import "CocoGameLayer.h"
#import "GameLayer.h"
#import "MorphMainMenu.h"
#import "Tutorial.h"


@implementation SettingsLayer

+(CCScene *) sceneWithNumberOfGame: (NSInteger) number
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SettingsLayer *layer = [[[SettingsLayer alloc] initWithNumberOfGame: number] autorelease];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) initWithNumberOfGame: (NSInteger) number
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        NSString *bgName;
        NSInteger bgOpacity;
        
        if(number == 10)
        {
            bgName = @"FishBg.png";
            bgOpacity = 70;
            
        }
        if(number == 11)
        {
            bgName = @"settingsBg.jpg";
            bgOpacity = 0;
        }
        if(number == 12)
        {
            bgName = @"morphBgJPG.jpg";
            bgOpacity = 0;
        }
        
        CCSprite *background = [CCSprite spriteWithFile: [NSString stringWithFormat: @"%@", bgName]];
        background.position = ccp(GameCenterX, GameCenterY);
        [self addChild:background];
        
        CCLayerColor *shadowLayer = [CCLayerColor layerWithColor: ccc4(200, 200, 255, bgOpacity)];
        shadowLayer.position = ccp(0,0);
        [self addChild: shadowLayer];
        //////////////// difficulty
        
        CCSprite *selectDifficulty = [CCSprite spriteWithFile:@"selectDif.png"];
        selectDifficulty.position = ccp(GameCenterX, GameHeight * 0.30);
        
        selectDifficulty.scale = 0.9;
        
        [selectDifficulty setOpacity:200];
        
        [self addChild:selectDifficulty];
        
        CCMenuItemImage *easy = [CCMenuItemImage itemFromNormalImage:@"easy.png" selectedImage:@"easy.png"];
        
        easy.tag = kEasyDif;
        easy.scale = 0.7;
        
        easy.position = ccp(GameCenterX, GameHeight * 0.12);
        
        CCMenuItemImage *medium = [CCMenuItemImage itemFromNormalImage:@"medium.png" selectedImage:@"medium.png"];
        
        medium.tag = kMediumDif;
        medium.scale = 0.7;
        
        medium.position = ccp(GameCenterX, GameHeight * 0.12);
        
        
        CCMenuItemImage *hard = [CCMenuItemImage itemFromNormalImage:@"hard.png" selectedImage:@"hard.png"];
        
        hard.tag = kHardDif;
        hard.scale = 0.7;
        
        hard.position = ccp(GameCenterX, GameHeight * 0.12);
        
        
        CCMenu *difficultyMenu = [CCMenu menuWithItems: nil];
        difficultyMenu.position = ccp(0, 0);
        [self addChild:difficultyMenu];
        
        
        if (CurrentDifficulty == 0)
        {
            CCMenuItemToggle *difficulty = [CCMenuItemToggle itemWithTarget:self selector:@selector(selectDif:) items: easy, medium, hard, nil];
            difficulty.position = ccp(GameCenterX, GameHeight * 0.15);
            [difficultyMenu addChild:difficulty];
        }
        else if (CurrentDifficulty == 1)
        {
            CCMenuItemToggle *difficulty = [CCMenuItemToggle itemWithTarget:self selector:@selector(selectDif:) items: medium, hard, easy, nil];
            difficulty.position = ccp(GameCenterX, GameHeight * 0.15);
            [difficultyMenu addChild:difficulty];
        }
        else if (CurrentDifficulty == 2)
        {
            CCMenuItemToggle *difficulty = [CCMenuItemToggle itemWithTarget:self selector:@selector(selectDif:) items: hard, easy, medium, nil];
            difficulty.position = ccp(GameCenterX, GameHeight * 0.15);
            [difficultyMenu addChild:difficulty];
        }
        
        
        ////////////////
        
        CCMenuItemImage *BackToMainMenu = [CCMenuItemImage itemFromNormalImage: @"backBtn.png" 
                                                                 selectedImage: @"backBtnOn.png"
                                                                        target: self 
                                                                      selector: @selector(goToSelectGameMenu:)];
        NSString *gameName = @"";
        
        if(number == 10)
        {
            gameName = @"Fish";
        }
        if(number == 11)
        {
            gameName = @"Coco";
        }
        if (number == 12)
        {
            gameName = @"Coco";
        }
            CCMenuItemImage *play = [CCMenuItemImage itemFromNormalImage: [NSString stringWithFormat: @"playBtn%@.png", gameName]
                                                           selectedImage: [NSString stringWithFormat: @"playBtnOn%@.png", gameName]
                                                                  target:self 
                                                                selector:@selector(showMainMenu:)
                                 ];
        play.tag = number;
        
        
        
        
        CCMenuItemImage *eng = [CCMenuItemImage itemFromNormalImage: @"engLangNormal.png"
                                                      selectedImage: @"engLangOn.png"
                                                             target: self 
                                                           selector: @selector(selectLang:)
                                ];
        eng.tag = kLangEng;
        
        CCMenuItemImage *fr = [CCMenuItemImage itemFromNormalImage:@"frLangNormal.png" 
                                                     selectedImage:@"frLangOn.png"
                                                            target:self 
                                                          selector:@selector(selectLang:)
                               ];
        fr.tag = kLangFr;
        
        CCMenuItemImage *ger = [CCMenuItemImage itemFromNormalImage:@"gerLangNormal.png" 
                                                      selectedImage:@"gerLangOn.png"
                                                             target:self 
                                                           selector:@selector(selectLang:)
                                ];
        ger.tag = kLangGer;
        
        CCMenuItemImage *man = [CCMenuItemImage itemFromNormalImage:@"manLangNormal.png" 
                                                      selectedImage:@"manLangOn.png"
                                                             target:self 
                                                           selector:@selector(selectLang:)
                                ];
        man.tag = kLangMan;
        
        CCMenuItemImage * span = [CCMenuItemImage itemFromNormalImage:@"spanLangNormal.png" 
                                                        selectedImage:@"spanLangOn.png"
                                                               target:self 
                                                             selector:@selector(selectLang:)
                                  ];
        span.tag = kLangSpan;
        
        CCMenuItemImage *arabic = [CCMenuItemImage itemFromNormalImage: @"arabicLangNormal.png"
                                                         selectedImage: @"arabicLangOn.png"
                                                                target: self
                                                              selector: @selector(selectLang:)
                                  ];
        
        arabic.tag = kLangArab;
        
        
        BackToMainMenu.scale = 0.85;
        play.scale = 0.7;
        BackToMainMenu.position = ccp(GameWidth * 0.14, GameHeight * 0.15);
        play.position = ccp(GameWidth * 0.85, GameHeight * 0.19f);
        eng.position  = ccp(GameCenterX, GameHeight * 0.8);
        arabic.position = ccp(GameCenterX, GameHeight * 0.5);
        fr.position   = ccp(GameWidth * 0.20, GameHeight * 0.80);
        ger.position  = ccp(GameWidth * 0.80, GameHeight * 0.80);
        man.position  = ccp(GameWidth * 0.20, GameHeight * 0.50);
        span.position = ccp(GameWidth * 0.80, GameHeight * 0.50);

        CCMenu *menu = [CCMenu menuWithItems: BackToMainMenu, play, eng, fr, ger, man, span, arabic, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu z: kZSelection - 1];
        
        
        selection = [CCMenuItemImage itemFromNormalImage: @"selection.png" 
                                           selectedImage: @"selection.png"
                     ];
        
        selection.scaleY = 0.95;
        [menu addChild: selection z: kZSelection + 10];
        
        
        //apply current language to selection
        
        for(CCMenuItem *item in menu.children)
        {
            if(CurrentLanguage == item.tag)
            {
                selection.position = item.position;
                
                break;
            }
        }
        

    }
	return self;
}

- (void) goToSelectGameMenu: (id) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [SelectGameLayer scene]]];
}

-(void)showMainMenu: (CCMenuItem *) send
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
    
    /*if(send.tag == 10)
    {
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [GameLayer scene]]];
    }
    if(send.tag == 11)
    {
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [CocoGameLayer scene]]];
    }
    if(send.tag == 12)
    {
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [MorphMainMenu scene]]];
        //[self selectHero];
    }*/
    CurrentGame = send.tag;
    CCLOG(@"%i", CurrentGame);
    if(CurrentGame == 12)
    {
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [MorphMainMenu scene]]];
    }
    else
    {
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [Tutorial scene]]];
    }
    
}

- (void) selectHero
{
    CCLayerColor *selectLayer = [CCLayerColor layerWithColor: ccc4( 0, 0, 0, 240)];
    selectLayer.position = ccp(0, 0);
    [self addChild: selectLayer];
    
    CCMenuItemImage *cocoBtn = [CCMenuItemImage itemFromNormalImage: @"PlayWithCocoBtn.png" selectedImage: @"PlayWithCocoBtnTap.png"];
    cocoBtn.position = ccp(GameWidth * 0.3, GameHeight * 1.5);
    
    CCMenuItemImage *francoisBtn = [CCMenuItemImage itemFromNormalImage: @"PlayWithFrancoisBtn.png" selectedImage: @"PlayWithFrancoisBtnTap.png"];
    francoisBtn.position = ccp(GameWidth * 0.7, GameHeight * 1.5);
    
    CCMenu *heroMenu = [CCMenu menuWithItems: cocoBtn, francoisBtn, nil];
    heroMenu.position = ccp(0, GameHeight);
    [self addChild: heroMenu];
    
    [heroMenu runAction: [CCEaseBackInOut actionWithAction: [CCMoveTo actionWithDuration: 0.5 position: ccp(0, -320)]]];
}

- (void) selectLang: (CCMenuItem *) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"tap.mp3"];
    
    [selection stopAllActions];
    
    [selection runAction: 
     [CCEaseBackOut actionWithAction:
      [CCMoveTo actionWithDuration: 0.5f position: sender.position]
      ]
     ];
    
    CurrentLanguage = sender.tag;
}

- (void) selectDif: (CCMenuItem *) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
    
    CurrentDifficulty++;
    
    if(CurrentDifficulty > 2)
    {
        CurrentDifficulty = 0;
    }
    
}

- (void) dealloc
{
	[super dealloc];
}

@end
