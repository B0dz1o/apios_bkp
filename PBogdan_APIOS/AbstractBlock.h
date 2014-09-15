// Piotr Bogdan
// Projekt APIOS

#import <Foundation/Foundation.h>

@interface AbstractBlock : NSObject
{
    @protected
    CGPoint blockCenterPosition;
    CGFloat blockWidth, blockHeight;
}
-(void) moveDirection: (CGFloat) direction;
-(void) getRenderVertices: (GLfloat[]) target;
-(void) getColorMatrix: (GLubyte[]) target;
-(id) initWithHeight: (CGFloat) height
               Width: (CGFloat) width
            Position: (CGPoint) pos;
-(CGFloat) getX;
-(CGFloat) getY;
-(BOOL) isDestroyed;
-(void) collision;
-(void) setHeight: (CGFloat) height
               Width: (CGFloat) width
            Position: (CGPoint) pos;
@end
