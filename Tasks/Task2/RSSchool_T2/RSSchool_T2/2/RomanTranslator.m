#import "RomanTranslator.h"

@interface RomanTranslator ()

@property (retain, nonatomic) NSDictionary* romanNumbersToArabic;
@property (retain, nonatomic) NSDictionary* arabicNumberToRoman;

@end

@implementation RomanTranslator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _romanNumbersToArabic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"I", [NSNumber numberWithUnsignedInteger:1],
                                 @"IV", [NSNumber numberWithUnsignedInteger:4],
                                 @"V", [NSNumber numberWithUnsignedInteger:5],
                                 @"IX", [NSNumber numberWithUnsignedInteger:9],
                                 @"X", [NSNumber numberWithUnsignedInteger:10],
                                 @"XL", [NSNumber numberWithUnsignedInteger:40],
                                 @"L", [NSNumber numberWithUnsignedInteger:50],
                                 @"XC", [NSNumber numberWithUnsignedInteger:90],
                                 @"C", [NSNumber numberWithUnsignedInteger:100],
                                 @"CD", [NSNumber numberWithUnsignedInteger:400],
                                 @"D", [NSNumber numberWithUnsignedInteger:500],
                                 @"CM", [NSNumber numberWithUnsignedInteger:900],
                                 @"M", [NSNumber numberWithUnsignedInteger:1000], nil];
        
        _arabicNumberToRoman = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSNumber numberWithUnsignedInteger:1], @"I",
                                [NSNumber numberWithUnsignedInteger:4], @"IV",
                                [NSNumber numberWithUnsignedInteger:5], @"V",
                                [NSNumber numberWithUnsignedInteger:9], @"IX",
                                [NSNumber numberWithUnsignedInteger:10], @"X",
                                [NSNumber numberWithUnsignedInteger:40], @"XL",
                                [NSNumber numberWithUnsignedInteger:50], @"L",
                                [NSNumber numberWithUnsignedInteger:90], @"XC",
                                [NSNumber numberWithUnsignedInteger:100], @"C",
                                [NSNumber numberWithUnsignedInteger:400], @"CD",
                                [NSNumber numberWithUnsignedInteger:500], @"D",
                                [NSNumber numberWithUnsignedInteger:900], @"CM",
                                [NSNumber numberWithUnsignedInteger:1000], @"M",  nil];
    }
    return self;
}

- (NSString *)romanFromArabic:(NSString *)arabicString {
    
    NSArray* sortedAscKeys = [[_romanNumbersToArabic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 intValue] < [obj2 intValue];
    }];
    
    NSUInteger arabicInt = [arabicString intValue];
    
    NSUInteger indexOfFirstLessElement = [sortedAscKeys indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return arabicInt >= [obj intValue];
    }];
    
    NSUInteger romanLetterKey = [[sortedAscKeys objectAtIndex:indexOfFirstLessElement] unsignedIntegerValue];
    
    if (arabicInt == romanLetterKey) {
        return [_romanNumbersToArabic objectForKey:[NSNumber numberWithUnsignedInteger:romanLetterKey]];
    }
    
    NSMutableString* romanLetter = [_romanNumbersToArabic objectForKey:[NSNumber numberWithUnsignedInteger:romanLetterKey]];
    
    NSNumber* difference = [NSNumber numberWithUnsignedInteger:arabicInt - romanLetterKey];
    
    return [romanLetter stringByAppendingString:[self romanFromArabic:[difference stringValue]]];
}

- (NSString *)arabicFromRoman:(NSString *)romanString {
    
    NSUInteger resultSum = 0;
    NSInteger prev = 0;
    
    for (NSInteger i = [romanString length] - 1; i >= 0; i--) {
        
        NSString* curSymbol = [romanString substringWithRange:NSMakeRange(i, 1)];
        NSInteger curValue = [[_arabicNumberToRoman objectForKey:curSymbol] integerValue];
        
        if (curValue < prev) {
            resultSum -= curValue;
        } else {
            resultSum += curValue;
        }
        
        prev = curValue;
    }
    return [NSString stringWithFormat:@"%@",[NSNumber numberWithUnsignedInteger:resultSum]];
}

- (void)dealloc
{
    [_arabicNumberToRoman release];
    [_romanNumbersToArabic release];
    [super dealloc];
}

@end
