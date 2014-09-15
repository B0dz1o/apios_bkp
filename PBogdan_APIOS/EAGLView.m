// Piotr Bogdan
// projekt APIOS


#import "EAGLView.h"
#import "ES1Renderer.h"
#import "GameController.h"
#import "AbstractScene.h"

@implementation EAGLView

@synthesize animating;
@dynamic animationFrameInterval;

+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

- (id) initWithCoder:(NSCoder*)coder
{    
	if ((self = [super initWithCoder:coder]))
	{
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, 
                                        kEAGLColorFormatRGB565, kEAGLDrawablePropertyColorFormat, nil];
		
        renderer = [[ES1Renderer alloc] init];
        
        if (!renderer)
        {
            [self release];
            return nil;
        }
        
		animating = FALSE;

		animationFrameInterval = 1;
		displayLink = nil;
		
        sharedGameController = [GameController sharedGameController];
    }
	
    return self;
}


#define MAXIMUM_FRAME_RATE 45
#define MINIMUM_FRAME_RATE 15
#define UPDATE_INTERVAL (1.0 / MAXIMUM_FRAME_RATE)
#define MAX_CYCLES_PER_FRAME (MAXIMUM_FRAME_RATE / MINIMUM_FRAME_RATE)

- (void)gameLoop {
	
	static double lastFrameTime = 0.0f;
	static double cyclesLeftOver = 0.0f;
	double currentTime;
	double updateIterations;
	
	currentTime = CACurrentMediaTime();
	updateIterations = ((currentTime - lastFrameTime) + cyclesLeftOver);
	
	if(updateIterations > (MAX_CYCLES_PER_FRAME * UPDATE_INTERVAL))
		updateIterations = (MAX_CYCLES_PER_FRAME * UPDATE_INTERVAL);

	while (updateIterations >= UPDATE_INTERVAL) {
		updateIterations -= UPDATE_INTERVAL;
		
		[sharedGameController updateCurrentScene];		
	}
	
	cyclesLeftOver = updateIterations;
	lastFrameTime = currentTime;
	
    [self drawView:nil];
}

- (void) drawView:(id)sender
{
    [renderer render];
}

- (void) layoutSubviews
{
	[renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
    [self drawView:nil];
}

- (NSInteger) animationFrameInterval
{
	return animationFrameInterval;
}

- (void) setAnimationFrameInterval:(NSInteger)frameInterval
{
	if (frameInterval >= 1)
	{
		animationFrameInterval = frameInterval;
		
		if (animating)
		{
			[self stopAnimation];
			[self startAnimation];
		}
	}
}

- (void) startAnimation
{
	if (!animating)
	{
		displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(gameLoop)];
		[displayLink setFrameInterval:animationFrameInterval];
		[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		animating = TRUE;
		lastTime = CFAbsoluteTimeGetCurrent();
	}
}

- (void)stopAnimation
{
	if (animating)
	{
		[displayLink invalidate];
		displayLink = nil;		
		animating = FALSE;
	}
}

- (void) dealloc
{
    [renderer release];
	
    [super dealloc];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {    
	[sharedGameController touchesBegan:touches withEvent:event view:self];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	[sharedGameController touchesMoved:touches withEvent:event view:self];
}

@end
