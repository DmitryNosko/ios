#import "ChangeDayCommand.h"

@implementation ChangeDayCommand

- (NSDate *)changeDate:(NSDate *)date withValue:(NSInteger)value {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [[[NSDateComponents alloc] init] autorelease];
    [dayComponents setDay:value];
    
    return [[calendar dateByAddingComponents:dayComponents toDate:date options:0] autorelease];
}

@end
