#import "Node.h"

@implementation Node

- (instancetype)initWithData:(NSInteger) data
{
    self = [super init];
    if (self) {
        _data = data;
        _left = nil;
        _right = nil;
    }
    return self;
}

- (Node*) clone {
    
    Node* nNode = [[Node alloc] initWithData:_data];
    
    if (_left != nil) {
        nNode.left = [_left clone];
    }
    
    if (_right != nil) {
        nNode.right = [_right clone];
    }
    
    return nNode;
}

- (void)dealloc
{
    [_left release];
    [_right release];
    [super dealloc];
}

@end
