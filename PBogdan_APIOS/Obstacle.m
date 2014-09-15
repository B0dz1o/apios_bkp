// Piotr Bogdan
// Projekt APIOS

#import "Obstacle.h"

@implementation Obstacle

-(void) moveDirection:(CGFloat)direction{} //not supposed to move
-(void) getColorMatrix: (GLubyte[]) target {
    GLubyte sunset[] = {
        255, 0, 0, 255,
        255, 0, 0, 255,
        255, 255, 0, 0,
        255, 0, 0, 255,
    };
    for (int i = 0; i<16; ++i){
        target[i] = sunset[i];
    }
}
-(id) initWithHeight: (CGFloat) height
               Width: (CGFloat) width
            Position: (CGPoint) pos
{
    if (self = [super init]){
        blockHeight = height;
        blockWidth = width;
        blockCenterPosition = pos;
        destroyed = NO;
    }
    return self;
}
-(void) collision {
    destroyed = YES;
}
-(BOOL) isDestroyed {
    return destroyed;
}

@end
