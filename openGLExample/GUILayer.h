//
//  GUILayer.h
//  openGLExample
//
//  Created by Mac on 25.07.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@class GameLayer;

@interface GUILayer: CCLayer 
{
    GameLayer *gameLayer;
    
    CCLabelBMFont *scoreLabel;
    CCLabelBMFont *timeLabel; 
    CCLabelBMFont *yourScore;
    CCLabelBMFont *yourBestScoreLabel;
    CCLabelBMFont *pauseLabel;
    
    CCLayerColor *pauseLayer;
    
    CCMenu *pauseMenu;
}

- (void) updateScoreLabel: (NSInteger) score;
-(void) formatCurrentTime:(NSInteger) seconds;

- (void) showPauseMenu;
- (void) showGameOverMenu: (NSInteger) bestScore;

@property (nonatomic, assign) GameLayer *gameLayer; 

@end
