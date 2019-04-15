#import "ChangeMinuteCommand.h"


@implementation ChangeMinuteCommand

- (NSDate *)changeDate:(NSDate *)date withValue:(NSInteger)value {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *minuteComponents = [[[NSDateComponents alloc] init] autorelease];
    [minuteComponents setMinute:value];
    
    return [[calendar dateByAddingComponents:minuteComponents toDate:date options:0] autorelease];
}

@end
