// Piotr Bogdan
// projekt APIOS

#import "AbstractScene.h"

@implementation AbstractScene


- (void)renderScene: (NSMutableArray*) blkArr {
    GLfloat squareVertices[8];
    GLubyte *squareColors[16];
    
    for (id block in blkArr) {
        [block getRenderVertices: squareVertices];
        [block getColorMatrix: squareColors];
        
        glVertexPointer(2, GL_FLOAT, 0, squareVertices);
        glColorPointer(4, GL_UNSIGNED_BYTE, 0, squareColors);
        
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    }
	
}
    
@end