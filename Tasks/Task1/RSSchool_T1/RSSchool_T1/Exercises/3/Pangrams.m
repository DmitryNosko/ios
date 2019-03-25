#import "Pangrams.h"

@interface Pangrams()

@property (strong, nonatomic) NSSet* alphabet;

@end

@implementation Pangrams


- (instancetype)init
{
    self = [super init];
    if (self) {
        _alphabet = [[NSSet alloc] initWithObjects:
                     @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m",
                     @"n", @"o", @"p",  @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];    }
    return self;
}

- (BOOL)pangrams:(NSString *)string {
    
    if ([string length] < [_alphabet count]) {
        return NO;
    }
    
    NSString* lowercaseString = [string lowercaseString];
    NSMutableSet* characters = [[NSMutableSet alloc] init];
    
    for (int i = 0; i < [lowercaseString length]; i++) {
        NSString* character = [lowercaseString substringWithRange:NSMakeRange(i, 1)];
        [characters addObject:character];
    }
    
    return [_alphabet isSubsetOfSet:characters];
    
}
@end
