//
//  Line.h
//  openGLExample
//
//  Created by Mac on 25.07.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Line :CCNode 
{
    GLfloat vertices[4];
    GLubyte squareColors[12];
}

- (void) setPoints: (CGPoint) Point1 andPoint2: (CGPoint) Point2;

@end
