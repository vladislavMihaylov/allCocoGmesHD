//
//  Coco.m
//  openGLExample
//
//  Created by Mac on 31.07.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Coco.h"
#import "GameConfig.h"

#define SJ_PI 3.14159265359f
#define SJ_DEG2RAD SJ_PI/180.0f
#define SJ_RAD2DEG 180.0f/SJ_PI

@implementation Coco

@synthesize hookSprite;
@synthesize hook;
@synthesize point;
@synthesize gameLayer;

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithWorld: (b2World *) world
{
    if((self = [super init]))
    {
    
        self.isTouchEnabled = YES;
        
        ////////////////////////// создаем точку на лодке, к которой будет прикреплена леска
        
        myWorld = world;
        
        pointDef.type = b2_staticBody;
        pointDef.position.Set(7.5f, 8.7f);
        
        point = world->CreateBody(&pointDef);
        
        pointShape.m_radius = 0.1f;
        pointFixtureDef.shape = &pointShape;
        point->CreateFixture(&pointFixtureDef);
        
        
        ////////////////////////// делаем крючок
        
        
        hookSprite = [CCSprite spriteWithFile: @"hook.png"];
        hookSprite.scale = 0.4;
        [self addChild: hookSprite];
        
        hookDef.type = b2_dynamicBody;
        hookDef.position.Set(5.5f, 1.0f);
        hookDef.linearDamping = 0.1;
        hookDef.userData = hookSprite;
        
        hook = world->CreateBody(&hookDef);
        
        hookShape.m_radius = 0.25;
        
        hookFixture.shape = &hookShape;
        hookFixture.density = 1.0;
        
        hook->CreateFixture(&hookFixture);
        
        
        /////////////////////////
        
        [self createChairWithAnchor: point andHook: hook andWorld: world];
        
        /////////////////////////
        
        boatSprite = [CCSprite spriteWithFile: @"boat.png"];
        boatSprite.scale = 0.9;
        boatSprite.position = ccp(GameCenterX + 77, GameHeight - 47);
        [self addChild: boatSprite z: 0];
        
        rodSprite = [CCSprite spriteWithFile: @"rod.png"];
        rodSprite.scale = 0.9;
        rodSprite.anchorPoint = ccp(1, 0.5);
        rodSprite.position = ccp(GameCenterX + 70, GameHeight - 60);
        [self addChild: rodSprite];
        
        [self runAction: 
                        [CCRepeatForever actionWithAction: 
                                                    [CCSequence actions: 
                                                                    [CCMoveTo actionWithDuration: 1.0 
                                                                                        position: ccp(self.position.x, self.position.y - 2)], 
                                                                    [CCMoveTo actionWithDuration: 1.0 
                                                                                        position: ccp(self.position.x, self.position.y + 2)], 
                                                     nil]
                         ]
         ];
        
        UDILIWE = [CCSprite spriteWithFile: @"Icon-Small.png"];
        UDILIWE.position = ccp(5, 38);
        [UDILIWE setOpacity: 0];
        [rodSprite addChild: UDILIWE];

        
    }
    
    return self;
}




+ (Coco *) createWithWorld: (b2World *) world
{
    Coco * coco = [[[Coco alloc] initWithWorld: world] autorelease];
    
    return coco;
}

