
#import <Foundation/Foundation.h>
#import "PhoneNumberFormat.h"

@interface PhoneNumberFormatter : NSObject
- (NSString*) setFormatForPhohne:(NSString*) decimalPhoneNumber fullPhoneNumber:(NSString*) fullPhoneNumber globalFormat:(PhoneNumberFormat*) globalFormat;
@end
