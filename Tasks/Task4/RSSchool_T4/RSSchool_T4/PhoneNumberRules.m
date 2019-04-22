
#import "PhoneNumberRules.h"
#import "PhoneNumberFormat.h"

extern NSInteger const MAX_COUNTRY_CODE_LENGTH = 3;
extern NSInteger const MAX_PHONE_NUMBER_LENGTH = 12;

@implementation PhoneNumberRules

- (NSDictionary*) getPhoneFormatForCountryCode {
    return @{@"7"   : [[PhoneNumberFormat alloc] initWith:7 areaCodeLength:3 countryCodeLength:1 gap:@" " country:@"flag_RU"],
             @"77"   : [[PhoneNumberFormat alloc] initWith:7 areaCodeLength:3 countryCodeLength:1 gap:@" " country:@"flag_KZ"],
             @"373" : [[PhoneNumberFormat alloc] initWith:6 areaCodeLength:2 countryCodeLength:3 gap:@"-" country:@"flag_MD"],
             @"374" : [[PhoneNumberFormat alloc] initWith:6 areaCodeLength:2 countryCodeLength:3 gap:@"-" country:@"flag_AM"],
             @"993" : [[PhoneNumberFormat alloc] initWith:6 areaCodeLength:2 countryCodeLength:3 gap:@"-" country:@"flag_TM"],
             @"375" : [[PhoneNumberFormat alloc] initWith:7 areaCodeLength:2 countryCodeLength:3 gap:@"-" country:@"flag_BY"],
             @"380" : [[PhoneNumberFormat alloc] initWith:7 areaCodeLength:2 countryCodeLength:3 gap:@"-" country:@"flag_UA"],
             @"992" : [[PhoneNumberFormat alloc] initWith:7 areaCodeLength:2 countryCodeLength:3 gap:@"-" country:@"flag_TJ"],
             @"994" : [[PhoneNumberFormat alloc] initWith:7 areaCodeLength:2 countryCodeLength:3 gap:@"-" country:@"flag_AZ"],
             @"996" : [[PhoneNumberFormat alloc] initWith:7 areaCodeLength:2 countryCodeLength:3 gap:@"-" country:@"flag_KG"],
             @"998" : [[PhoneNumberFormat alloc] initWith:7 areaCodeLength:2 countryCodeLength:3 gap:@"-" country:@"flag_UZ"]};
}

- (NSMutableCharacterSet*) getPphoneNumberSymbolsSet {
    NSMutableCharacterSet* phoneNumberSymbolsSet = [NSMutableCharacterSet characterSetWithCharactersInString:@"+"];
    [phoneNumberSymbolsSet formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    return phoneNumberSymbolsSet;
}

- (NSMutableCharacterSet*) getPlusSymbolSet {
    return [NSMutableCharacterSet characterSetWithCharactersInString:@"+"];
}

@end
