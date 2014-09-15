// Piotr Bogdan
// Projekt APIOS

#import "Ball.h"

@implementation Ball

-(void) moveDirection:(CGFloat)direction
{
    if (lR == RIGHT) {
        blockCenterPosition.x += 5;
    } else if (lR == LEFT){
        blockCenterPosition.x -= 5;
    }
    
    if (blockCenterPosition.x < blockWidth/2){
        blockCenterPosition.x = blockWidth/2;
        if(lR == RIGHT)
            lR = LEFT;
        else
            lR = RIGHT;
    }
    else if (blockCenterPosition.x > 320 - blockWidth/2){
        blockCenterPosition.x = 320 - blockWidth/2;
        if(lR == RIGHT)
            lR = LEFT;
        else
            lR = RIGHT;
    }
}

-(void) moveVertical
{
    if (uD == UP)
        blockCenterPosition.y += 5;
    else
        blockCenterPosition.y -=5;
}

-(void) turnVertical
{
    if (uD == UP)
        uD = DOWN;
    else
        uD = UP;
}

-(void) getRenderVertices: (GLfloat[]) target {
    GLfloat temp[] = {
        blockCenterPosition.x - blockWidth/2, blockCenterPosition.y,
        blockCenterPosition.x, blockCenterPosition.y - blockHeight/2,
        blockCenterPosition.x, blockCenterPosition.y + blockHeight/2,
        blockCenterPosition.x + blockWidth/2, blockCenterPosition.y,
    };
    for (int i = 0; i<8; ++i){
        target[i] = temp[i];
    }
}

-(void) getColorMatrix: (GLubyte[]) target {
    GLubyte sunset[] = {
        0, 0, 0, 255,
        0, 0, 0, 255,
        0, 0, 0, 255,
        0, 0, 0, 255,
    };
    for (int i = 0; i<16; ++i){
        target[i] = sunset[i];
    }
}

-(id) initWithHeight: (CGFloat) height
               Width: (CGFloat) width
            Position: (CGPoint) pos
{
    if (self = [super init]){
        blockHeight = height;
        blockWidth = width;
        blockCenterPosition = pos;
        lR = RIGHT;
        uD = UP;
    }
    return self;
}
-(void) checkCollision:(AbstractBlock*)blk {
    if (abs( [self getX] - [blk getX] ) < 50 ){
        CGFloat selfY = [self getY];
        CGFloat blkY = [blk getY];
        if (uD == UP && selfY < blkY && (blkY - selfY) < 10 ){
            [self turnVertical];
            [blk collision];
        } else if (uD == DOWN && selfY > blkY && (selfY - blkY) < 10) {
            [self turnVertical];
            [blk collision];
        }
    }
}

@end
