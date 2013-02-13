//
//  HelloWorldLayer.m
//  catchCoco
//
//  Created by Mac on 14.04.12.
//  Copyright spotGames 2012. All rights reserved.
//


// Import the interfaces
#import "CocoGameLayer.h"
#import "GameConfig.h"
#import "MainMenuLayer.h"
#import "SimpleAudioEngine.h"

// HelloWorldLayer implementation
@implementation CocoGameLayer

@synthesize cocoGuiLayer;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CocoGameLayer *layer = [CocoGameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    CocoGUILayer *cocoGui = [CocoGUILayer node];
    [scene addChild: cocoGui];
    
    layer.cocoGuiLayer = cocoGui;
    cocoGui.cocoGameLayer = layer;
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bg.mp3" loop:YES];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.5f];
        
        CCSprite *gameBackground = [CCSprite spriteWithFile:@"settingsBg.jpg"];
        gameBackground.position = ccp(GameCenterX, GameCenterY);
        [self addChild:gameBackground];
        
        mistake = [CCSprite spriteWithFile:@"mistake.png"];
        [mistake setOpacity:0];
        [self addChild:mistake];
        
        countCoco = 0;
        allAnimals = 0;
        IsGameActive = YES;

        [self playGame];
	}
	return self;
}

-(void)playGame
{
    [self runAction:[CCSequence actions:
                     [CCDelayTime actionWithDuration:1.0f],
                     [CCCallFunc actionWithTarget:self 
                                         selector:@selector(createMatrix)],
                     [CCCallFunc actionWithTarget:self 
                                         selector:@selector(showAnimal)],
                     nil]
     ];
}

-(void)createMatrix
{
    NSString *sString = @"";
    NSString *sTemp = @"";
   
    NSInteger iCount = 0;
    
    while(iCount < 9)
    {
        NSInteger iRandom = arc4random()%9+1;
        NSString *iRandomString = [NSString stringWithFormat:@"%i", iRandom];
        NSRange range = [sString rangeOfString:iRandomString];
        if(range.length == 0)
        {
            sString = [sString stringByAppendingString: iRandomString];
            iCount++;
        }
    }
   
    
    for (int i = 0; i < 9; i++)
    {
        sTemp = [sString substringToIndex:1];
        NSInteger temp = [sTemp intValue];
        array[i] = temp;
        sString = [sString substringFromIndex:1];
    }
    
    NSInteger rand = arc4random()%2;
    if (rand == 1)
    {
        array[9] = 10;
        array[10] = 11;
    }
    else 
    {
        array[9] = 11;
        array[10] = 10;  
    }
    
}

