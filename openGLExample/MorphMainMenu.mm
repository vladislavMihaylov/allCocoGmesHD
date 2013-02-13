//
//  HelloWorldLayer.m
//  testApp
//
//  Created by Mac on 17.09.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "MorphMainMenu.h"
#import "MorphCommon.h"
#import "MorphGameLayer.h"
#import "SimpleAudioEngine.h"
//#import "Coco.h"

#import "MorphGameConfig.h"
#import "Tutorial.h"

// HelloWorldLayer implementation
@implementation MorphMainMenu
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
    
	MorphMainMenu *layer = [MorphMainMenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

- (void) dealloc
{
	[super dealloc];
}

-(id) init
{
	if( (self=[super init]))
    {
        CCSprite *bg = [CCSprite spriteWithFile: @"morphBgJPG.jpg"];
        bg.position = ccp(240, 160);
        [self addChild: bg];
        
        CCMenuItemImage *cocoBtn = [CCMenuItemImage itemFromNormalImage: @"PlayWithCocoBtn.png"
                                                          selectedImage: @"PlayWithCocoBtnTap.png"
                                                                 target: self
                                                               selector: @selector(play:)
                                    ];
        
        cocoBtn.position = ccp(120, 160);
        cocoBtn.tag = 0;
        
        CCMenuItemImage *francoisBtn = [CCMenuItemImage itemFromNormalImage: @"PlayWithFrancoisBtn.png"
                                                              selectedImage: @"PlayWithFrancoisBtnTap.png"
                                                                     target: self
                                                                   selector: @selector(play:)
                                        ];
        
        francoisBtn.position = ccp(360, 160);
        francoisBtn.tag = 1;
        
        CCMenu *heroMenu = [CCMenu menuWithItems: cocoBtn, francoisBtn, nil];
        heroMenu.position = ccp(0,0);
        [self addChild: heroMenu];
        
	}
	return self;
}

- (void) play: (CCMenuItemFont *) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"tap.mp3"];
    typeCharacter = sender.tag;
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: [Tutorial scene]]];
}


@end
