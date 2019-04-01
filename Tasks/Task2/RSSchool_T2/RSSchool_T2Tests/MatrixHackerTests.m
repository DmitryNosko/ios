#import <XCTest/XCTest.h>
#import "MatrixHacker.h"

@interface MatrixHackerTests : XCTestCase
@property (nonatomic, strong) MatrixHacker *hacker;
@property (nonatomic, retain) NSArray *people;
@end

@interface Char : NSObject <Character>

@property (retain, nonatomic) NSString* name;
@property (assign, nonatomic) BOOL isClone;

@end

@implementation Char

+ (instancetype)createWithName:(NSString *)name isClone:(BOOL)clone {
    
    Char* character = [[[Char alloc] init] autorelease];
    character.name = name;
    character.isClone = clone;
    
    return character;
}

- (BOOL)isClone {
    return _isClone;
}

- (NSString *)name {
    return _name;
}

- (BOOL)isEqual:(id)other {
    
    if (other == self) {
        return YES;
    } else {
        
        Char* otherChar = other;
        return [_name isEqualToString:otherChar.name] && _isClone == otherChar.isClone;
    }
}

- (NSUInteger)hash {
    
    NSInteger prime = 31;
    NSInteger result = 1;
    result = prime * result + [_name hash];
    
    return prime * result + _isClone;
}

@end

@implementation MatrixHackerTests

- (void)setUp {
  self.hacker = [MatrixHacker new];
  self.people = @[@"Delivery Guy", @"Neo", @"Policeman", @"Agent John", @"Agent Black", @"Bartender"];
}

- (void)test1 {
  __block NSInteger counter = 0;
  [self.hacker injectCode:^id<Character>(NSString *name) {
    counter += 1;
    return [Char new];
  }];
  [self.hacker runCodeWithData:self.people];
  XCTAssertTrue(self.people.count == counter);
}

- (void)test2 {
    
    __block NSInteger counter = 0;
    
    [self.hacker injectCode:^id<Character>(NSString *name) {
        counter += 1;
        return [[name lowercaseString] isEqualToString:@"neo"] ?
        [Char createWithName:@"Neo" isClone:NO] : [Char createWithName:@"Agent Smith" isClone:YES];
    }];
    
    NSArray<Char*>* expectedResult = [[NSArray alloc] initWithObjects:
                                      [Char createWithName:@"Agent Smith" isClone:YES],
                                      [Char createWithName:@"Neo" isClone:NO],
                                      [Char createWithName:@"Agent Smith" isClone:YES],
                                      [Char createWithName:@"Agent Smith" isClone:YES],
                                      [Char createWithName:@"Agent Smith" isClone:YES],
                                      [Char createWithName:@"Agent Smith" isClone:YES], nil];
    
    NSArray<Char*>* actualResult = [self.hacker runCodeWithData:self.people];
    XCTAssertTrue(self.people.count == counter);
    XCTAssertTrue([actualResult isEqualToArray:expectedResult]);
    
}

@end
