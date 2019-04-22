
#import "PhoneNumberFormatter.h"

static NSString* const AREA_FORMAT = @"(%@) ";
static NSString* const COUNTRY_CODE_WITH_PLUS_FORMAT = @"+%@  ";
static NSString* const COUNTRY_CODE_FORMAT = @"%@  ";

@implementation PhoneNumberFormatter

- (NSString*) setFormatForPhohne:(NSString*) phoneString fullPhoneNumber:(NSString*) currentString globalFormat:(PhoneNumberFormat*) globalFormat {
    
    NSInteger localNumberLenght = MIN([phoneString length], globalFormat.localNumberLength);
    NSMutableString* formatedString = [[[NSMutableString alloc] init] autorelease];
    
    if (localNumberLenght > 0) {
        NSString* number = [phoneString substringFromIndex:[phoneString length] - localNumberLenght];
        [formatedString appendString:number];
        if ([formatedString length] > 3) {
            [formatedString insertString:globalFormat.gap atIndex:3];
        }
        if ([formatedString length] > 6 && globalFormat.localNumberLength != 6) {
            [formatedString insertString:globalFormat.gap atIndex:6];
        }
    }
    
    if ([phoneString length] > globalFormat.localNumberLength) {
        NSInteger areaCodeLenght = MIN([phoneString length] - globalFormat.localNumberLength, globalFormat.areaCodeLength);
        NSRange areaRange = NSMakeRange([phoneString length] - globalFormat.localNumberLength - areaCodeLenght, areaCodeLenght);
        NSString* area = [phoneString substringWithRange:areaRange];
        area = [NSString stringWithFormat:AREA_FORMAT, area];
        [formatedString insertString:area atIndex:0];
    }
    
    if ([phoneString length] > globalFormat.localNumberLength + globalFormat.areaCodeLength) {
        
        NSInteger countryCode = MIN([phoneString length] - globalFormat.localNumberLength - globalFormat.areaCodeLength, globalFormat.countryCodeLength);
        NSRange countryCodeRange = NSMakeRange(0, countryCode);
        NSString* countryCodeStr = [phoneString substringWithRange:countryCodeRange];
        
        if (![[currentString substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"]) {
            countryCodeStr = [NSString stringWithFormat:COUNTRY_CODE_WITH_PLUS_FORMAT, countryCodeStr];
        } else {
            countryCodeStr = [NSString stringWithFormat:COUNTRY_CODE_FORMAT, countryCodeStr];
        }
        [formatedString insertString:countryCodeStr atIndex:0];
    }
    
    return formatedString;
}


@end
