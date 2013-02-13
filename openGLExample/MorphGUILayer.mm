//
//  GUILayer.m
//  morphing
//
//  Created by Vlad on 13.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MorphGUILayer.h"
#import "MorphGameConfig.h"
#import "MorphGameLayer.h"
#import "MorphMainMenu.h"
#import "GameConfig.h"
#import "MainMenuLayer.h"

#import "SimpleAudioEngine.h"

@implementation MorphGUILayer

@synthesize gameLayer;

- (void) dealloc
{
    
    [super dealloc];
    [mistakesSpritesArray release];
    [crossesArray release];
}

- (id) init
{
    if(self = [super init])
    {
        mistakes = 0;
        
        mistakesSpritesArray = [[NSMutableArray alloc] init];
        crossesArray = [[NSMutableArray alloc] init];
        
        [self addMistakesSprites];
        
                
        CCMenuItemImage *pauseBtn = [CCMenuItemImage itemFromNormalImage: @"pauseBtn.png"
                                                           selectedImage: @"pauseBtn.png"
                                                                  target: self
                                                                selector: @selector(showPauseMenu)
                                     ];
        
        pauseBtn.position = ccp(440, 280);
        pauseBtn.scale = 0.65;
        
        
        CCMenu *guiMenu = [CCMenu menuWithItems: pauseBtn, nil];
        guiMenu.position = ccp(0,0);
        
        [self addChild: guiMenu];
        
        /////////////////////////////
        
        remainingDistance = [CCLabelTTF labelWithString: @"" fontName: @"Arial" fontSize: 16];
        remainingDistance.position = ccp(240, 240);
        [self addChild: remainingDistance];
        
        runBtn = [CCMenuItemImage itemFromNormalImage: @"runBtn.png" selectedImage: @"runBtnOn.png"
                                                         target: self
                                                       selector: @selector(transmitNumberOfAction:)
                                  ];
        
        runBtn.position = ccp(50, 50);
        runBtn.tag = 0;
        
        swimBtn = [CCMenuItemImage itemFromNormalImage: @"swimBtn.png" selectedImage: @"swimBtnOn.png"
                                                          target: self
                                                        selector: @selector(transmitNumberOfAction:)
                                   ];
        
        swimBtn.position = ccp(145, 50);
        swimBtn.tag = 1;
        
        jumpBtn = [CCMenuItemImage itemFromNormalImage: @"jumpBtn.png" selectedImage: @"jumpBtnOn.png"
                                                          target: self
                                                        selector: @selector(transmitNumberOfAction:)
                                   ];
        
        jumpBtn.position = ccp(240, 50);
        jumpBtn.tag = 2;
        
        scramblBtn = [CCMenuItemImage itemFromNormalImage: @"upBtn.png" selectedImage: @"upBtnOn.png"
                                                             target: self
                                                           selector: @selector(transmitNumberOfAction:)
                                      ];
        
        scramblBtn.position = ccp(335, 50);
        scramblBtn.tag = 3;
        
        goDownBtn = [CCMenuItemImage itemFromNormalImage: @"downBtn.png" selectedImage: @"downBtnOn.png"
                                                            target: self
                                                          selector: @selector(transmitNumberOfAction:)
                                     ];
        
        goDownBtn.position = ccp(430, 50);
        goDownBtn.tag = 4;
        
        universalBtn = [CCMenuItemImage itemFromNormalImage: @"universalBtn.png" selectedImage: @"universalBtnOn.png"
                                                               target: self
                                                             selector: @selector(transmitNumberOfAction:)
                                        ];
        
        universalBtn.position = ccp(380, 50);
        universalBtn.tag = 999;
        universalBtn.scale = 0.7;
        
        if(CurrentDifficulty == 0)
        {
        
            buttonsMenu = [CCMenu menuWithItems: universalBtn, nil];
            buttonsMenu.position = ccp(0,0);
            [self addChild: buttonsMenu];
        }
        if(CurrentDifficulty == 1 || CurrentDifficulty == 2)
        {
            
            buttonsMenu = [CCMenu menuWithItems: runBtn, swimBtn, jumpBtn, scramblBtn, goDownBtn, nil];
            buttonsMenu.position = ccp(0,0);
            [self addChild: buttonsMenu];
        }
        
        currentActionLabel = [CCLabelBMFont labelWithString: @"" fntFile: @"font20.fnt"];
        currentActionLabel.position = ccp(240, 280);
        [currentActionLabel setOpacity: 0];
        [self addChild: currentActionLabel z: 20];
        
    }
    
    return self;
}

