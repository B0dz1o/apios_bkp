// Piotr Bogdan
// Projekt APIOS

#import "AbstractBlock.h"

@implementation AbstractBlock

-(void) moveDirection:(CGFloat)direction {}//for overriding

-(void) getRenderVertices: (GLfloat[]) target {
    GLfloat temp[] = {

        blockCenterPosition.x - blockWidth/2, blockCenterPosition.y - blockHeight/2,
        blockCenterPosition.x + blockWidth/2, blockCenterPosition.y - blockHeight/2,
        blockCenterPosition.x - blockWidth/2, blockCenterPosition.y + blockHeight/2,
        blockCenterPosition.x + blockWidth/2, blockCenterPosition.y + blockHeight/2,
    };
    for (int i = 0; i<8; ++i){
        target[i] = temp[i];
    }

}

-(void) getColorMatrix:(GLubyte [])target {} //for overriding

-(id) initWithHeight: (CGFloat) height
               Width: (CGFloat) width
            Position: (CGPoint) pos
{
    if (self = [super init]){
        blockHeight = height;
        blockWidth = width;
        blockCenterPosition = pos;
    }
    return self;
}
-(CGFloat) getX{
    return blockCenterPosition.x;
}
-(CGFloat) getY {
    return blockCenterPosition.y;
}
-(BOOL) isDestroyed{
    return NO; //default behaviour
}
-(void) collision {}; //for overriding
-(void) setHeight: (CGFloat) height
               Width: (CGFloat) width
            Position: (CGPoint) pos
{
        blockHeight = height;
        blockWidth = width;
        blockCenterPosition = pos;
}
@end
