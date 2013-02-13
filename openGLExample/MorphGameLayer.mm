//
//  MyCocos2DClass.m
//  morphing
//
//  Created by Vlad on 09.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MorphGameLayer.h"
#import "MorphGameConfig.h"
#import "GameConfig.h"
#import "SimpleAudioEngine.h"

@implementation MorphGameLayer

@synthesize guiLayer;

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    MorphGameLayer *layer = [MorphGameLayer node];
    
    MorphGUILayer *gui = [MorphGUILayer node];
    
    [scene addChild: layer];

    [scene addChild: gui];
    
    layer.guiLayer = gui;
    gui.gameLayer = layer;
        
    return scene;
}

- (void) dealloc
{
    [super dealloc];
    
    [bushesArray release];
    [treesArray release];
    [farTreesArray release];
}


- (id) init
{
    if (self = [super init])
    {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic: @"actionBgMusic.wav" loop: YES];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: 0.2f];
        
        IsMorphGameActive = YES;
        
        IsMoveRight = YES;
        IsMoveUp = NO;
        IsMoveDown = NO;
        
        isMoveUpBackGround = NO;
        
        moveBG = YES;
        
        bushesArray = [[NSMutableArray alloc] init];
        treesArray = [[NSMutableArray alloc] init];
        farTreesArray = [[NSMutableArray alloc] init];
        
        backGroundBatch = [CCSpriteBatchNode batchNodeWithFile: @"backGround.png"];
        [self addChild: backGroundBatch z: -50];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"backGround.plist"];
        
        //CCSprite *back = [CCSprite spriteWithFile: @"allBack.png"];
        
        CCSprite *back = [CCSprite spriteWithSpriteFrameName: @"background.png"];
        back.position = ccp(240, 160);
        
        [backGroundBatch addChild: back];
        
        for(int i = 0; i < 2; i++)
        {
            CCSprite *trees = [CCSprite spriteWithSpriteFrameName: @"trees.png"];
            trees.position = ccp(240 + 480 * i, 120);
            trees.scaleX = 1.02;
            
            CCSprite *farTrees = [CCSprite spriteWithSpriteFrameName: @"farTrees.png"];
            farTrees.position = ccp(240 + 480 * i, 160);
            farTrees.scaleX = 1.02;
            
            CCSprite *bushes = [CCSprite spriteWithSpriteFrameName: @"bushes.png"];
            bushes.position = ccp(240 + 480 * i, 110);
            bushes.scaleX = 1.02;

            [bushesArray addObject: bushes];
            [farTreesArray addObject: farTrees];
            [treesArray addObject: trees];
            
            [backGroundBatch addChild: farTrees z: 0];
            [backGroundBatch addChild: trees    z: 1];
            [backGroundBatch addChild: bushes   z: 2];
        }
        
        //[self addChild: back z: -50];
        
        ground = [Ground create];
        ground.gameLayer = self;
        [self addChild: ground z: 0];
        
        //[self restartGame];
        
        if(typeCharacter == 0)
        {
            coco = [MorphCoco createWithSpeed: currentSpeed];
            [self addChild: coco z: 1];
            
            //coco.scale = 0.3;
            coco.position =ccp(0, 0);
            
            [coco doAction: 0 withSpeed: 0];
            
            coco.gameLayer = self;
            
            
        }
        else if(typeCharacter == 1)
        {
            francois = [MorphFrancois createWithSpeed: currentSpeed];
            [self addChild: francois];
            
            francois.position =ccp(0, 0);
            
            [francois doAction: 0 withSpeed: 0];
            
            francois.gameLayer = self;
        }
        //
        //        [guiLayer showCurrentActionLabel: 1000];
        
        currentSpeed = 0;
        
        // Buttons
        
        [self scheduleUpdate];
        [self showFirstActionLabel];
    }
    
    return self;
}

- (void) finishGame
{
    if(typeCharacter == 0)
    {
        [coco stopAllActions];
        [coco pauseAll];
    }
    else if(typeCharacter == 1)
    {
        [francois stopAllActions];
        [francois pauseAll];
        //[francois setFinishZ];
    }
    [self reorderChild: ground z: -10];
    [guiLayer showGameOverMenu];
    [[SimpleAudioEngine sharedEngine] playEffect: [NSString stringWithFormat: @"%ifinish.mp3", CurrentLanguage]];
    [[SimpleAudioEngine sharedEngine] playEffect: @"Crowd_applause_1.mp3"];
    
    
    moveBG = NO;
}

