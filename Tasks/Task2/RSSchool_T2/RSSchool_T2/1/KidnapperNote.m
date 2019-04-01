#import "KidnapperNote.h"

@implementation KidnapperNote

- (BOOL)checkMagazine:(NSString *)magaine note:(NSString *)note {
    
    NSCountedSet* setOfMagazineComponents = [[[NSCountedSet alloc] initWithArray:[[magaine lowercaseString] componentsSeparatedByString:@" "]] autorelease];
    
    NSCountedSet* setOfNotesComponents = [[[NSCountedSet alloc] initWithArray:[[note lowercaseString] componentsSeparatedByString:@" "]] autorelease];
    
    return [setOfNotesComponents isSubsetOfSet:setOfMagazineComponents];
}


@end
