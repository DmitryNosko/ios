#import <Foundation/Foundation.h>

extern NSInteger const MAX_COUNTRY_CODE_LENGTH;
extern NSInteger const MAX_PHONE_NUMBER_LENGTH;

@interface PhoneNumberRules : NSObject
- (NSDictionary*) getPhoneFormatForCountryCode;
- (NSMutableCharacterSet*) getPphoneNumberSymbolsSet;
- (NSMutableCharacterSet*) getPlusSymbolSet;
@end
