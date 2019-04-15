#import "ChangeYearCommand.h"

@implementation ChangeYearCommand

- (NSDate *)changeDate:(NSDate *)date withValue:(NSInteger)value {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *yearComponents = [[[NSDateComponents alloc] init] autorelease];
    [yearComponents setYear:value];
    
    return [[calendar dateByAddingComponents:yearComponents toDate:date options:0] autorelease];
}

@end
