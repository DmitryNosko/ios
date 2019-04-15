#import <Foundation/Foundation.h>
/*
 You need to extend NSArray functionality and add a method which will print it's contents.
 It should also print square brackets for the beginning and the end of the array.

 - Example
 Input: @[@[@0, @1, @2], [NSNull null], @[@"123",@"456",@"789"], @[@[@[@1337], @{@"Key": @"Value"}]]]
 Output: [[0,1,2],null,["123","456","789"],[[[1337],unsupported]]]

 Following element types should be supported:
 NSNumber
 NSNull
 NSArray
 NSString

 For all the others, it should print `unsupported`
 */
@interface NSArray (RSSchool_Extension_Name)
- (NSString *)print;
@end

@implementation NSArray (RSSchool_Extension_Name)

- (NSString*) print {
    
    __block NSMutableString* result = [[NSMutableString alloc] initWithString:@"["];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull current, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [current isKindOfClass:[NSArray class]] ?
        [result appendString:[current print]] : // RECURSION
        [result appendString:[self formatOfClass:current]];
        
        if ([self hasNext:self currentIndex:idx]) {
            [result appendString:@","];
        }
    }];
    
    return [result stringByAppendingString:@"]"];
}

- (BOOL) hasNext:(NSArray*) array currentIndex:(NSUInteger) index {
    return index + 1 < [array count];
}

- (NSString*) formatOfClass:(id) object {
    
    NSString* result = @"unsupported";
    
    if ([object isKindOfClass:[NSNumber class]]) {
        result = [NSString stringWithFormat:@"%@", object];
    } else if ([object isKindOfClass:[NSString class]]) {
        result = [NSString stringWithFormat:@"\"%@\"", object];
    } else if ([object isKindOfClass:[NSNull class]]) {
        result =  @"null";
    }
    return result;
}

@end
