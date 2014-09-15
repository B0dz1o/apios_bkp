// Piotr Bogdan
// projekt APIOS

#import "ES1Renderer.h"
#import "GameController.h"

@implementation ES1Renderer


- (id) init {
	if (self = [super init])
	{
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context])
		{
            [self release];
            return nil;
        }
		

		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
        
        sharedGameController = [GameController sharedGameController];
	}
	
	return self;
}

- (void) render {

    glClear(GL_COLOR_BUFFER_BIT);

    [sharedGameController renderCurrentScene];
    
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer {	
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
	[self initOpenGL];
	
    return YES;
}

- (void) dealloc {
	if (defaultFramebuffer)
	{
		glDeleteFramebuffersOES(1, &defaultFramebuffer);
		defaultFramebuffer = 0;
	}

	if (colorRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &colorRenderbuffer);
		colorRenderbuffer = 0;
	}
	
	if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
	[context release];
	context = nil;
	
	[super dealloc];
}

- (void)initOpenGL {
	
    NSLog(@"INFO - ES1Renderer: Initializing OpenGL");
    
	glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
	glOrthof(0, backingWidth, 0, backingHeight, -1, 1);
	
    glViewport(0, 0, backingWidth , backingHeight);
    
    NSLog(@"INFO - ES1Renderer: Setting glOrthof to width=%d and height=%d", backingWidth, backingHeight);
    
	glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
	glClearColor(1.0f, 1.0f, 1.0f, 1.0f);    

	glDisable(GL_DEPTH_TEST);
    
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
}

@end

