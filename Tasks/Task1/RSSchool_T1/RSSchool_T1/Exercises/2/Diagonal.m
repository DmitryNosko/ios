#import "Diagonal.h"

@implementation Diagonal

- (NSNumber *) diagonalDifference:(NSArray *)array {
    
    NSArray* numbers = [self splitStringsInArray:array];
    
    NSInteger difference = 0;
    
    for (int i = 0; i < [numbers count]; i++) {
        NSArray* row = [numbers objectAtIndex:i];
        
        NSInteger leftDiagonal = [[row objectAtIndex:i] integerValue];
        NSInteger rightDiagonal = [[row objectAtIndex:[row count] - i - 1] integerValue];
        
        difference  += leftDiagonal - rightDiagonal;
    }
    
    return [NSNumber numberWithInteger:labs(difference)];
}

- (NSArray*) splitStringsInArray:(NSArray*) stringsArray {
    
    NSMutableArray* numbers = [[NSMutableArray alloc] init];
    NSString* space = @" ";
    
    for (int i = 0; i < [stringsArray count]; i++) {
        NSString* row = [stringsArray objectAtIndex:i];
        [numbers addObject:[row componentsSeparatedByString:space]];
    }
    
    return numbers;
}

@end
