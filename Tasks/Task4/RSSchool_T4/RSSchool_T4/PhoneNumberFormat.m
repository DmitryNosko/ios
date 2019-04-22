
#import "PhoneNumberFormat.h"

@interface PhoneNumberFormat ()
@property (assign, nonatomic, readwrite) int localNumberLength;
@property (assign, nonatomic, readwrite) int areaCodeLength;
@property (assign, nonatomic, readwrite) int countryCodeLength;
@property (retain, nonatomic, readwrite) NSString* gap;
@property (retain, nonatomic, readwrite) NSString* country;

@end

@implementation PhoneNumberFormat

- (instancetype)initWith:(int) localNumberLength areaCodeLength:(int) areaCodeLength countryCodeLength:(int) countryCodeLength gap:(NSString*) gap country:(NSString*) country
{
    self = [super init];
    if (self) {
        _localNumberLength  = localNumberLength;
        _areaCodeLength     = areaCodeLength;
        _countryCodeLength  = countryCodeLength;
        _gap = gap;
        _country = country;
        
    }
    return self;
}

- (void)dealloc
{
    [_country release];
    [_gap release];
    [super dealloc];
}

@end

