#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (assign, nonatomic) NSInteger data;
@property (retain, nonatomic) Node* left;
@property (retain, nonatomic) Node* right;

- (instancetype)initWithData:(NSInteger) data;
- (Node*) clone;

@end