- (void) pauseTransitions
{
    moveBG = NO;
    
    if(runStone)
    {
        [self pauseSchedulerAndActions];
        [stone pauseSchedulerAndActions];
    }
    
    if(typeCharacter == 0)
    {
        [coco pauseSchedulerAndActions];
        [coco transitionsPause];
    }
    else if(typeCharacter == 1)
    {
        [francois pauseSchedulerAndActions];
        [francois transitionsPause];
    }
  
}

- (void) unPauseTransitions
{
    moveBG = YES;
    
    
    [self resumeSchedulerAndActions];
    [stone resumeSchedulerAndActions];
    
    
    if(typeCharacter == 0)
    {
        [coco resumeSchedulerAndActions];
        [coco transitionsUnPause];
    }
    else if(typeCharacter == 1)
    {
        [francois resumeSchedulerAndActions];
        [francois transitionsUnPause];
    }
}

- (void) showAnimationOfTransition
{
    
    CCLOG(@"actNum %i", curAction);
    [guiLayer blockAllButtons];
    
    if(typeCharacter == 0)
    {
        [self reorderChild: coco z: -2];
    }
    else if(typeCharacter == 1)
    {
        [self reorderChild: francois z: -2];
    }
    
    if(curAction >= 1003)
    {
        if(typeCharacter == 0)
        {
            [self reorderChild: coco z: 10];
        }
        if(typeCharacter == 1)
        {
            [self reorderChild: francois z: 10];
        }
    }
    
    if(typeCharacter == 0)
    {
        [coco rotate: curAction andCurrentGround: [ground getCurrentActionNumber]];
    }
    else if(typeCharacter == 1)
    {
        [francois rotate: curAction andCurrentGround: [ground getCurrentActionNumber]];
    }
    
    [ground increaseSpeedAnimation: 7];
    
    NSInteger delayTime;
    
    if(curAction == 1002 || [ground getCurrentActionNumber] == 1004 || [ground getCurrentActionNumber] == 1005 )
    {
        delayTime = 0;
    }
    else if(curAction == 1004)
    {
        if(typeCharacter == 0)
        {
            delayTime = 1;
        }
        else
        {
            delayTime = 2;
        }
    }
    else
    {
        delayTime = 2;
    }
    
    if(typeCharacter == 0)
    {
        [coco runAction: [CCSequence actions:
                                [CCDelayTime actionWithDuration: delayTime],
                                [CCCallFunc actionWithTarget: self
                                                    selector: @selector(doNextAction)], nil]];
    }
    else if(typeCharacter == 1)
    {
           [francois runAction: [CCSequence actions:
                                [CCDelayTime actionWithDuration: delayTime],
                                [CCCallFunc actionWithTarget: self
                                                    selector: @selector(doNextAction)], nil]];
    }

}

- (void) hideCoco
{
    if(typeCharacter == 0)
    {
        [coco hideCoco];
    }
    else if(typeCharacter == 1)
    {
        [francois hideCoco];
    }
}

- (void) doNextAction
{
    if(IsMorphGameActive == YES)
    {
        
    [guiLayer showCurrentActionLabel: curAction];
    
    if(curAction == 1002)
    {
        [self fuckingJump]; //[self doAction: 1002];
        
        if(typeCharacter == 0)
        {
            [coco stopCoco];
        }
        else if(typeCharacter == 1)
        {
            [francois stopCoco];
        }
    }
    if(curAction == 1000)// && currentGround == kIsRunOnMountain)
    {
        [self runGround];
    }
    if(curAction == 1004)
    {
        if(typeCharacter == 0)
        {
            [coco setPosition: ccp(coco.position.x, coco.position.y + 40)];
        }
        else if(typeCharacter == 1)
        {
            //[francois rotate: 1000 andCurrentGround: 1004];
            [francois setPosition: ccp(francois.position.x + 20, francois.position.y + 40)];
        }
    }
    //if()
    
    if(typeCharacter == 0)
    {
        [coco doAction: curAction - 1000 withSpeed: currentSpeed];
    }
    if(typeCharacter == 1)
    {
        [francois doAction: curAction - 1000 withSpeed: currentSpeed];
        [ground increaseSpeedAnimation: [francois getCurrentGroundSpeed]];
    }
        
    [guiLayer unlockAllButtons];
        
    }
}


- (void) showFirstActionLabel
{
    
    [[SimpleAudioEngine sharedEngine] playEffect: [NSString stringWithFormat: @"%icoco%i.mp3", CurrentLanguage, 0]];

    
}