- (void) showCurrentActionLabel:(NSInteger)numb
{
    if(IsMorphGameActive == YES)
    {

        [[SimpleAudioEngine sharedEngine] playEffect: [NSString stringWithFormat: @"%icoco%i.mp3", CurrentLanguage, (numb - 1000)]];
       
    }
}

- (void) addMistakesSprites
{
    if(CurrentDifficulty == 2)
    {
        for(int i = 0; i < 3; i++)
        {
            CCSprite *mistakeSprite;
            if(typeCharacter == 0)
            {
                mistakeSprite = [CCSprite spriteWithFile: @"CocoHead.png"];
            }
            else
            {
                mistakeSprite = [CCSprite spriteWithFile: @"francoisHead.png"];
            }
            
            mistakeSprite.position = ccp(35 * i + 30 , 280);
            mistakeSprite.scale = 0.8;
            [self addChild: mistakeSprite];
            
            [mistakesSpritesArray addObject: mistakeSprite];
        }
    }
    
    CCLOG(@"CountMassive %i", mistakesSpritesArray.count);

}

- (void) increaseMistake
{
    mistakes++;
    
    NSMutableArray *spritesToREmove = [[NSMutableArray alloc] init];
    
    [spritesToREmove addObject: [mistakesSpritesArray lastObject]];
    
    for(CCSprite *spr in spritesToREmove)
    {
        [self removeChild: spr cleanup: YES];
    }
    
    [mistakesSpritesArray removeLastObject];
    [spritesToREmove release];
    
    if(mistakes == 3)
    {
        mistakes = 0;
        [self showGameOverMenu];
    }
    
    
}

- (void) removeAllMistakeSprites
{
    for(CCSprite *curMistSprite in mistakesSpritesArray)
    {
        [self removeChild: curMistSprite cleanup: YES];
    }
    
    [mistakesSpritesArray removeAllObjects];
}

- (void) blockAllButtons
{
    if(CurrentDifficulty == 1 || CurrentDifficulty == 2)
    {
    runBtn.isEnabled = NO;
    swimBtn.isEnabled = NO;
    jumpBtn.isEnabled = NO;
    scramblBtn.isEnabled = NO;
    goDownBtn.isEnabled = NO;
    }
    else if(CurrentDifficulty == 0)
    {
    universalBtn.isEnabled = NO;
    }
}

- (void) unlockAllButtons
{
    if(CurrentDifficulty == 1 || CurrentDifficulty == 2)
    {
    runBtn.isEnabled = YES;
    swimBtn.isEnabled = YES;
    jumpBtn.isEnabled = YES;
    scramblBtn.isEnabled = YES;
    goDownBtn.isEnabled = YES;
    }
    else if(CurrentDifficulty == 0)
    {
    universalBtn.isEnabled = YES;
    }

}

- (void) showPauseMenu
{
    if(IsMorphGameActive)
    {
        [currentActionLabel pauseSchedulerAndActions];
        
        [self blockAllButtons];
        IsMorphGameActive = NO;
        
        [gameLayer pauseTransitions];
        
        pauseLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 200)];
        pauseLayer.position = ccp(0,0);
        [self addChild: pauseLayer z: 6];
        
        menuBg = [CCSprite spriteWithFile: @"pauseMenuBg.png"];
        menuBg.position = ccp(240, 480);
        [self addChild: menuBg z: 7];
        
        
        CCMenuItemImage *playMenuBtn = [CCMenuItemImage itemFromNormalImage: @"playBtn.png"
                                                              selectedImage: @"playBtn.png"
                                                                      block: ^(id sender) {
                                                                          IsMorphGameActive = YES;
                                                                          [gameLayer unPauseTransitions];
                                                                          [currentActionLabel resumeSchedulerAndActions];
                                                                          [self unlockAllButtons];
                                                                          [self removeChild: menuBg cleanup: YES];
                                                                          [self removeChild: pauseLayer cleanup: YES];
                                                                      }
                                        ];
        
        CCMenuItemImage *exitMenuBtn = [CCMenuItemImage itemFromNormalImage: @"exitBtn.png"
                                                              selectedImage: @"exitBtn.png"
                                                                      block: ^(id sender) {
                                                                          
                                                                          mistakes = 0;
                                                                          
                                                                          isMistake = NO;
                                                                          
                                                                          [self addMistakesSprites];
                                                                          
                                                                          for(CCSprite *spr in crossesArray)
                                                                          {
                                                                              [self removeChild: spr  cleanup: YES];
                                                                          }
                                                                          
                                                                          [crossesArray removeAllObjects];
                                                                          
                                                                          [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: [MainMenuLayer scene]]];
                                                                      }
                                        ];
        
        CCMenuItemImage *restartGameBtn = [CCMenuItemImage itemFromNormalImage: @"replayBtn.png"
                                                                 selectedImage: @"replayBtn.png"
                                                                        target: self
                                                                      selector: @selector(restartGame)
                                           ];
        
        exitMenuBtn.position = ccp(75, 100);
        playMenuBtn.position = ccp(275, 100);
        restartGameBtn.position = ccp(175, 100);
        
        CCMenu *menu = [CCMenu menuWithItems: exitMenuBtn, playMenuBtn, restartGameBtn, nil];
        menu.position = ccp(0,0);
        
        [menuBg addChild: menu];
        
        
        [menuBg runAction: [CCEaseBackInOut actionWithAction: [CCMoveTo actionWithDuration: 0.5 position: ccp(240, 160)] ]];
    }
}

