#import "ViewController.h"
#import "Square.h"
#import "GameLogic.h"

@implementation ViewController {
    GameLogic*_game;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createGrid];
}

#pragma mark Create & Reset

- (void)createGrid {
    _game = [[GameLogic alloc] init];
    [_game setSquare:_square_0_0 forX:0 Y:0];
    [_game setSquare:_square_0_1 forX:0 Y:1];
    [_game setSquare:_square_0_2 forX:0 Y:2];
    [_game setSquare:_square_1_0 forX:1 Y:0];
    [_game setSquare:_square_1_1 forX:1 Y:1];
    [_game setSquare:_square_1_2 forX:1 Y:2];
    [_game setSquare:_square_2_0 forX:2 Y:0];
    [_game setSquare:_square_2_1 forX:2 Y:1];
    [_game setSquare:_square_2_2 forX:2 Y:2];
}


#pragma mark Button Actions

- (IBAction)squareSelected:(Square*)sender {
    [_game playerChooses:sender];
    if (_game.hasWinner) [self declareWinnerOnSquares:_game.winningSquares];
    else if (_game.isDraw) [self declareDraw];
    else [_game chooseForComputer];
    if (_game.hasWinner) [self declareWinnerOnSquares:_game.winningSquares];
}


#pragma mark End Game Conditions

- (void)declareWinnerOnSquares:(NSArray*)winningSquares {
    for (Square* square in winningSquares) {
        square.backgroundColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:0.7];
    }
    [[[UIAlertView alloc] initWithTitle:nil message:@"Winner!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play Again", nil] show];
}

- (void)declareDraw {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Draw!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play Again", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [_game reset];
}

@end