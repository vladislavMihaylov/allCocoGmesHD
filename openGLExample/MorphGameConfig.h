/*//
//  GameConfig.h
//  testApp
//
//  Created by Mac on 17.09.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#ifndef __GAME_CONFIG_H
#define __GAME_CONFIG_H

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
#endif*/

#define kSwimmingCocoTag      10
#define kRunningCocoTag       11

#define kFirstSpriteTag       50

#define kRunningAction        100
#define kSwimmingAction       101
#define kScramblingAction     102
#define kGoingDownAction      103

#define kIsGround             1000
#define kIsWater              1001
#define kIsJump               1002
#define kIsGoUpMountain       1003
#define kIsRunOnMountain      1004
#define kIsGoDownMountain     1005
#define kIsFinishRun          1006

#define kIsHorizontalMove     2000
#define kIsUpMove             2001
#define kIsDownMove           2002


extern NSInteger typeCharacter;
extern BOOL ICanJump;
extern BOOL iCanDown;
extern BOOL IsMoveRight;
extern BOOL IsMoveUp;
extern BOOL IsMoveDown;
extern BOOL ItsNewGround;

extern BOOL INeedNextAction;
extern BOOL IsMorphGameActive;

extern BOOL runStone;

extern BOOL isCollision;

extern BOOL isMoveUpBackGround;
extern BOOL isMoveDownBackGround;

extern BOOL moveBG;

extern BOOL afterJump;
extern BOOL afterSwim;

extern BOOL isMistake;

//#endif // __GAME_CONFIG_H

