#import "ChangeHourCommand.h"

@implementation ChangeHourCommand

- (NSDate *)changeDate:(NSDate *)date withValue:(NSInteger)value {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *hourComponents = [[[NSDateComponents alloc] init] autorelease];
    [hourComponents setHour:value];
    
    return [[calendar dateByAddingComponents:hourComponents toDate:date options:0] autorelease];
}

@end
