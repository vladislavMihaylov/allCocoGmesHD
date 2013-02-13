//
//  MyCocos2DClass.h
//  morphing
//
//  Created by Vlad on 09.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Ground.h"
#import "MorphCoco.h"
#import "MorphFrancois.h"

#import "MorphGUILayer.h"

@interface MorphGameLayer: CCNode
{
    MorphGUILayer *gui;
    
    CCSprite *stone;
    
    Ground *ground;
    MorphCoco *coco;
    MorphFrancois *francois;
    
    float currentSpeed;
    NSInteger currentGround;
    NSInteger curAction;
        
    CCLabelTTF *leftDistance;
    
    float time; 
    
    CCSpriteBatchNode *backGroundBatch;
    
    /*CCSprite *back;
    CCSprite *trees;
    CCSprite *farTrees;
    CCSprite *bushes;*/
    
    NSMutableArray *bushesArray;
    NSMutableArray *treesArray;
    NSMutableArray *farTreesArray;
}

+ (CCScene *) scene;

- (void) restartGame;
- (void) showAnimationOfTransition;
- (void) finishGame;
- (void) fuckingJump;
- (void) runGround;
- (void) showFirstActionLabel;
- (void) pauseTransitions;
- (void) unPauseTransitions;

- (void) stopStone;


- (void) doAction: (NSInteger) numberOfAction;

@property (nonatomic, assign) MorphGUILayer *guiLayer;

@end