- (void) restartGame
{
    iCanDown = YES;
   
    [self reorderChild: ground z: 0];
    
    if(runStone)
    {
        [self removeChildByTag: 99 cleanup: YES];
        runStone = NO;
        [self unschedule: @selector(runBigStone)];
    }
    
    [guiLayer showCurrentActionLabel: 1000];
    //[self removeChild: ground cleanup: YES];
    [ground restart];
    
    moveBG = YES;
  
    for(CCSprite *curBush in bushesArray)
    {
        [curBush setPosition: ccp(curBush.position.x, 110)];
    }
    for(CCSprite *curTree in treesArray)
    {
        [curTree setPosition: ccp(curTree.position.x, 120)];
    }
    for(CCSprite *curFarTree in farTreesArray)
    {
        [curFarTree setPosition: ccp(curFarTree.position.x, 160)];
    }
    
    if(typeCharacter == 0)
    {
        //[coco doAction: 0 withSpeed: 0];
        [self removeChild: coco cleanup: YES];
        currentSpeed = 0;
        curAction = 1000;
        
        coco = [MorphCoco createWithSpeed: currentSpeed];
        [self addChild: coco];
        
        //coco.scale = 0.3;
        coco.position = ccp(0,0);//ccp(100, 105);
        
        [coco doAction: 0 withSpeed: 0];

    }
    if(typeCharacter == 1)
    {
        [self removeChild: francois cleanup: YES];
        currentSpeed = 0;
        curAction = 1000;
        
        francois = [MorphFrancois createWithSpeed: currentSpeed];
        [self addChild: francois];
        
        //coco.scale = 0.3;
        coco.position = ccp(0,0);//ccp(100, 105);
        
        [francois doAction: 0 withSpeed: 0];
    }
    
}

- (void) runGround
{
    [coco doAction: 0 withSpeed: 7];
    [ground increaseSpeedAnimation: [coco getCurrentGroundSpeed]];

}

- (void) fuckingJump
{
    if(typeCharacter == 0)
    {
        
        [coco doAction: 0 withSpeed: 7];//currentSpeed];
        [coco doAction: 1002 withSpeed: 7]; //currentSpeed];
        [ground increaseSpeedAnimation: 7];//[coco getCurrentGroundSpeed]];
    }
    else if(typeCharacter == 1)
    {
        [francois doAction: 0 withSpeed: 7];     //currentSpeed];
        [francois doAction: 1002 withSpeed: 7];  //currentSpeed];
        [ground increaseSpeedAnimation: 7];      //[francois getCurrentGroundSpeed]];
        
    }

}

- (void) doAction: (NSInteger) numberOfAction
{
    //CCLOG(@"Current Action: %i", curAction);
    
    if(numberOfAction == 999)
    {
        //[coco doAction: 4 withSpeed: currentSpeed];
        
        if(curAction == 1001)
        {
            if(typeCharacter == 0)
            {
                [self reorderChild: coco z: -10];
            }
            else if(typeCharacter == 1)
            {
                [self reorderChild: francois z: -10];
            }
        }
        else
        {
            if(typeCharacter == 0)
            {
                [self reorderChild: coco z: 1];
            }
            else if(typeCharacter == 1)
            {
                [self reorderChild: francois z: 1];
            }
        }
        
        if(curAction == 1002)
        {
            if(ICanJump)
            {
                //currentSpeed = 5.5;
                
                if(typeCharacter == 0)
                {
                    [coco doAction: 0 withSpeed: currentSpeed];
                    [coco doAction: 2 withSpeed: currentSpeed];
                    [ground increaseSpeedAnimation: [coco getCurrentGroundSpeed]];
                }
                else if(typeCharacter == 1)
                {
                    [francois doAction: 0 withSpeed: currentSpeed];
                    [francois doAction: 2 withSpeed: currentSpeed];
                    [ground increaseSpeedAnimation: [francois getCurrentGroundSpeed]];
                    
                }
            }
            
        }
        else
        {
            currentSpeed += 0.5;
            
            if(typeCharacter == 0)
            {
                [coco doAction: curAction - 1000 withSpeed: currentSpeed];
                [ground increaseSpeedAnimation: [coco getCurrentGroundSpeed]];
                
            }
            else if(typeCharacter == 1)
            {
                [francois doAction: curAction - 1000 withSpeed: currentSpeed];
                [ground increaseSpeedAnimation: [francois getCurrentGroundSpeed]];
                
            }
        }
    }
    
    if (curAction != 1002)
    {
        if ((curAction - 1000) != numberOfAction)
        {
            if(CurrentDifficulty == 2)
            {
                CCLOG(@"PZDC!!!");
                if(!isMistake)
                {
                    [guiLayer increaseMistake];
                    [guiLayer drawCross: numberOfAction];
                }
            }
        }
        else
        {
            currentSpeed += 0.5;
            
            if(typeCharacter == 0)
            {
                if(numberOfAction == 1)
                {
                    [self reorderChild: coco z: -10];
                }
                else
                {
                    [self reorderChild: coco z: 1];
                }
                [coco doAction: numberOfAction withSpeed: currentSpeed];
                [ground increaseSpeedAnimation: [coco getCurrentGroundSpeed]];

            }
            else if(typeCharacter == 1)
            {
                if(numberOfAction == 1)
                {
                    [self reorderChild: francois z: -10];
                }
                else
                {
                    [self reorderChild: francois z: 1];
                }
                [francois doAction: numberOfAction withSpeed: currentSpeed];
                [ground increaseSpeedAnimation: [francois getCurrentGroundSpeed]];

            }
        }
    }
    else if(curAction == 1002)
    {
        if ((curAction - 1000) != numberOfAction)
        {
            if(CurrentDifficulty == 2)
            {
            CCLOG(@"PZDC!!!");
                [guiLayer increaseMistake];
            }
        }
        else
        {
            if(ICanJump)
            {
                //currentSpeed = 5.5;
                
                if(typeCharacter == 0)
                {
                    
                    [coco doAction: 0 withSpeed: currentSpeed];
                    [coco doAction: numberOfAction withSpeed: currentSpeed];
                    [ground increaseSpeedAnimation: [coco getCurrentGroundSpeed]];
                }
                else if(typeCharacter == 1)
                {
                    [francois doAction: 0 withSpeed: currentSpeed];
                    [francois doAction: numberOfAction withSpeed: currentSpeed];
                    [ground increaseSpeedAnimation: [francois getCurrentGroundSpeed]];

                }
            }
        }
    }
}

