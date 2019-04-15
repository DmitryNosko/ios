#import <Foundation/Foundation.h>

@protocol ChangeDateCommand <NSObject>
- (NSDate*) changeDate:(NSDate*) date withValue:(NSInteger) value;
@end
