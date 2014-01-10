#import <Foundation/Foundation.h>

typedef enum {
    NONE,
    X,
    O
} Value;

@interface Square : UIButton

@property (nonatomic) Value value;

@end