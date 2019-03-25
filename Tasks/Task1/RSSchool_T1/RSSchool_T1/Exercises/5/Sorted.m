#import "Sorted.h"

@implementation ResultObject
@end

@implementation Sorted

NSUInteger const MAX_SWAP_ELEMENTS_COUNT = 2;

- (ResultObject*)sorted:(NSString*)string {
    ResultObject *value = [ResultObject new];
    
    NSMutableArray* arrayToSort = [[NSMutableArray alloc] initWithArray:[self stringToArray:string]];
    NSMutableArray* indexesToProcess = [[NSMutableArray alloc] init];
    NSInteger missOrderCount = 0;
    
    for (int i = 1; i < [arrayToSort count]; i++) {
        if ([[arrayToSort objectAtIndex:i] integerValue] < [[arrayToSort objectAtIndex:i - 1] integerValue]) {
            missOrderCount++;
            [indexesToProcess addObject:[NSNumber numberWithInt:i - 1]];
            [indexesToProcess addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    NSArray* indexArray = [[[NSOrderedSet alloc] initWithArray:indexesToProcess] array];
    
    NSRange indexesRange = NSMakeRange([[indexArray firstObject] unsignedIntegerValue], [[indexArray lastObject] unsignedIntegerValue]);
    
    if (missOrderCount > 0 && missOrderCount <= MAX_SWAP_ELEMENTS_COUNT) {
        value = [self swapElements:arrayToSort idexesRange:indexesRange];
    } else if (missOrderCount >= MAX_SWAP_ELEMENTS_COUNT && [self isReversable:indexArray]) {
        value = [self reverseElements:arrayToSort indexesRange:indexesRange indexesAmount:[indexArray count]];
    }
    
    return value;
}

- (ResultObject*) swapElements:(NSMutableArray*) arrayToSort idexesRange:(NSRange) indexesRange {
    
    ResultObject* value = [ResultObject new];
    
    [arrayToSort exchangeObjectAtIndex:indexesRange.location withObjectAtIndex:indexesRange.length];
    
    if ([self isArraySorted:arrayToSort]) {
        
        value.detail = [self setDetailAndStatusWithSort:@"swap %@ %@" fromIndex:indexesRange.location to:indexesRange.length];
        value.status = YES;
    }
    
    return value;
}

- (ResultObject*) reverseElements:(NSMutableArray*) arrayToSort indexesRange:(NSRange) indexesRange indexesAmount:(NSUInteger) indexesAmount {
    
    ResultObject* value = [ResultObject new];
    
    NSArray* reversedArray = [self reverseArray:[arrayToSort subarrayWithRange:NSMakeRange(indexesRange.location, indexesAmount)]];
    
    if([self isArraySorted:reversedArray]) {
        
        [arrayToSort replaceObjectsInRange:NSMakeRange(indexesRange.location, indexesAmount) withObjectsFromArray:reversedArray];
        
        if ([self isArraySorted:arrayToSort]) {
            
            value.detail = [self setDetailAndStatusWithSort:@"reverse %@ %@" fromIndex:indexesRange.location to:indexesRange.length];
            value.status = YES;
            
        }
    }
    return value;
}

- (NSString*) setDetailAndStatusWithSort:(NSString*) sortType fromIndex:(NSUInteger)from to:(NSUInteger)to {
    
    return [NSString stringWithFormat:sortType, [NSNumber numberWithUnsignedInteger:from + 1], [NSNumber numberWithUnsignedInteger:to + 1]];
}

- (BOOL)isReversable:(NSArray*) indexesToReverse {
    
    for (int i = 1; i < [indexesToReverse count]; i++) {
        if ([[indexesToReverse objectAtIndex:i] integerValue] - [[indexesToReverse objectAtIndex:i - 1] integerValue] != 1) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL) isArraySorted:(NSArray*) array {
    
    for (int i = 1; i < [array count]; i++) {
        if ([array[i - 1] compare:array[i]] != NSOrderedAscending) {
            return NO;
        }
    }
    
    return YES;
}

- (NSArray*)reverseArray:(NSArray*) array {
    return [[array reverseObjectEnumerator] allObjects];
}

- (NSArray*)stringToArray:(NSString*) string {
    return [[string componentsSeparatedByString:@" "] valueForKey:@"intValue"];
}

@end
