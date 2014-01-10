#import "Grid.h"
#import "Square.h"

@implementation Grid {
    NSMutableDictionary* _squares;
    NSInteger _gridSize;
}

- (id)init {
    self = [super init];
    if (self) {
        _gridSize = 0;
        _squares = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark Properties

- (NSInteger)size {
    return _gridSize;
}

- (NSArray*)allSquares {
    return _squares.allValues;
}

- (NSArray*)emptySquares {
    NSMutableArray* emptySquares = [[NSMutableArray alloc] init];
    for (Square* square in _squares.allValues) {
        if (square.value == NONE) [emptySquares addObject:square];
    }
    return emptySquares;
}

- (NSArray*)cornerSquares {
    return @[ [self squareForX:0 Y:0], [self squareForX:0 Y:_gridSize-1], [self squareForX:_gridSize-1 Y:0], [self squareForX:_gridSize-1 Y:_gridSize-1] ];
}

- (Square*)centerSquare {
    return [self squareForX:(_gridSize)/2 Y:(_gridSize)/2];
}

#pragma mark Accessors

- (Square*)squareForX:(NSInteger)x Y:(NSInteger)y {
    return [_squares objectForKey:[NSString stringWithFormat:@"%d,%d", x, y]];
}

- (void)setSquare:(Square *)square forX:(NSInteger)x Y:(NSInteger)y {
    square.x = x;
    square.y = y;
    [_squares setValue:square forKey:[NSString stringWithFormat:@"%d,%d", x, y]];
    _gridSize = MAX(_gridSize, x+1);
    _gridSize = MAX(_gridSize, y+1);
}

@end