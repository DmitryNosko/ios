#import "CommandMeneger.h"
#import "ChangeYearCommand.h"
#import "ChangeDayCommand.h"
#import "ChangeHourCommand.h"
#import "ChangeMonthCommand.h"
#import "ChangeMinuteCommand.h"
#import "ChangeWeekCommand.h"

@interface CommandMeneger ()
@end

@implementation CommandMeneger

- (instancetype)init
{
    self = [super init];
    if (self) {
        _commandDictionary = @{@"day"   : [[ChangeDayCommand new] autorelease],
                               @"month" : [[ChangeMonthCommand new] autorelease],
                               @"year"  : [[ChangeYearCommand new] autorelease],
                               @"hour"  : [[ChangeHourCommand new] autorelease],
                               @"minute": [[ChangeMinuteCommand new] autorelease],
                               @"week"  : [[ChangeWeekCommand new] autorelease]
                               };
    }
    return self;
}

- (id<ChangeDateCommand>) getCommand:(NSString*) dateUnit {
    return [_commandDictionary objectForKey:dateUnit];
}


@end
