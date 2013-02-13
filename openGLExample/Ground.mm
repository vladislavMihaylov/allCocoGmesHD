//
//  Ground.m
//  morphing
//
//  Created by Vlad on 09.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Ground.h"
#import "MorphGameConfig.h"
#import "MorphGameLayer.h"
#import "MorphGUILayer.h"

@implementation Ground

@synthesize gameLayer;

- (void) dealloc
{
    [groundsArray release];
    [groundsToRemove release];
    
    [super dealloc];
}

- (id) init
{
    if(self = [super init])
    {
        groundsArray = [[NSMutableArray alloc] init];
        groundsToRemove = [[NSMutableArray alloc] init];
        
        currentGroundType = kIsGround;
        currentAction = kIsGround;
        direction = kIsHorizontalMove;
        
        isCanAddGroundTexture = NO;
        isTransferGround = NO;
        
        globalCount = 0;
        
        texturesBatch = [CCSpriteBatchNode batchNodeWithFile: @"textures.png"];
        [self addChild: texturesBatch];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"textures.plist"];
        
        for (int i = 0; i < 6; i++)
        {
            //ground = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
            ground = [CCSprite spriteWithSpriteFrameName: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
            ground.position = ccp(240 + 480 * i, 120);
            ground.scaleX = 1.01;
            //[self addChild: ground];
            [texturesBatch addChild: ground];
            
            [groundsArray addObject: ground];
        }
        
        [self scheduleUpdate];
    }
    
    return self;
}

+ (Ground *) create
{
    Ground *ground = [[[Ground alloc] init] autorelease];
    
    return ground;
}

