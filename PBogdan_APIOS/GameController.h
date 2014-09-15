// Piotr Bogdan
// projekt APIOS


#import <OpenGLES/ES1/gl.h>
#import "Obstacle.h"
#import "PlayerPong.h"
#import "Ball.h"

@class AbstractScene;

static const int screenWidth = 320;
static const int screenHeight = 480;

@interface GameController : NSObject {
    AbstractScene *currentScene;
    @private
    CGPoint startGesture, endGesture;
    Ball *mainBall;
    PlayerPong *playerP;
    PlayerPong *enemyP;
    NSMutableArray *blockArray;
}

@property (nonatomic, retain) AbstractScene *currentScene;


+ (GameController *)sharedGameController;

- (void)updateCurrentScene;

- (void)renderCurrentScene;

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView;
- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView;

-(void) reset;


@end
