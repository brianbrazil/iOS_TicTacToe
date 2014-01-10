#import "ViewController.h"
#import "Square.h"
#import "Grid.h"

@implementation ViewController {
    Grid* _grid;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createGrid];
}

#pragma mark Create & Reset

- (void)createGrid {
    _grid = [[Grid alloc] init];
    [_grid setSquare:_square_0_0 forX:0 Y:0];
    [_grid setSquare:_square_0_1 forX:0 Y:1];
    [_grid setSquare:_square_0_2 forX:0 Y:2];
    [_grid setSquare:_square_1_0 forX:1 Y:0];
    [_grid setSquare:_square_1_1 forX:1 Y:1];
    [_grid setSquare:_square_1_2 forX:1 Y:2];
    [_grid setSquare:_square_2_0 forX:2 Y:0];
    [_grid setSquare:_square_2_1 forX:2 Y:1];
    [_grid setSquare:_square_2_2 forX:2 Y:2];
}

- (void)resetGrid {
    for (Square* square in [_grid allSquares]) {
        square.value = NONE;
        square.backgroundColor = UIColor.clearColor;
    }
}

#pragma mark Button Actions

- (IBAction)squareSelected:(Square*)sender {
    sender.value = X;
    if ([self findWinner] != nil) [self declareWinner:[self findWinner]];
    else if (![self hasEmptySquares]) [self declareDraw];
    else [self chooseSquare].value = O;
    if ([self findWinner] != nil) [self declareWinner:[self findWinner]];
}

#pragma mark Find Winner

- (NSArray*)findWinner {
    NSArray* candidate;
    if ((candidate = [self findWinnerOnRow]) != nil) return candidate;
    else if ((candidate = [self findWinnerOnColumn]) != nil) return candidate;
    else if ((candidate = [self findWinnerOnNegativeDiagonal]) != nil) return candidate;
    else if ((candidate = [self findWinnerOnPositiveDiagonal]) != nil) return candidate;
    else return nil;
}

- (NSArray*)findWinnerOnRow {
    for (int x = 0; x < _grid.size; x++) {
        NSArray* row = [_grid getRow:x];
        if ([self allEqualAndNotEmpty:row]) return row;
    }
    return nil;
}

- (NSArray*)findWinnerOnColumn {
    for (int y = 0; y < _grid.size; y++) {
        NSArray* column = [_grid getColumn:y];
        if ([self allEqualAndNotEmpty:column]) return column;
    }
    return nil;
}

- (NSArray*)findWinnerOnNegativeDiagonal {
    NSArray* diagonal = [_grid getNegativeSlopeDiagonal];
    if ([self allEqualAndNotEmpty:diagonal]) return diagonal;
    else return nil;
}
- (NSArray*)findWinnerOnPositiveDiagonal {
    NSArray* diagonal = [_grid getPositiveSlopeDiagonal];
    if ([self allEqualAndNotEmpty:diagonal]) return diagonal;
    else return nil;
}

- (BOOL)hasEmptySquares {
    if ([_grid.emptySquares count] > 0) return YES;
    else return NO;
}

- (BOOL)allEqualAndNotEmpty:(NSArray*)squares {
    Square* reference = [squares objectAtIndex:0];
    if (reference.value == NONE) return NO;
    for (Square* square in squares) {
        if (square.value != reference.value) return NO;
    }
    return YES;
}


#pragma mark Choose a Square

-(Square*)chooseSquare {
    if ([self findWinningMove] != nil) return [self findWinningMove];
    else if ([self findBlocker] != nil) return [self findBlocker];
    else if (_grid.centerSquare.value == NONE) return [_grid centerSquare];
    else if ([self findCornerSquare] != nil) return [self findCornerSquare];
    else return [self chooseRandomEmptySquare];
}

-(Square*)findBlocker {
    for (Square* square in _grid.emptySquares) {
        if ([self blocksOnNegativeDiagonal:square]) return square;
        if ([self blocksOnPositiveDiagonal:square]) return square;
        if ([self blocksOnRow:square]) return square;
        if ([self blocksOnColumn:square]) return square;
    }
    return nil;
}

- (BOOL)blocksOnRow:(Square*)square {
    for (Square* rowmate in [_grid getRow:square.x]) {
        if (rowmate == square) continue;
        else if (rowmate.value != X) return NO;
    }
    return YES;
}

- (BOOL)blocksOnColumn:(Square*)square {
    for (Square* columnmate in [_grid getColumn:square.y]) {
        if (columnmate == square) continue;
        else if (columnmate.value != X) return NO;
    }
    return YES;
}

- (BOOL)blocksOnNegativeDiagonal:(Square*)square {
    if (![self squareIsOnNegativeDiagonal:square]) return NO;
    for (Square* diagonalmate in [_grid getNegativeSlopeDiagonal]) {
        if (diagonalmate == square) continue;
        else if (diagonalmate.value != X) return NO;
    }
    return YES;
}

- (BOOL)blocksOnPositiveDiagonal:(Square*)square {
    if (![self squareIsOnPositiveDiagonal:square]) return NO;
    for (Square* diagonalmate in [_grid getPositiveSlopeDiagonal]) {
        if (diagonalmate == square) continue;
        else if (diagonalmate.value != X) return NO;
    }
    return YES;
}

-(Square*)findWinningMove {
    for (Square* square in [_grid emptySquares]) {
        if ([self winsOnRow:square]) return square;
        if ([self winsOnColumn:square]) return square;
        if ([self winsOnNegativeDiagonal:square]) return square;
        if ([self winsOnPositiveDiagonal:square]) return square;
    }
    return nil;
}

- (BOOL)winsOnRow:(Square*)square {
    for (Square* rowmate in [_grid getRow:square.x]) {
        if (rowmate == square) continue;
        else if (rowmate.value != O) return NO;
    }
    return YES;
}

- (BOOL)winsOnColumn:(Square*)square {
    for (Square* columnmate in [_grid getColumn:square.y]) {
        if (columnmate == square) continue;
        else if (columnmate.value != O) return NO;
    }
    return YES;
}

- (BOOL)winsOnNegativeDiagonal:(Square*)square {
    if (![self squareIsOnNegativeDiagonal:square]) return NO;
    for (Square* diagonalmate in [_grid getPositiveSlopeDiagonal]) {
        if (diagonalmate == square) continue;
        else if (diagonalmate.value != O) return NO;
    }
    return YES;
}

- (BOOL)winsOnPositiveDiagonal:(Square*)square {
    if (![self squareIsOnPositiveDiagonal:square]) return NO;
    for (Square* diagonalmate in [_grid getNegativeSlopeDiagonal]) {
        if (diagonalmate == square) continue;
        else if (diagonalmate.value != O) return NO;
    }
    return YES;
}

- (BOOL)squareIsOnNegativeDiagonal:(Square*)square {
    if (square.x == square.y) return YES;
    else return NO;
}

- (BOOL)squareIsOnPositiveDiagonal:(Square*)square {
    if (square.x + square.y == _grid.size-1) return YES;
    else return NO;
}

- (Square*)findCornerSquare {
    for (Square* square in _grid.cornerSquares) {
        if (square.value == NONE) return square;
    }
    return nil;
}

- (Square*)chooseRandomEmptySquare {
    int x, y;
    while (true) {
        x = rand() % _grid.size;
        y = rand() % _grid.size;
        Square* square = [_grid squareForX:x Y:y];
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

@end