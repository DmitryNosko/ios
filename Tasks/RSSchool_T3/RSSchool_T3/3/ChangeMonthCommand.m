#import "ChangeMonthCommand.h"

@implementation ChangeMonthCommand

- (NSDate *)changeDate:(NSDate *)date withValue:(NSInteger)value {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *monthComponents = [[[NSDateComponents alloc] init] autorelease];
    [monthComponents setMonth:value];
    
    return [[calendar dateByAddingComponents:monthComponents toDate:date options:0] autorelease];
}

@end
