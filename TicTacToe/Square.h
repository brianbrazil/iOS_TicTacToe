#import <Foundation/Foundation.h>

typedef enum {
    NONE,
    X,
    O
} Value;

@interface Square : UIButton

@property (nonatomic) Value value;

@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;

@end