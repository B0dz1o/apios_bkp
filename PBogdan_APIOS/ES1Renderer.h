// Piotr Bogdan
// projekt APIOS

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "ES1Renderer.h"
#import <QuartzCore/QuartzCore.h>

@class GameController;

@interface ES1Renderer : NSObject
{
@private
	EAGLContext *context;
	
	GLint backingWidth;
	GLint backingHeight;
	
	GLuint defaultFramebuffer, colorRenderbuffer;

    GameController *sharedGameController;
}

- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;
- (void)initOpenGL;

@end