-(void)showAnimal
{
    if (IsGameActive == YES)
    {
        
        rightOrLeft = arc4random()%2;
        
        if (rightOrLeft == 0)
        {
            sideIn  = -150;
            sideOut = GameWidth + 150;
        }
        else
        {
            sideIn  = GameWidth + 150;
            sideOut = -150;
        }
        
        enterHeight = arc4random() % GameHeight;
        outHeight   = arc4random() % GameHeight;
        
        xPosition   = 130 + arc4random()%220;
        yPosition   = 130 + arc4random()%60;
        
        if (allAnimals != 0 && allAnimals % 6 == 0)
        {
            number = 5;
        }
        else 
        {
            number = array[count];
        }
        
        count++;
        allAnimals++;
        
    if (count == 10)
    {
        [self createMatrix];
        count = 0;
    }
    
    animal = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat:@"%ianimal.png", number] 
                                    selectedImage:[NSString stringWithFormat:@"%ianimal.png", number]
                                           target:self 
                                         selector:@selector(tapAnimal)
             ];
        
        if(CurrentDifficulty == 2)
        {
            animal.scale = 0.7;
            mistake.scale = 0.7;
        }
    
    
    animals = [CCMenu menuWithItems: animal, nil];
    animals.position = ccp(0, 0);
    animal.position = ccp(sideIn, enterHeight);
    animal.tag = number + 100;
    [self addChild:animals];
        
        float moveMicroTime;
        float scaleMicroTime;
        
        
        if(CurrentDifficulty == 0)
        {
            if (countCoco < 5)
            {
                moveMicroTime = 0.06;
            }
            else
            {
                moveMicroTime = 0.08;
            }
            
            scaleMicroTime = 0.011;
            
            scaleTime = 0.2f - (scaleMicroTime * countCoco); 
            if ( scaleTime < 0.015f)
            {
                scaleTime = 0.025;
            }
        }
        else if (CurrentDifficulty == 1)
        {
            if (countCoco < 5)
            {
                moveMicroTime = 0.065;
            }
            else
            {
                moveMicroTime = 0.085;
            }
            
            scaleMicroTime = 0.011;
            
            scaleTime = 0.2f - (scaleMicroTime * countCoco); 
            if ( scaleTime < 0.015f)
            {
                scaleTime = 0.025;
            }
        }
        else if (CurrentDifficulty == 2)
        {
            if (countCoco < 6)
            {
                moveMicroTime = 0.07;
            }
            else
            {
                moveMicroTime = 0.09;
            }
            
            scaleTime = 0.0;
        }
        
        
        
        
    moveTime = 1.0f - (moveMicroTime * countCoco) ; 
    /*scaleTime = 0.2f - (scaleMicroTime * countCoco); 
        if ( scaleTime < 0.015f)
        {
            scaleTime = 0.025;
        }*/
        
        float easyScale = 1.2;
        float hardScale = 0.85;
        float scale = 1.0;
        
        if (CurrentDifficulty == 0 || CurrentDifficulty == 1)
        {
            scale = easyScale;
        }
        else 
        {
            scale = hardScale;
        }
    
    /*[animal runAction:[CCSequence actions: [CCCallFunc actionWithTarget:self selector:@selector(playAnimalName)],
                                           [CCMoveTo actionWithDuration:moveTime position:ccp(gameCenterX, gameCenterY)],
                                           [CCScaleTo actionWithDuration:scaleTime scale:1.2],
                                           [CCScaleTo actionWithDuration:scaleTime scale:1.0],
                                           [CCScaleTo actionWithDuration:scaleTime scale:1.2],
                                           [CCScaleTo actionWithDuration:scaleTime scale:1.0],
                                           [CCMoveTo actionWithDuration:moveTime position:ccp(-250, gameCenterY)],
                                           [CCCallFunc actionWithTarget:self selector:@selector(removeChilds)],
                                           [CCCallFunc actionWithTarget:self selector:@selector(showAnimal)]
                       
                       ,nil]];*/
        
        [animal runAction:[CCSequence actions: [CCCallFunc actionWithTarget:self selector:@selector(playAnimalName)],
                           [CCMoveTo actionWithDuration:moveTime position:ccp(xPosition, yPosition)],
                           [CCScaleTo actionWithDuration:scaleTime scale:scale],
                           [CCScaleTo actionWithDuration:scaleTime scale:animal.scale],
                           [CCScaleTo actionWithDuration:scaleTime scale:scale],
                           [CCScaleTo actionWithDuration:scaleTime scale:animal.scale],
                           [CCMoveTo actionWithDuration:moveTime position:ccp(sideOut , outHeight)],
                           [CCCallFunc actionWithTarget:self selector:@selector(removeChilds)],
                           [CCCallFunc actionWithTarget:self selector:@selector(showAnimal)]
                           
                           ,nil]];
    }
}

-(void)playAnimalName
{
    if (animal.tag == kRoosterTag)
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Coco.mp3"];
    }
    else
    {
        if(CurrentLanguage == 6)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"%i%i.mp3", CurrentLanguage, number]];
        }
        else
        {
            [[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"%i%i.wav", CurrentLanguage, number]];
        }
    }
}

-(void)removeChilds
{
    [animals removeChildByTag:number + 100 cleanup:YES];
}

-(void)tapAnimal
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
    if (animal.tag == kRoosterTag)
    {
        CCLOG(@"WOW!");
        countCoco ++;
        for (int k = 0; k < countCoco; k++)
        {
            [self removeChildByTag:kMiniRooster + k cleanup:YES];
            miniCoco = [CCSprite spriteWithFile:@"miniCoco.png"];
            miniCoco.position = ccp(430 - 35 * k, 295);
            [self addChild:miniCoco z:1 tag:kMiniRooster + k];
        }
        [self.cocoGuiLayer formatCocoString:countCoco];
        if (countCoco == 10)
        {
            for (int g = 0; g < 10; g++)
            {
                [self removeChildByTag:kMiniRooster + g cleanup:YES];
            }
            
            
            CCLOG(@"you win!");
            [self gameOver];
            [self.cocoGuiLayer ShowGameOverLabel];
            
        }
    }
    else
    {
        CCLOG(@"Oh NO!!!");
        mistake.position = animal.position;
        [mistake runAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.07f],[CCFadeOut actionWithDuration:0.07f],[CCFadeIn actionWithDuration:0.07f],[CCFadeOut actionWithDuration:0.07f] , nil]];
        
        if (CurrentDifficulty == 2)
        {
            if (countCoco > 0)
            {
                countCoco--;
            }
            
            [self.cocoGuiLayer formatCocoString:countCoco];
            [self removeChildByTag:kMiniRooster + countCoco cleanup:YES];
        }
        
    }
    
    
    [animal stopAllActions];
    [animal runAction: [CCSequence actions:
                            [CCMoveTo actionWithDuration:0.1f 
                                            position:ccp(sideOut, outHeight)
                            ], 
                            [CCDelayTime actionWithDuration:0.2f],
                            [CCCallFunc actionWithTarget:self 
                                                selector:@selector(showAnimal)
                            ]
                        ,nil]
     
     ];
}

-(void)gameOver
{
    IsGameActive = NO;
}

-(void)backInMainMenu:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[MainMenuLayer scene]]];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
