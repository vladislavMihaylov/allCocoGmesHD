//
//  GameConfig.h
//  openGLExample
//
//  Created by Mac on 25.07.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#ifndef __GAME_CONFIG_H
#define __GAME_CONFIG_H

#define PTM_RATIO 32
#define ptm2cc(a)           ((a) * PTM_RATIO)
#define cc2ptm(a)           ((a) / PTM_RATIO)
#define cc2ptmVec2(x, y)    (b2Vec2(cc2ptm(x), cc2ptm(y)))

//
// Supported Autorotations:
//		None,
//		UIViewController,
//		CCDirector
//
#define kGameAutorotationNone 0
#define kGameAutorotationCCDirector 1
#define kGameAutorotationUIViewController 2

//
// Define here the type of autorotation that you want for your game
//

// 3rd generation and newer devices: Rotate using UIViewController. Rotation should be supported on iPad apps.
// TIP:
// To improve the performance, you should set this value to "kGameAutorotationNone" or "kGameAutorotationCCDirector"
#if defined(__ARM_NEON__) || TARGET_IPHONE_SIMULATOR
#define GAME_AUTOROTATION kGameAutorotationUIViewController

// ARMv6 (1st and 2nd generation devices): Don't rotate. It is very expensive
#elif __arm__
#define GAME_AUTOROTATION kGameAutorotationNone


// Ignore this value on Mac
#elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)

#else
#error(unknown architecture)
#endif

#define kZBackGroundPic  0
#define kZWaveBack       1
#define kZWaveFront      2

#define GameWidth  480
#define GameHeight 320

#define kEasyDif        500
#define kMediumDif      550
#define kHardDif        600

#define kLangEng        1
#define kLangFr         2
#define kLangMan        3
#define kLangGer        4
#define kLangSpan       5
#define kLangArab       6

#define kShadowTag      9

#define kCatTag         101
#define kDogTag         102
#define kDuckTag        103
#define kCowTag         104
#define kRoosterTag     105
#define kSnailTag       106
#define kRabbitTag      107
#define kButterflyTag   108
#define kHorseTag       109
#define kParrotTag      110
#define kPigTag         111

#define kMiniRooster    200

#define kZSelection     6
#define kZShadow        7
#define kZbackButton    8
#define kZGameOverLabel 10

#define kMaxScoreKey @"maxScoreKey"

extern float GameCenterX;
extern float GameCenterY;

extern int CurrentLanguage;
extern int CurrentDifficulty;
extern int CurrentGame;

extern BOOL IsHookActive;
extern BOOL IsFishCauth;
extern BOOL IsGameActive;
extern BOOL IsCanSpawnFish;
extern BOOL IsRestartGame; 

#endif // __GAME_CONFIG_H

