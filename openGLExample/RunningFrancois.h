

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "AnimationNode.h"

@interface RunningFrancois : CCNode
{
    AnimationNode *body;
    AnimationNode *panzer;
    AnimationNode *leftEye;
    AnimationNode *rightEye;
    
    float currentSpeed;
}

@property (nonatomic, assign) AnimationNode *body;

+ (RunningFrancois *) createWithSpeed: (float) speed;
- (void) increaseSpeed;
- (void) setSpeed: (float) speedParam;
- (float) getCurrentCocoSpeed;
- (void) showTransitionAnimation;
- (void) setNormalOrientation;
- (void) doUnvisible;
- (void) doVisible;
- (void) hide;
- (void) show;
- (void) jumpFromMountain;
- (void) setLastYPosition;
- (void) pauseAllActions;
- (void) unPauseAllActions;

- (void) setFinishZZ;

- (void) reorderTo: (NSInteger) order;


@end
