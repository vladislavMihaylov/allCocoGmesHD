//
//  GameConfig.m
//  openGLExample
//
//  Created by Mac on 25.07.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameConfig.h"

float GameCenterX = GameWidth / 2.0;
float GameCenterY = GameHeight / 2.0;

int CurrentLanguage     = kLangEng;
int CurrentDifficulty   = 0;
int CurrentGame         = 10;

BOOL IsHookActive = YES;
BOOL IsFishCauth = NO;

BOOL IsGameActive = NO;
BOOL IsCanSpawnFish = YES;
BOOL IsRestartGame = NO;