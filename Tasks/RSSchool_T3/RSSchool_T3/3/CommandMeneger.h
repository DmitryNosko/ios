#import <Foundation/Foundation.h>
#import "ChangeDateCommand.h"

@interface CommandMeneger : NSObject
- (id<ChangeDateCommand>) getCommand:(NSString*) dateUnit;
@property (retain, nonatomic) NSDictionary* commandDictionary;
@end