- (void) runBigStone
{
    if(CurrentDifficulty == 2)
    {
        CCLOG(@"OLOLO");
        stone = [CCSprite spriteWithFile: @"stone.png"];
        stone.position = ccp(500, 100);
        [self addChild: stone z: 20 tag: 99];
        
        [stone runAction: [CCMoveTo actionWithDuration: 2 position: ccp(-20, stone.position.y)]];
        [stone runAction: [CCRotateTo actionWithDuration: 2 angle: -720]];
        
        [stone retain];
    }
}

- (void) stopStone
{
     [self unschedule: @selector(runBigStone)];
}

- (void) checkStoneCollisions
{
    
    
    //CGPoint convertedCoords = [self convertToNodeSpace: self.position];
    
    //CCLOG(@"CocoX: %f StoneX: %f", coco.runningCoco.position.y, stone.position.y);
    
    if(typeCharacter == 0)
    {
        if( (fabs(stone.position.x - 210) < 20) && (fabs(stone.position.y - (coco.runningCoco.position.y+155) ) < 65) )
        {
            if(!isCollision)
            {
                isCollision = YES;
                CCLOG(@"COLLISION");
                if(CurrentDifficulty == 2)
                {
                    [guiLayer increaseMistake];
                }
            }
        }
    }
    if(typeCharacter == 1)
    {
        if( (fabs(stone.position.x - 210) < 20) && (fabs(stone.position.y - (francois.runningFrancois.position.y +105)) < 40) )
        {
            if(!isCollision)
            {
                isCollision = YES;
                CCLOG(@"COLLISION");
                if(CurrentDifficulty == 2)
                {
                    [guiLayer increaseMistake];
                }
            }
        }
    }
}

