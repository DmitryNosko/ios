#import "DoomsdayMachine.h"

@interface DoomsdayMachine ()

@property (nonatomic, readwrite) NSInteger years;
@property (nonatomic, readwrite) NSInteger months;
@property (nonatomic, readwrite) NSInteger weeks;
@property (nonatomic, readwrite) NSInteger days;
@property (nonatomic, readwrite) NSInteger hours;
@property (nonatomic, readwrite) NSInteger minutes;
@property (nonatomic, readwrite) NSInteger seconds;
@property (retain, nonatomic) NSDateFormatter* machineDateFormatter;

@end

static NSString* const MACHINE_DATE_FORMAT = @"yyyy:MM:dd@ss\\mm/H";
static NSString* const MACHINE_DEADLINE = @"2208:08:14@37\\13/03";

@implementation DoomsdayMachine

- (instancetype)init
{
    self = [super init];
    if (self) {
        _machineDateFormatter = [NSDateFormatter new];
        [_machineDateFormatter setDateFormat:MACHINE_DATE_FORMAT];
    }
    return self;
}

- (id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString {
    
    NSDate* sendingDate = [_machineDateFormatter dateFromString:dateString];
    NSDate* deadlineDate = [_machineDateFormatter dateFromString:MACHINE_DEADLINE];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* components = [calendar
                                    components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
                                    fromDate:sendingDate toDate:deadlineDate options:0];
    
    
    
    return [self convertComponentsToDoom:components];
}

- (DoomsdayMachine*) convertComponentsToDoom:(NSDateComponents*) dateComponents {
    
    DoomsdayMachine* doom = [[[DoomsdayMachine alloc] init] autorelease];
    
    doom.years = dateComponents.year;
    doom.months = dateComponents.month;
    doom.days = dateComponents.day;
    doom.hours = dateComponents.hour;
    doom.minutes = dateComponents.minute;
    doom.seconds = dateComponents.second;
    
    return doom;
}

- (NSString*)doomsdayString {
    return @"Sunday, August 14, 2208";
}

- (void)dealloc
{
    [_machineDateFormatter release];
    [super dealloc];
}
@end
