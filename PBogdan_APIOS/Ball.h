// Piotr Bogdan
// Projekt APIOS

#import "AbstractBlock.h"

enum upDown {UP, DOWN};
enum leftRight {LEFT, RIGHT};

@interface Ball : AbstractBlock
{
    @private
    enum upDown uD;
    enum leftRight lR;
}
-(void) moveVertical;
-(void) turnVertical;
-(void) checkCollision: (AbstractBlock*) blk;

@end
