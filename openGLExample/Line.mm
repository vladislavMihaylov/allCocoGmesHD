//
//  Line.m
//  openGLExample
//
//  Created by Mac on 25.07.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Line.h"
#import "GameLayer.h"

@implementation Line

- (void) setPoints: (CGPoint) Point1 andPoint2: (CGPoint) Point2
{
    vertices[0] = Point1.x;
    vertices[1] = Point1.y;
    vertices[2] = Point2.x;
    vertices[3] = Point2.y;
}

- (void) draw
{

    
    squareColors[0] = 255;
    squareColors[1] = 0;
    squareColors[2] = 0;
    squareColors[3] = 255;
    squareColors[4] = 255;
    squareColors[5] = 0;
    squareColors[6] = 0;
    squareColors[7] = 255;
    squareColors[8] = 255;
    squareColors[9] = 0;
    squareColors[10] = 0;
    squareColors[11] = 255;
    
    const GLfloat triangleVertices[] = 
    {
        0.0, 0.0, 0.0,
        100.0, 0.0, 0.0,
        0.0, 100.0, 0.0
    };
    
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
    
//    glLineWidth(6.0f);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, squareColors);
//    glVertexPointer(2, GL_FLOAT, 0, vertices);
//    glDrawArrays(GL_LINE_LOOP, 0, 2);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glVertexPointer(3, GL_FLOAT, 0, triangleVertices);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
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

@end
