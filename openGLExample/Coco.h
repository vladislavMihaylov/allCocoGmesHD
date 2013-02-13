//
//  Coco.h
//  openGLExample
//
//  Created by Mac on 31.07.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#import <vector>

using namespace std;

@class  GameLayer;

@interface Coco: CCLayer
{
    b2World *myWorld;
    
    b2Body *point;                   
    b2BodyDef pointDef;
    b2CircleShape pointShape;
    b2FixtureDef pointFixtureDef;
    
    b2Body *hook;                    
    b2BodyDef hookDef;
    b2CircleShape hookShape;
    b2FixtureDef hookFixture;
    
    b2Body *element;                 
    b2BodyDef elementDef;
    b2CircleShape elementShape;
    b2FixtureDef elementFixture;
    
    b2Body *element2;
    b2BodyDef element2Def;
    b2CircleShape element2Shape;
    b2FixtureDef element2Fixture;
    
    vector <b2Body *> elements;
    
    CCSprite *hookSprite;
    CCSprite *boatSprite;
    CCSprite *rodSprite;
    CCSprite *UDILIWE;
    
    b2MouseJoint *_mouseJoint;
}

- (id) initWithWorld: (b2World *) world;

+ (Coco *) createWithWorld: (b2World *) world;

- (void) createChairWithAnchor: (b2Body *) anchorBody andHook: (b2Body *) hookBody andWorld: (b2World *) world;

@property (nonatomic, assign) CCSprite *hookSprite;
@property (nonatomic, assign) b2Body *hook;
@property (nonatomic, assign) b2Body *point;
@property (nonatomic, assign) GameLayer *gameLayer;

@end
