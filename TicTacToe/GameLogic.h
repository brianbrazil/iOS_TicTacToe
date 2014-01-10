#import <Foundation/Foundation.h>

@class Square;


@interface GameLogic : NSObject

@property (nonatomic,readonly) BOOL hasWinner;
@property (nonatomic,readonly) BOOL isDraw;
@property (nonatomic,readonly) NSArray* winningSquares;

- (void)setSquare:(Square*)square forX:(NSInteger)x Y:(NSInteger)y;

- (void)playerChooses:(Square*)square;
- (void)chooseForComputer;

- (void)reset;

@end