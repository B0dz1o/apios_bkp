// Piotr Bogdan
// Projekt APIOS

#import "PlayerPong.h"

@implementation PlayerPong

-(void) moveDirection: (CGFloat) direction{
    if (direction > 0)
        blockCenterPosition.x += 4.5;
    else if (direction < 0)
        blockCenterPosition.x -= 4.5;
    if (blockCenterPosition.x < blockWidth/2)
        blockCenterPosition.x = blockWidth/2;
    else if (blockCenterPosition.x > 320 - blockWidth/2)
        blockCenterPosition.x = 320 - blockWidth/2;
}
-(void) getColorMatrix: (GLubyte[]) target {
    GLubyte sunset[] = {
        255, 255, 0, 255,
        255, 0, 255, 255,
        255, 255, 0, 0,
        0, 255, 0, 255,
    };
    for (int i = 0; i<16; ++i){
        target[i] = sunset[i];
    }
}

@end