- (void) createChairWithAnchor: (b2Body *) anchorBody andHook: (b2Body *) hookBody andWorld: (b2World *) world
{
    /*b2Vec2 anchorPos = anchorBody->GetPosition();
    b2Vec2 hookPos = hookBody->GetPosition();
    float x = anchorPos.y - hookPos.y;
    x += 3;
    CCLOG(@"distance: %f", x);
    
    for (int i = 0; i < x; i++)
    {
        
        if(i == 0)
        {
            element = point;
            
            elements.push_back(element);
            
            //////
            
            element2Def.type = b2_dynamicBody;
            element2Def.position.Set(5.0, anchorPos.y - 0.45 - i); 
            
            element2 = world->CreateBody(&element2Def);
            
            element2Shape.SetAsBox(0.1, 0.5);
            element2Fixture.density = 1.0;
            
            element2Fixture.shape = &element2Shape;
            
            element2->CreateFixture(&element2Fixture);
            
            elements.push_back(element2);
            
            *****************************************
            
            b2RevoluteJointDef revolJointDef;
            revolJointDef.Initialize(element, element2, element->GetWorldCenter());
            
            revolJointDef.localAnchorA = b2Vec2(0.0, - 0.6);
            revolJointDef.localAnchorB = b2Vec2(0.0, 0.45);
            revolJointDef.lowerAngle = -0.5;
            revolJointDef.upperAngle = 0.5;
            revolJointDef.enableLimit = false;
            //revolJointDef.maxMotorTorque = 10.0f;
            revolJointDef.motorSpeed = 0.0f;
            revolJointDef.enableMotor = true;
            
            world->CreateJoint(&revolJointDef);
            
            element = element2;
        }
        
        else if (i == x - 1)
        {
            element2 = hook;
            
            //elements.push_back(element2);
            
            b2RevoluteJointDef revolJointDef;
            revolJointDef.Initialize(element, element2, element->GetWorldCenter());
            
            revolJointDef.localAnchorA = b2Vec2(0.0, - 0.45);
            revolJointDef.localAnchorB = b2Vec2(0.0, 0.45);
            revolJointDef.lowerAngle = -0.5;
            revolJointDef.upperAngle = 0.5;
            revolJointDef.enableLimit = false;
            //revolJointDef.maxMotorTorque = 10.0f;
            revolJointDef.motorSpeed = 0.0f;
            revolJointDef.enableMotor = true;
            
            world->CreateJoint(&revolJointDef);
        }
        
        else
        {
            element2Def.type = b2_dynamicBody;
            element2Def.position.Set(5.0, anchorPos.y - 0.45- i); 
            
            element2 = world->CreateBody(&element2Def);
            
            element2Shape.SetAsBox(0.1, 0.5);
            element2Fixture.density = 0.5;
            
            element2Fixture.shape = &element2Shape;
            
            element2->CreateFixture(&element2Fixture);
            
            elements.push_back(element2);
            
            *****************************************
            
            b2RevoluteJointDef revolJointDef;
            revolJointDef.Initialize(element, element2, element->GetWorldCenter());
            
            revolJointDef.localAnchorA = b2Vec2(0.0, - 0.45);
            revolJointDef.localAnchorB = b2Vec2(0.0, 0.45);
            revolJointDef.lowerAngle = -0.5;
            revolJointDef.upperAngle = 0.5;
            revolJointDef.enableLimit = false;
            //revolJointDef.maxMotorTorque = 10.0f;
            revolJointDef.motorSpeed = 0.0f;
            revolJointDef.enableMotor = true;
            
            world->CreateJoint(&revolJointDef);
            
            element = element2;
        }
    }*/
    
    b2Vec2 anchorPos = anchorBody->GetPosition();
    b2Vec2 hookPos = hookBody->GetPosition();
    float x = anchorPos.y - hookPos.y;
    //x -= 5;
    x = 20;
    CCLOG(@"distance: %f", x);
    
    for (int i = 0; i < x; i++)
    {
        
        if(i == 0)
        {
            element = point;
            
            elements.push_back(element);
            
            //////
            
            
            element2Def.type = b2_dynamicBody;
            element2Def.position.Set(7.5, anchorPos.y - 0.2 * i); 
            
            element2 = world->CreateBody(&element2Def);
            
            element2Shape.m_radius = 0.2;
            element2Fixture.density = 1.0;
            
            element2Fixture.shape = &element2Shape;
            
            element2->CreateFixture(&element2Fixture);
            
            elements.push_back(element2);
            
            //////////////////
            
            
            
            /*b2DistanceJointDef distJointDef;
            distJointDef.Initialize(element, element2, element->GetPosition(), element2->GetPosition());
            distJointDef.collideConnected = true;
            world->CreateJoint(&distJointDef);*/
            
            b2RevoluteJointDef revolJointDef;
            revolJointDef.Initialize(element, element2, element->GetWorldCenter());
            
            revolJointDef.localAnchorA = b2Vec2(0, 0);
            revolJointDef.localAnchorB = b2Vec2(0, 0);
            revolJointDef.lowerAngle = -0.5;
            revolJointDef.upperAngle = 0.5;
            revolJointDef.enableLimit = false;
            revolJointDef.collideConnected = false;
            revolJointDef.motorSpeed = 0.0f;
            revolJointDef.enableMotor = true;
            
            world->CreateJoint(&revolJointDef);
            
            element = element2;
        }
        
       else if (i == x - 1)
        {
            element2 = hook;
            
            //elements.push_back(element2);
            
            b2DistanceJointDef distJointDef;
            distJointDef.Initialize(element, element2, element->GetPosition(), element2->GetPosition());
            distJointDef.collideConnected = true;
            world->CreateJoint(&distJointDef);
            
            b2RevoluteJointDef revolJointDef;
            revolJointDef.Initialize(element, element2, element->GetWorldCenter());
            
            revolJointDef.localAnchorA = b2Vec2(0, 0);
            revolJointDef.localAnchorB = b2Vec2(0, 0.2);
            revolJointDef.lowerAngle = -0.5;
            revolJointDef.upperAngle = 0.5;
            revolJointDef.enableLimit = false;
            revolJointDef.collideConnected = NO;
            revolJointDef.motorSpeed = 0.0f;
            revolJointDef.enableMotor = true;
            
            world->CreateJoint(&revolJointDef);
        }
        
        else
        {
            element2Def.type = b2_dynamicBody;
            element2Def.position.Set(7.5, anchorPos.y - 0.4 * i); 
            
            element2 = world->CreateBody(&element2Def);
            
            element2Shape.m_radius = 0.2;
            element2Fixture.density = 0.5;
            
            element2Fixture.shape = &element2Shape;
            
            element2->CreateFixture(&element2Fixture);
            
            elements.push_back(element2);
            
            ///////////////

            
            b2DistanceJointDef distJointDef;
            distJointDef.Initialize(element, element2, element->GetPosition(), element2->GetPosition());
            distJointDef.collideConnected = false;
            //distJointDef.dampingRatio = 0.5f;
            world->CreateJoint(&distJointDef);
            
            /*b2RevoluteJointDef revolJointDef;
            revolJointDef.Initialize(element, element2, element->GetWorldCenter());
            
            revolJointDef.localAnchorA = b2Vec2(0, 0);
            revolJointDef.localAnchorB = b2Vec2(0, 0);
            revolJointDef.lowerAngle = -0.5;
            revolJointDef.upperAngle = 0.5;
            revolJointDef.enableLimit = false;
            revolJointDef.motorSpeed = 0.0f;
            revolJointDef.enableMotor = true;
            revolJointDef.collideConnected = false;
            
            world->CreateJoint(&revolJointDef);*/
            
            element = element2;
        }
    }
}

