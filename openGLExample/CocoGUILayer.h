//
//  GUILayer.h
//  catchCoco
//
//  Created by Mac on 15.04.12.
//  Copyright 2012 spotGames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class CocoGameLayer;

@interface CocoGUILayer: CCLayer {
    
    CocoGameLayer *cocoGameLayer;
    
    CCLayerColor *shadow;
    
    CCLabelBMFont *cocoLabel;
    
}

@property (nonatomic, assign) CocoGameLayer *cocoGameLayer;

- (void) formatCocoString: (NSInteger)cocoNumber;
- (void) ShowGameOverLabel;

@end
