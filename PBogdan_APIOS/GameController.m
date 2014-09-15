// Piotr Bogdan
// projekt APIOS

#import "GameController.h"
#import "AbstractScene.h"



@implementation GameController

@synthesize currentScene;

static GameController *sharedGameController = nil;

+ (GameController *)sharedGameController {
    @synchronized(self) {
		if (sharedGameController == nil) {
			sharedGameController = [[self alloc] init];
		}
	}
	return sharedGameController;
}
+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedGameController == nil) {
			sharedGameController = [super allocWithZone:zone];
			return sharedGameController;
		}
	}
	return nil;
}
- (id)copyWithZone:(NSZone *)zone {
	return self;
}
- (id)retain {
	return self;
}
- (NSUInteger)retainCount {
	return NSUIntegerMax;
}

- (id)autorelease {
	return self;
};

- (void)dealloc {
    [blockArray release];
    [currentScene release];
    [playerP release];
    [enemyP release];
    [mainBall release];
    [super dealloc];
}



- (id)init {
    self = [super init];
    if(self != nil) {
		currentScene = nil;
        [self initGame];
    }
    return self;
}

- (void)updateCurrentScene {
    [playerP moveDirection: (CGFloat) endGesture.x - startGesture.x];
    [mainBall moveDirection: 0.0f];
    [mainBall moveVertical];
    CGFloat enemyDirection = 1.0f;
    if ([mainBall getX] < [enemyP getX])
        enemyDirection = -1.0f;
    [enemyP moveDirection:enemyDirection];
    for (int i = 1; i < [blockArray count]; ++i)
        [mainBall checkCollision: [blockArray objectAtIndex: i]];
    if ([mainBall getY] < 0 || [mainBall getY] > 480)
        [self reset];
}

-(void)renderCurrentScene {
    [currentScene renderScene: blockArray];
}

- (void)initGame {
    
    NSLog(@"INFO - GameController: Starting game initialization.");
	currentScene = [[AbstractScene alloc] init];
    playerP = [[PlayerPong alloc] initWithHeight: (CGFloat) screenHeight/25
                                           Width: (CGFloat) screenWidth/5
                                        Position: CGPointMake(screenWidth/2, 0.05f * screenHeight)];
    enemyP = [[PlayerPong alloc] initWithHeight: (CGFloat) screenHeight/25
                                          Width: (CGFloat) screenWidth/5
                                       Position: CGPointMake(screenWidth/2, 0.95f * screenHeight)];
    mainBall = [[Ball alloc] initWithHeight: (CGFloat) screenHeight/25
                                      Width: (CGFloat) screenWidth/20
                                   Position: CGPointMake(screenWidth/2, 0.1f * screenHeight)];
    blockArray = [[NSMutableArray alloc] initWithCapacity:5];
    [blockArray addObject: mainBall];
    [blockArray addObject: playerP];
    [blockArray addObject: enemyP];
    NSLog(@"INFO - GameController: Finished game initialization.");
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView {
    startGesture = [[touches anyObject] locationInView:aView];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView {
    endGesture = [[touches anyObject] locationInView:aView];
}
-(void) reset {
    [playerP setHeight: (CGFloat) screenHeight/25
                 Width: (CGFloat) screenWidth/5
              Position: CGPointMake(screenWidth/2, 0.05f * screenHeight)];
    [enemyP setHeight: (CGFloat) screenHeight/25
                Width: (CGFloat) screenWidth/5
             Position: CGPointMake(screenWidth/2, 0.95f * screenHeight)];
    [mainBall setHeight: (CGFloat) screenHeight/25
                  Width: (CGFloat) screenWidth/20
               Position: CGPointMake(screenWidth/2, 0.1f * screenHeight)];
    usleep(500000);
}


@end