- (void) update: (float) dt
{
    //CCLOG(@"franco pos = %f and %f" , francois.runningFrancois.body.position.y, francois.runningFrancois.position.y);
    
    [self checkStoneCollisions];
    
    if(stone.position.x < -18)
    {
        if(runStone)
        [self removeChildByTag: 99 cleanup: YES];
        isCollision = NO;
    }
    
    //if(coco.position.x - )
    
    curAction = [ground getCurrentActionNumber];
    //CCLOG(@"Current Ground is %i", curAction);
    //[guiLayer updateDistanceLabel: 500 - [ground getCurrentDistance]];
    
    if(curAction == 1002)
    {
        if(!runStone)
        {
            [self schedule: @selector(runBigStone) interval: 2];
            runStone = YES;
        }
    }
    /*if(curAction == 1003)
    {
        [self unschedule: @selector(runBigStone)];
    }*/
    
    
    currentSpeed = [ground getCurrentSpeed];
    
    float multiplier = dt * 28 * currentSpeed;
    
    time += multiplier;
    
    if(time < 0)
    {
        time = 0;
    }
    
    if(moveBG)
    {
    
    if(IsMoveRight)
    {
        for(CCSprite *curBush in bushesArray)
        {
            curBush.position = ccp(curBush.position.x - multiplier / 2, curBush.position.y);
            
            if(curBush.position.x < -239)
            {
                curBush.position = ccp(720, curBush.position.y);
            }
        }
        for(CCSprite *curTree in treesArray)
        {
            curTree.position = ccp(curTree.position.x - multiplier / 4, curTree.position.y);
            
            if(curTree.position.x < -239)
            {
                curTree.position = ccp(720, curTree.position.y);
            }
        }
        for(CCSprite *curFarTree in farTreesArray)
        {
            curFarTree.position = ccp(curFarTree.position.x - multiplier / 8, curFarTree.position.y);
            
            if(curFarTree.position.x < -239)
            {
                curFarTree.position = ccp(720, curFarTree.position.y);
            }
        }
        if(isMoveDownBackGround)
        {
            isMoveDownBackGround = NO;
            
            for(CCSprite *curBush in bushesArray)
            {
                [curBush runAction:
                 [CCMoveTo actionWithDuration: 0.6
                                     position: ccp(curBush.position.x, 110)]
                 ];
            }
            for(CCSprite *curTree in treesArray)
            {
                [curTree runAction:
                 [CCMoveTo actionWithDuration: 0.6
                                     position: ccp(curTree.position.x, 120)]
                 ];
                
            }
            for(CCSprite *curFarTree in farTreesArray)
            {
                [curFarTree runAction:
                 [CCMoveTo actionWithDuration: 0.6
                                     position: ccp(curFarTree.position.x, 160)]
                 ];
            }
        }
    }
    if(IsMoveUp)
    {
        if(!isMoveUpBackGround)
        {
            isMoveUpBackGround = YES;
            
            for(CCSprite *curBush in bushesArray)
            {
                [curBush runAction:
                                [CCMoveTo actionWithDuration: 0.6
                                                    position: ccp(curBush.position.x, -20)]
                ];
            }
            for(CCSprite *curTree in treesArray)
            {
                [curTree runAction:
                                [CCMoveTo actionWithDuration: 0.6
                                                    position: ccp(curTree.position.x, -10)]
                 ];
            
            }
            for(CCSprite *curFarTree in farTreesArray)
            {
                [curFarTree runAction:
                                [CCMoveTo actionWithDuration: 0.6
                                                    position: ccp(curFarTree.position.x, 30)]
                 ];
            }
        }
        else
        {
            for(CCSprite *curBush in bushesArray)
            {
                curBush.position = ccp(curBush.position.x, curBush.position.y - multiplier / 10);
            }
            for(CCSprite *curTree in treesArray)
            {
                curTree.position = ccp(curTree.position.x, curTree.position.y - multiplier / 10);
            }
            for(CCSprite *curFarTree in farTreesArray)
            {
                curFarTree.position = ccp(curFarTree.position.x, curFarTree.position.y - multiplier / 10);
            }
        }
    }
    if(IsMoveDown)
    {
    /*if(isMoveDownBackGround)
        {
            isMoveDownBackGround = NO;
            
            for(CCSprite *curBush in bushesArray)
            {
                [curBush runAction:
                 [CCMoveTo actionWithDuration: 0.6
                                     position: ccp(curBush.position.x, 110)]
                 ];
            }
            for(CCSprite *curTree in treesArray)
            {
                [curTree runAction:
                 [CCMoveTo actionWithDuration: 0.6
                                     position: ccp(curTree.position.x, 120)]
                 ];
                
            }
            for(CCSprite *curFarTree in farTreesArray)
            {
                [curFarTree runAction:
                 [CCMoveTo actionWithDuration: 0.6
                                     position: ccp(curFarTree.position.x, 160)]
                 ];
            }
        }
        else
        {*/
            for(CCSprite *curBush in bushesArray)
            {
                curBush.position = ccp(curBush.position.x, curBush.position.y + multiplier / 10);
            }
            for(CCSprite *curTree in treesArray)
            {
                curTree.position = ccp(curTree.position.x, curTree.position.y + multiplier / 10);
            }
            for(CCSprite *curFarTree in farTreesArray)
            {
                curFarTree.position = ccp(curFarTree.position.x, curFarTree.position.y + multiplier / 10);
            }
        //}
        }
    }
}

@end
