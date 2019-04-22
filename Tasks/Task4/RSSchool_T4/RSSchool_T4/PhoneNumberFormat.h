#import <Foundation/Foundation.h>

@interface PhoneNumberFormat : NSObject
@property (assign, nonatomic, readonly) int localNumberLength;
@property (assign, nonatomic, readonly) int areaCodeLength;
@property (assign, nonatomic, readonly) int countryCodeLength;
@property (retain, nonatomic, readonly) NSString* gap;
@property (retain, nonatomic, readonly) NSString* country;

- (instancetype)initWith:(int) localNumberLength areaCodeLength:(int) areaCodeLength countryCodeLength:(int) countryCodeLength gap:(NSString*) gap country:(NSString*) country;
@end
