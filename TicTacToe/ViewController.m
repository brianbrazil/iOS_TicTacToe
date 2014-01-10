#import "ViewController.h"
#import "Square.h"

@implementation ViewController {
    NSMutableDictionary* _squares;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createGrid];
}

#pragma mark Create & Reset

- (void)createGrid {
    _squares = [[NSMutableDictionary alloc] init];
    [self setSquare:_square_0_0 forX:0 Y:0];
    [self setSquare:_square_0_1 forX:0 Y:1];
    [self setSquare:_square_0_2 forX:0 Y:2];
    [self setSquare:_square_1_0 forX:1 Y:0];
    [self setSquare:_square_1_1 forX:1 Y:1];
    [self setSquare:_square_1_2 forX:1 Y:2];
    [self setSquare:_square_2_0 forX:2 Y:0];
    [self setSquare:_square_2_1 forX:2 Y:1];
    [self setSquare:_square_2_2 forX:2 Y:2];
}

- (void)resetGrid {
    for (Square* square in [self allSquares]) {
        square.value = NONE;
        square.backgroundColor = UIColor.clearColor;
    }
}

#pragma mark Button Actions

- (IBAction)squareSelected:(Square*)sender {
    sender.value = X;
    NSArray* winner = [self findWinner];
    if (winner != nil) [self declareWinner:winner];
    else if (![self hasEmptySquares]) [self declareDraw];
    else {
        [self chooseSquare].value = O;
        winner = [self findWinner];
        if (winner != nil) [self declareWinner:winner];
    }
}

#pragma mark Find Winner

- (NSArray*)findWinner {
    NSArray* candidate;
    if ((candidate = [self findWinnerOnRow]) != nil) return candidate;
    else if ((candidate = [self findWinnerOnColumn]) != nil) return candidate;
    else if ((candidate = [self findWinnerOnDiagonal]) != nil) return candidate;
    else return nil;
}

- (NSArray*)findWinnerOnRow {
    for (int x = 0; x < 3; x++) {
        Square* square0 = [self squareForX:x Y:0];
        Square* square1 = [self squareForX:x Y:1];
        Square* square2 = [self squareForX:x Y:2];
        if (square0.value != NONE && square0.value == square1.value && square1.value == square2.value) return [NSArray arrayWithObjects:square0,square1,square2, nil];
    }
    return nil;
}

- (NSArray*)findWinnerOnColumn {
    for (int y = 0; y < 3; y++) {
        Square* square0 = [self squareForX:0 Y:y];
        Square* square1 = [self squareForX:1 Y:y];
        Square* square2 = [self squareForX:2 Y:y];
        if (square0.value != NONE && square0.value == square1.value && square1.value == square2.value) return [NSArray arrayWithObjects:square0,square1,square2, nil];
    }
    return nil;
}

- (NSArray*)findWinnerOnDiagonal {
        Square* square0 = [self squareForX:0 Y:0];
        Square* square1 = [self squareForX:1 Y:1];
        Square* square2 = [self squareForX:2 Y:2];
        if (square0.value != NONE && square0.value == square1.value && square1.value == square2.value) return [NSArray arrayWithObjects:square0,square1,square2, nil];
        square0 = [self squareForX:2 Y:0];
        square1 = [self squareForX:1 Y:1];
        square2 = [self squareForX:0 Y:2];
        if (square0.value != NONE && square0.value == square1.value && square1.value == square2.value) return [NSArray arrayWithObjects:square0,square1,square2, nil];
        else return nil;
}

- (BOOL)hasEmptySquares {
    for (int x = 0; x < 3; x++) {
        for (int y = 0; y < 3; y++) {
            if ([self squareForX:x Y:y].value == NONE) return YES;
        }
    }
    return NO;
}

#pragma mark Choose a Square

-(Square*)chooseSquare {
    Square* candidate = [self findBlocker];
    if (candidate != nil) return candidate;
    else return [self chooseRandomEmptySquare];
}

-(Square*)findBlocker {
    for (Square* square in [self emptySquares]) {
        if ([self squareBlocksOnRow:square]) return square;
        if ([self squareBlocksOnColumn:square]) return square;
        if ([self squareBlocksOnNegativeDiagonal:square]) return square;
        if ([self squareBlocksOnPositiveDiagonal:square]) return square;
    }
    return nil;
}

- (BOOL)squareBlocksOnRow:(Square*)square {
    for (int y = 0; y < 3; y++) {
            Square* rowmate = [self squareForX:square.x Y:y];
            if (rowmate == square) continue;
            else if (rowmate.value == O || rowmate.value == NONE) return NO;
        }
    return YES;
}

- (BOOL)squareBlocksOnColumn:(Square*)square {
    for (int x = 0; x < 3; x++) {
        Square* columnmate = [self squareForX:x Y:square.y];
        if (columnmate == square) continue;
        else if (columnmate.value == O || columnmate.value == NONE) return NO;
    }
    return YES;
}

- (BOOL)squareBlocksOnNegativeDiagonal:(Square*)square {
    if (![self squareIsOnNegativeDiagonal:square]) return NO;
    for (int i = 0; i < 3; i++) {
        Square* diagonalmate = [self squareForX:i Y:i];
        if (diagonalmate == square) continue;
        else if (diagonalmate.value == O || diagonalmate.value == NONE) return NO;
    }
    return YES;
}

- (BOOL)squareBlocksOnPositiveDiagonal:(Square*)square {
    if (![self squareIsOnPositiveDiagonal:square]) return NO;
    for (int y = 0; y < 3; y++) {
        Square* diagonalmate = [self squareForX:(3-1)-y Y:y];
        if (diagonalmate == square) continue;
        else if (diagonalmate.value == O || diagonalmate.value == NONE) return NO;
    }
    return YES;
}

- (BOOL)squareIsOnNegativeDiagonal:(Square*)square {
    if (square.x == square.y) return YES;
    else return NO;
}

- (BOOL)squareIsOnPositiveDiagonal:(Square*)square {
    if (square.x + square.y == 3-1) return YES;
    else return NO;
}


- (Square*)chooseRandomEmptySquare {
    int x, y;
    while (true) {
        x = rand() % 3;
        y = rand() % 3;
        Square* square = [self squareForX:x Y:y];
        if (square.value == NONE) return square;
    }
}

#pragma mark End Game Conditions

- (void)declareWinner:(NSArray*)winner {
    for (Square* square in winner) {
        square.backgroundColor = UIColor.blueColor;
    }
    [[[UIAlertView alloc] initWithTitle:nil message:@"Winner!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play Again", nil] show];
}

- (void)declareDraw {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Draw!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play Again", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self resetGrid];
}

#pragma mark Square Access

- (Square*)squareForX:(NSInteger)x Y:(NSInteger)y {
    return [_squares objectForKey:[NSString stringWithFormat:@"%d,%d", x, y]];
}

- (void)setSquare:(Square *)square forX:(NSInteger)x Y:(NSInteger)y {
    square.x = x;
    square.y = y;
    [_squares setValue:square forKey:[NSString stringWithFormat:@"%d,%d", x, y]];
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

@end