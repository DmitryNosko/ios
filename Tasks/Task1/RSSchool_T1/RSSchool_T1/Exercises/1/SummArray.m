#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    return [array valueForKeyPath:@"@sum.self"];
}

@end
