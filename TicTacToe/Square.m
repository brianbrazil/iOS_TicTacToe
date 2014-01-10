#import "Square.h"


@implementation Square {}

-(void)setValue:(Value)value {
    _value = value;
    [self setBackgroundImage:[self getImageForValue:value] forState:UIControlStateNormal];
    if (value == NONE) self.enabled = YES;
    else self.enabled = NO;
}

#pragma mark Private Methods

-(UIImage*)getImageForValue:(Value)value {
    if (value == X) return [self getXImage];
    else if (value == O) return [self getOImage];
    else return nil;
}

-(UIImage*)getXImage {
    switch (rand() % 3) {
        case 0: return [UIImage imageNamed:@"X1.png"];
        case 1: return [UIImage imageNamed:@"X2.png"];
        case 2: return [UIImage imageNamed:@"X3.png"];
        default: return [UIImage imageNamed:@"X1.png"];
    }
}

-(UIImage*)getOImage {
    switch (rand() % 3) {
        case 0: return [UIImage imageNamed:@"O1.png"];
        case 1: return [UIImage imageNamed:@"O2.png"];
        case 2: return [UIImage imageNamed:@"O3.png"];
        default: return [UIImage imageNamed:@"O1.png"];
    }
}

@end