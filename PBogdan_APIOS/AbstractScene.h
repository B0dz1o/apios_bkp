// Piotr Bogdan
// projekt APIOS

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface AbstractScene : NSObject 

- (void)renderScene: (NSMutableArray*) blkArr;
- (void) renderRed;
- (void)updateScene;


@end