- (void) draw
{
    
    vector<b2Body *>::iterator startIterator;
    
    GLfloat vertices[elements.size() * 2];
    
    CGPoint convertedPoint = [rodSprite convertToWorldSpace: UDILIWE.position];
    
    for(int i = 0; i < elements.size() ; i++)
    {
        
        startIterator = elements.begin();
        
        b2Body *currentBody = elements[i];
        
        CGPoint pointA = ccp(currentBody->GetJointList()->joint->GetAnchorA().x * PTM_RATIO, currentBody->GetJointList()->joint->GetAnchorA().y * PTM_RATIO);
        
        if(i != 0 )
        {
            vertices[i * 2] = pointA.x;
            vertices[i * 2 + 1] = pointA.y;
        }
        else 
        {
           vertices[0] = convertedPoint.x;
           vertices[1] = convertedPoint.y;
        }
    }    
    
    float rodAngle = hookSprite.position.y / 8;
    
    [rodSprite setRotation: rodAngle];
    
    b2Vec2 transformPoint;
    
    transformPoint = b2Vec2(convertedPoint.x / 32, convertedPoint.y / 32);
    
    point->SetTransform(transformPoint, 0);
    
    GLubyte squareColors[elements.size() * 4];
    
    for (int i = 0; i < (elements.size() * 4) - 1; i += 4)
    {
        squareColors[i] = 170;
        squareColors[i + 1] = 170;
        squareColors[i + 2] = 170;
        squareColors[i + 3] = 225;
    }
    
    
    
    glDisable(GL_TEXTURE_2D);
    
    BOOL colorArrayEnabled = glIsEnabled(GL_COLOR_ARRAY);
    
    if(!colorArrayEnabled)
    {
        glEnableClientState(GL_COLOR_ARRAY);
    }
    
    BOOL vertexArrayEnabled = glIsEnabled(GL_VERTEX_ARRAY);
    
    if(!vertexArrayEnabled)
    {
        glEnableClientState(GL_VERTEX_ARRAY);
    }
    
    glLineWidth(3.0f);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, squareColors);
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glDrawArrays(GL_LINE_STRIP, 0, elements.size());
    
    
    if(!vertexArrayEnabled)
    {
        glDisableClientState(GL_VERTEX_ARRAY);
    }
    
    if(!colorArrayEnabled)
    {
        glDisableVertexAttribArray(GL_COLOR_ARRAY);
    }
    
    glEnable(GL_TEXTURE_2D);
}

- (void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate: self priority: 0 swallowsTouches: YES];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInView: [touch view]];    
    location = [[CCDirector sharedDirector] convertToGL: location];
    
    //if (_mouseJoint != NULL) return YES;
    
    [gameLayer checkChestCollision: (CGPoint) location];
    [gameLayer checkCoinCollision: (CGPoint) location];
    
    b2Vec2 hookPosition;
    hookPosition = hook->GetPosition();
    
    if ( (abs(location.x - hookSprite.position.x) < 100) && (abs(location.y - hookSprite.position.y) < 100) )
    {
        b2Vec2 locationWorld = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
        
        b2MouseJointDef md;
        md.bodyA = point;
        md.bodyB = hook;
        md.target = locationWorld;
        md.collideConnected = true;
        md.maxForce = 10000.0f * hook->GetMass();
        
        _mouseJoint = (b2MouseJoint *)myWorld->CreateJoint(&md);
        hook->SetAwake(true);
        
        //IsHookActive = YES;
    }
    //pointDef.position.Set(location.x / 32, location.y / 32);
    //    pos1 = pos2;
    //    pos2 = CGPointMake(location.x, location.y);
    //    [myLine setPoints: pos1 andPoint2: (CGPoint) pos2];
    
    return YES;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    
    CGPoint location = [touch locationInView: [touch view]];    
    location = [[CCDirector sharedDirector] convertToGL: location];
    
    if (_mouseJoint == NULL) return;
    
    b2Vec2 locationWorld = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
    
    _mouseJoint->SetTarget(locationWorld);
    
}

-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_mouseJoint) {
        myWorld->DestroyJoint(_mouseJoint);
        _mouseJoint = NULL;
    }
    
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    if (_mouseJoint) {
        myWorld->DestroyJoint(_mouseJoint);
        _mouseJoint = NULL;
    }
    
    
}



@end