- (void) restart
{
//    for(CCSprite *currentSprite in groundsArray)
//    {
//        //[groundsToRemove addObject: currentSprite];
//        [texturesBatch removeChild: currentSprite cleanup: YES];
//    }
    
    [texturesBatch removeAllChildrenWithCleanup: YES];
    
    //[self removeChild: texturesBatch cleanup: YES];
    
    
    //texturesBatch = [CCSpriteBatchNode batchNodeWithFile: @"textures.png"];
    //[self addChild: texturesBatch];
    
    
    
    //CCLOG(@"%@", texturesBatch);
    
    
    
    [groundsArray removeAllObjects];
    
    currentGroundType = 1000;
    currentAction = 1000;
    
    IsMoveDown = NO;
    IsMoveUp = NO;
    IsMoveRight = YES;
    
    globalCount = 0;
    speed = 0;
    
    for (int i = 0; i < 6; i++)
    {
        //ground = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
        CCLOG(@" cur gr %i", currentGroundType);
        ground = [CCSprite spriteWithSpriteFrameName: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
        ground.position = ccp(240 + 480 * i, 120);
        ground.scaleX = 1.01;
        //[self addChild: ground];
        [texturesBatch addChild: ground];
        
        [groundsArray addObject: ground];
    }
    
    //for(CCSprite *currentSpriteToRemove in groundsToRemove)
    //{
    //    [groundsArray removeObject: currentSpriteToRemove];
    //}
    
    //[groundsToRemove release];
    
}

- (void) increaseSpeedAnimation: (float) currentSpeed
{
    speed = currentSpeed;
}


- (void) showNewGround: (NSInteger) groundType
{
    //CCLOG(@"groundType: %i", groundType);
    
    ItsNewGround = YES;
    
    if(currentGroundType == kIsGoUpMountain)
    {
        placeForNewSprite = ccp(720 , 160);
    }
    
    firstSpriteOfGround = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", groundType]];
    firstSpriteOfGround.position = placeForNewSprite;
    [self addChild: firstSpriteOfGround z: 1 tag: kFirstSpriteTag];
    
    [groundsArray addObject: firstSpriteOfGround];
    
    //isTransferGround = YES;
}

//- (NSInteger) getCurrentDistance
//{
//    return distance;
//}

- (NSInteger) getCurrentActionNumber
{
    return currentAction;
}

- (float) getCurrentSpeed
{
    return speed;
}

- (void) update: (float) dt
{
    if(IsMorphGameActive)
    {
        
        if(globalCount >= 14)
        {
            if(runStone)
            {
                [gameLayer stopStone];
                runStone = NO;
            }
        }
        
        speed -= 1.5 * dt;
        
        if(speed < 0)
        {
            speed = 0;
        }
        
        if(speed <= 0)
        {
            speed = 0;
        }
        if(speed > 9)
        {
            speed = 9;
        }
        
        float multiplier = dt * 28 * speed;
        
        time += multiplier;
        
        if(time < 0)
        {
            time = 0;
        }
        
        for(CCSprite *currentSprite in groundsArray)
        {
            if(IsMoveRight)
            {
                currentSprite.position = ccp(currentSprite.position.x - multiplier, currentSprite.position.y);
                
                if(currentSprite.position.x < -240)
                {
                    [groundsToRemove addObject: currentSprite];
                    [self removeChild: currentSprite cleanup: YES];
                }
            }
            if(IsMoveUp)
            {
                currentSprite.position = ccp(currentSprite.position.x, currentSprite.position.y - multiplier);
                
                if(currentSprite.position.y < -160)
                {
                    [groundsToRemove addObject: currentSprite];
                    [self removeChild: currentSprite cleanup: YES];
                }

            }
            if(IsMoveDown)
            {
                currentSprite.position = ccp(currentSprite.position.x, currentSprite.position.y + multiplier);
                
                if(currentSprite.position.y > 480)
                {
                    [groundsToRemove addObject: currentSprite];
                    [self removeChild: currentSprite cleanup: YES];
                }

            }
        }
        
        for(CCSprite *currentSpriteToRemove in groundsToRemove)
        {
            globalCount++;
            
            CCLOG(@"Count: %i", globalCount);
            
            [groundsArray removeObject: currentSpriteToRemove];
            
            if(globalCount % 5 == 0)
            {
                if(globalCount == 35)
                {
                    currentGroundType = 1007;
                    INeedNextAction = YES;
                }
                else
                {
                    currentGroundType++;
                    INeedNextAction = YES;
                }
                
                    for (int i = 1; i < 6; i++)
                    {
                        if(i == 1)
                        {
                            //ground = [CCSprite spriteWithFile: [NSString stringWithFormat: @"1000to%i.png", currentGroundType]];
                            ground = [CCSprite spriteWithSpriteFrameName: [NSString stringWithFormat: @"1000to%i.png", currentGroundType]];
                            ground.scaleX = 1.01;
                        }
                        else
                        {
                            CCLOG(@" cur gr %i", currentGroundType);
                            //ground = [CCSprite spriteWithFile: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
                            ground = [CCSprite spriteWithSpriteFrameName: [NSString stringWithFormat: @"texture%i.png", currentGroundType]];
                            ground.scaleX = 1.01;
                            if(currentGroundType == 1005 && i == 5)
                            {
                                ground.scaleY = 1.05;
                            }
                        }
                            
                        if(currentGroundType == kIsGoUpMountain)
                        {
                            yPositionForSprites = 120;
                            
                            ground.position = ccp(720, yPositionForSprites + (320 * (i-1)));
                        }
                        else if(currentGroundType == kIsRunOnMountain)
                        {
                            yPositionForSprites = 430;
                            
                            ground.position = ccp(240 + 480 * (i - 1), yPositionForSprites);
                        }
                        else if(currentGroundType == kIsGoDownMountain)
                        {
                            yPositionForSprites = 160;
                            
                            ground.position = ccp(720, yPositionForSprites - (320 * (i-1)));
                        }
                        else if(currentGroundType == kIsFinishRun)
                        {
                            yPositionForSprites = -160;
                            
                            ground.position = ccp(240 + 480 * (i - 1), yPositionForSprites);
                        }
                        else if(currentGroundType == 1007)
                        {
                            yPositionForSprites = 120;
                            
                            ground.position = ccp(240 + 480 * i, yPositionForSprites);
                        }
                        else
                        {
                            yPositionForSprites = 120;
                            
                            ground.position = ccp(238 + 480 * i, yPositionForSprites);
                        }
                        
                        //[self addChild: ground];
                        [texturesBatch addChild: ground];
                        
                        [groundsArray addObject: ground];
                    }
                
            }
        }
        
        [groundsToRemove removeAllObjects];
        
        if(INeedNextAction)
        {
            CCSprite *firstSprite = [groundsArray objectAtIndex: 1];
            
            if(IsMoveRight)
            {
                if(currentGroundType == kIsGoDownMountain || currentGroundType == 1003)
                {
                    xPositionForSprites = 240;
                }
                else
                {
                    xPositionForSprites = 480;
                }
                
                if(firstSprite.position.x < xPositionForSprites)
                {
                    INeedNextAction = NO;
                    
                    if(currentGroundType == 1007)
                    {
                        CCLOG(@"FINISH");
                        [self reorderChild: texturesBatch z: -100];
                        [gameLayer finishGame];
                    
                    }
                    
                    if(currentGroundType == kIsGoDownMountain)
                    {
                        currentAction = 1004;
                        
                        IsMoveRight = NO;
                        IsMoveDown = YES;
                    }
                    else
                    {
                        currentAction++;
                        
                        if(currentGroundType == kIsGoUpMountain)
                        {
                            IsMoveRight = NO;
                            IsMoveUp = YES;
                        }
                    }
                    
                    //CCLOG(@"OPA");
                    [gameLayer showAnimationOfTransition];
                    
                    
                }
            }
            if(IsMoveUp)
            {
                if(firstSprite.position.y < 160)
                {
                    INeedNextAction = NO;
                    currentAction = kIsGround;
                    CCLOG(@"OPA");
                    
                    if(currentGroundType == kIsRunOnMountain)
                    {
                        IsMoveRight = YES;
                        IsMoveUp = NO;
                    }
                    
                    [gameLayer showAnimationOfTransition];

                }
            }
            if(IsMoveDown)
            {
                if(firstSprite.position.y > 120)
                {
                    INeedNextAction = NO;
                    currentAction = kIsGround;
                    CCLOG(@"OPA");
                    
                    if(currentGroundType == kIsFinishRun)
                    {
                        IsMoveRight = YES;
                        IsMoveDown = NO;
                    }
                    
                    [gameLayer showAnimationOfTransition];

                }
            }
        }
    }
    
}



@end
