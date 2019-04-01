#import "MatrixHacker.h"
// your code here
@interface MatrixHacker ()

@property (strong, nonatomic) id<Character>(^injectedBlock)(NSString*);

@end

@implementation MatrixHacker

- (void)injectCode:(id<Character> (^)(NSString *name))theBlock {
    
    _injectedBlock = theBlock;
    
}

- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names {
    
    NSMutableArray<id<Character>> *array = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSString* name in names) {
        id<Character> character = _injectedBlock(name);
        [array addObject:character];
    }
    
    return array;
}
@end
