#import "ChangeWeekCommand.h"


@implementation ChangeWeekCommand

- (NSDate *)changeDate:(NSDate *)date withValue:(NSInteger)value {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekComponents = [[[NSDateComponents alloc] init] autorelease];
    [weekComponents setWeekOfMonth:value];
    
    return [[calendar dateByAddingComponents:weekComponents toDate:date options:0] autorelease];
}

@end
