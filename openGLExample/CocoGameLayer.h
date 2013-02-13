//
//  HelloWorldLayer.h
//  catchCoco
//
//  Created by Mac on 14.04.12.
//  Copyright spotGames 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CocoGUILayer.h"

// HelloWorldLayer
@interface CocoGameLayer : CCLayer
{
    CCMenu *animals;
    CCMenuItemImage *animal;
    CCSprite *mistake;
    CCSprite *miniCoco;
    
    NSInteger number;
    NSInteger countCoco;
    NSInteger allAnimals;
    
    CocoGUILayer *cocoGui;
    
    float moveTime;
    float scaleTime;
    
    int count;
    
    NSInteger array[11];
    
    NSInteger rightOrLeft;
    NSInteger sideIn;
    NSInteger sideOut;
    NSInteger enterHeight;
    NSInteger outHeight;
    NSInteger xPosition;
    NSInteger yPosition;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)playGame;
-(void)gameOver;
-(void)showAnimal;
-(void)createMatrix;

@property (nonatomic, assign) CocoGUILayer *cocoGuiLayer;

@end
