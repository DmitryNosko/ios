#import "FullBinaryTrees.h"
#import "Node.h"
#include <math.h>

@interface NSMutableArray (QueueAdditions)
- (id) dequeue;
- (void) enqueue:(id)obj;
@end

@implementation NSMutableArray (QueueAdditions)
- (id) dequeue {
    id headObject = [self objectAtIndex:0];
    if (headObject) {
        [[headObject retain] autorelease];
        [self removeObjectAtIndex:0];
    }
    return headObject;
}

- (void) enqueue:(id)anObject {
    if (anObject == nil) {
        [self addObject:[NSNull null]];
    } else {
        [self addObject:anObject];
    }
}
@end

@interface FullBinaryTrees ()
@property (retain, nonatomic) NSDictionary* nodesForTreeType;
@end

static NSInteger const START_INDEX = 3;
static NSInteger const INCREMENT_PAIR = 2;
static NSString* const NULL_STRING = @"null";

@implementation FullBinaryTrees

- (instancetype)init
{
    self = [super init];
    if (self) {
        _nodesForTreeType = @{[NSNumber numberWithInteger:9] : [NSNumber numberWithDouble:-2.0],
                              [NSNumber numberWithInteger:5] : [NSNumber numberWithDouble:-2.0],
                              [NSNumber numberWithInteger:7] : [NSNumber numberWithDouble:0.0]};
    }
    return self;
}

- (NSString *)stringForNodeCount:(NSInteger)count {
    NSNumber* offSet = [_nodesForTreeType objectForKey:[NSNumber numberWithInteger:count]];
    if (count == 1) {
        return @"[[0]]";
    }
    if (offSet == nil) {
        return @"[]";
    }
    NSArray<Node*>* combinations = [self createCombinations:count];
    NSMutableString* result = [[[NSMutableString alloc] init] autorelease];
    for (int i = 0; i < [combinations count]; i++) {
        [result appendString:[self treeToString:[combinations objectAtIndex:i] offset:[offSet doubleValue] treeHeight:[self getHeightOfTree:count]]];
    }
    return result;
}

- (NSArray<Node*>*) createCombinations:(NSInteger) nodesAmount {
    
    NSMutableDictionary* nodesAmountToCombinations = [[[NSMutableDictionary alloc] init] autorelease];
    [nodesAmountToCombinations setObject:[NSMutableArray<Node*> arrayWithObject:[[[Node alloc] initWithData:0] autorelease]] forKey:[NSNumber numberWithInteger:1]];
    
    for (NSInteger i = START_INDEX; i <= nodesAmount; i += INCREMENT_PAIR) {
        
        NSMutableArray<Node*>* combinations = [[NSMutableArray<Node*> alloc] init];
        
        for (NSInteger j = 1; j < i; j += INCREMENT_PAIR) {
            NSMutableArray<Node*>* left = [nodesAmountToCombinations objectForKey:[NSNumber numberWithInteger:j]];
            NSMutableArray<Node*>* right = [nodesAmountToCombinations objectForKey:[NSNumber numberWithInteger:i - j - 1]];
            [combinations addObjectsFromArray:[self generateAllCombinations:left right:right]];
        }
        
        [nodesAmountToCombinations setObject:combinations forKey:[NSNumber numberWithInteger:i]];
        [combinations release];
    }
    return [nodesAmountToCombinations objectForKey:[NSNumber numberWithInteger:nodesAmount]];
}

- (NSMutableArray<Node*>*) generateAllCombinations:(NSMutableArray<Node*>*) left right:(NSMutableArray<Node*>*) right {
    NSMutableArray<Node*>* combinations = [[[NSMutableArray<Node*> alloc] init] autorelease];
    
    for (int i = 0; i < [left count]; i++) {
        for (int j = 0; j < [right count]; j++) {
            Node* node = [[Node alloc] initWithData:0];
            node.left = [[left objectAtIndex:i] clone];
            node.right = [[right objectAtIndex:j] clone];
            [combinations addObject:node];
            [node release];
        }
    }
    return combinations;
}

- (NSString*) treeToString:(Node*) root offset:(NSInteger) offset treeHeight:(NSInteger) treeHeight {
    
    NSMutableArray<Node*>* nodesQueue = [[NSMutableArray<Node*> alloc] initWithObjects:root, nil];
    NSMutableString* resultStr  = [[[NSMutableString alloc] initWithString:@"["] autorelease];
    
    while ([nodesQueue count] != 0) {
        double currentHeight = [self getHeightOfTree:offset];
        Node* currentNode = [nodesQueue dequeue];
        
        if (currentNode == (id)[NSNull null] && !(treeHeight - currentHeight == 0)) {
            [resultStr appendString:[NSString stringWithFormat:@"%@,", NULL_STRING]];
        } else if (currentNode != (id)[NSNull null]) {
            [resultStr appendString:[NSString stringWithFormat:@"%@,", [NSNumber numberWithInteger:currentNode.data]]];
            offset++;
            [nodesQueue enqueue:currentNode.left];
            [nodesQueue enqueue:currentNode.right];
        }
    }
    [nodesQueue release];
    [resultStr replaceCharactersInRange:NSMakeRange([resultStr length] - 1, 1) withString:@"]"];
    return resultStr;
}

- (NSInteger) getHeightOfTree:(double) node{
    if (fmod(node, 2) == 0) {
        node++;
    }
    return (NSInteger)(log(node + 1) / log(2.0) - 1);
}

- (void)dealloc
{
    [_nodesForTreeType release];
    [super dealloc];
}

@end
