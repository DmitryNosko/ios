#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    
    long roundedCharactersInRow = [self calculateEncryptionIndex:[string length]];
    
    NSMutableArray* encryptedArray = [self createMatrix:roundedCharactersInRow];
    
    for (long i = 0; i < [string length]; i+= roundedCharactersInRow) {
        
        long stringToEncryptLength = [string length] - i;
        
        long rangeLength = stringToEncryptLength < roundedCharactersInRow ? stringToEncryptLength : roundedCharactersInRow;
        
        NSString* stringToEncrypt = [string substringWithRange:NSMakeRange(i, rangeLength)];
        
        for (int j = 0; j < [stringToEncrypt length]; j++) {
            NSMutableArray* currentArray = [encryptedArray objectAtIndex:j];
            
            [currentArray addObject:[stringToEncrypt substringWithRange:NSMakeRange(j, 1)]];
        }
    }
    
    return [self convertMatrixToString:encryptedArray];
}

- (long) calculateEncryptionIndex:(NSInteger) stringLength {
    
    long roundedCharactersInRow = round(sqrt(stringLength));
    
    if (pow(roundedCharactersInRow, 2) < stringLength) {
        roundedCharactersInRow ++;
    }
    
    return roundedCharactersInRow;
}

- (NSString*) convertMatrixToString:(NSMutableArray*) array {
    
    NSMutableString* stringFromRow = [[NSMutableString alloc] init];
    NSString* space = @" ";
    
    for (int i = 0; i < [array count]; i++) {
        NSMutableArray* currentArray = [array objectAtIndex:i];
        [stringFromRow appendString:[currentArray componentsJoinedByString:@""]];
        if (i != [array count] - 1) {
            [stringFromRow appendString:space];
        }
    }
    
    return stringFromRow;
}

- (NSMutableArray*) createMatrix:(long) size {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    for (long i = 0; i < size; i++) {
        [array addObject:[NSMutableArray new]];
    }
    
    return array;
}

@end