- (void) showGameOverMenu
{
    if(IsMorphGameActive)
    {
        [self blockAllButtons];
        IsMorphGameActive = NO;
        [gameLayer pauseTransitions];
        
        pauseLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 200)];
        pauseLayer.position = ccp(0,0);
        [self addChild: pauseLayer z: 6];
        
        menuBg = [CCSprite spriteWithFile: @"pauseMenuBg.png"];
        menuBg.position = ccp(240, 480);
        [self addChild: menuBg z: 7];

        
        CCMenuItemImage *exitMenuBtn = [CCMenuItemImage itemFromNormalImage: @"exitBtn.png"
                                                              selectedImage: @"exitBtn.png"
                                                                      block: ^(id sender) {
                                                                          
                                                                          mistakes = 0;
                                                                          
                                                                          isMistake = NO;
                                                                          
                                                                          [self addMistakesSprites];
                                                                          
                                                                          for(CCSprite *spr in crossesArray)
                                                                          {
                                                                              [self removeChild: spr  cleanup: YES];
                                                                          }
                                                                          
                                                                          [crossesArray removeAllObjects];
                                                                          
                                                                          [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: [MainMenuLayer scene]]];
                                                                      }
                                        ];
        
        CCMenuItemImage *restartGameBtn = [CCMenuItemImage itemFromNormalImage: @"replayBtn.png"
                                                                 selectedImage: @"replayBtn.png"
                                                                        target: self
                                                                      selector: @selector(restartGame)
                                           ];
        
        exitMenuBtn.position = ccp(120, 100);
        restartGameBtn.position = ccp(240, 100);
        
        CCMenu *menu = [CCMenu menuWithItems: exitMenuBtn, restartGameBtn, nil];
        menu.position = ccp(0,0);
        
        [menuBg addChild: menu];
        
        
        [menuBg runAction: [CCEaseBackInOut actionWithAction: [CCMoveTo actionWithDuration: 0.5 position: ccp(240, 160)] ]];
    }
}

- (void) restartGame
{
    mistakes = 0;
    
    isMistake = NO;
    
    [self addMistakesSprites];

    for(CCSprite *spr in crossesArray)
    {
        [self removeChild: spr  cleanup: YES];
    }
    
    [crossesArray removeAllObjects];
    
    IsMorphGameActive = YES;
    [gameLayer restartGame];
    [self removeChild: menuBg cleanup: YES];
    [self removeChild: pauseLayer cleanup: YES];
    [self unlockAllButtons];
    [gameLayer unPauseTransitions];

}

- (void) updateDistanceLabel: (NSInteger) distance
{
    //remainingDistance.string = [NSString stringWithFormat: @"Remaining distance: %i", distance];
}

- (void) transmitNumberOfAction: (CCMenuItemFont *) sender
{
    [gameLayer doAction: sender.tag];
}

- (void) drawCross: (NSInteger) num
{
    CCArray *items = [buttonsMenu children];
    for(CCMenuItemImage *curItem in items)
    {
        if(curItem.tag == num)
        {
            isMistake = YES;
            CCSprite *mist = [CCSprite spriteWithFile: @"mistake.png"];
            mist.scale = 0.3;
            mist.position = curItem.position;
            [self addChild: mist z: 5];
            
            [crossesArray addObject: mist];
            
            [mist runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 0.2],
                                                  [CCFadeTo actionWithDuration: 0.8 opacity: 0],
                                                  [CCDelayTime actionWithDuration: 0.2],
                                                  [CCFadeTo actionWithDuration: 0.8 opacity: 255],
                                                  [CCDelayTime actionWithDuration: 0.2],
                                                  [CCFadeTo actionWithDuration: 0.8 opacity: 0],
                                                  [CCCallFunc actionWithTarget: self selector: @selector(removeMist)],
                              nil]];
        }
    }
}

- (void) removeMist
{
    isMistake = NO;
    [self removeChild: [crossesArray lastObject] cleanup: YES];
}

@end
