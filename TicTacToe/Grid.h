#import <Foundation/Foundation.h>

@class Square;


@interface Grid : NSObject

@property (nonatomic,readonly) NSInteger size;
@property (nonatomic,readonly) NSArray* allSquares;
@property (nonatomic,readonly) NSArray* emptySquares;
@property (nonatomic,readonly) NSArray* cornerSquares;
@property (nonatomic,readonly) Square* centerSquare;

- (Square*)squareForX:(NSInteger)x Y:(NSInteger)y;
- (void)setSquare:(Square *)square forX:(NSInteger)x Y:(NSInteger)y;

- (NSArray*)getRow:(NSInteger)x;
- (NSArray*)getColumn:(NSInteger)y;
- (NSArray*)getNegativeSlopeDiagonal;
- (NSArray*)getPositiveSlopeDiagonal;


@end