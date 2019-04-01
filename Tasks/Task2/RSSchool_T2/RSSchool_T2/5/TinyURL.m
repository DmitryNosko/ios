#import "TinyURL.h"

@interface TinyURL ()

@property (retain, nonatomic) NSCache* longURLCache;

@end

static NSString* const URL_ALPHABET = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-_";
static NSUInteger const URL_ALPHABET_LENGTH = 62;

@implementation TinyURL

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _longURLCache = [[NSCache alloc] init];
        [_longURLCache setCountLimit:20];
    }
    return self;
}

- (void)dealloc
{
    [_longURLCache release];
    [super dealloc];
}

# pragma mark - encodeMethod

- (NSURL *)encode:(NSURL *)originalURL {
    
    long urlId = [self longURLToId:originalURL.absoluteString];
    [_longURLCache setObject:originalURL forKey:[NSNumber numberWithLong:urlId]];
    
    return [NSURL URLWithString:[self idToShortURL:urlId]];
}

#pragma mark - decodMethod

- (NSURL *)decode:(NSURL *)shortenedURL {
    
    return [self idToLongURL:[self shortURLToId:shortenedURL.absoluteString]];
    
}

#pragma mark - Methods

- (NSURL*)idToLongURL:(long) urlId {
    return [_longURLCache objectForKey:[NSNumber numberWithLong:urlId]];
}

- (long) shortURLToId:(NSString*) shortURL {
    
    NSString* reversedShortURL = [self reverseString:shortURL];
    
    long urlId = 0;
    
    for (NSInteger i = 0; i <= [reversedShortURL length] - 1; i++) {
        
        urlId = urlId * URL_ALPHABET_LENGTH + [URL_ALPHABET rangeOfString:[reversedShortURL substringWithRange:NSMakeRange(i, 1)]].location;
        
    }
    
    return urlId;
}

- (NSString*) idToShortURL:(long) urlId {
    
    NSMutableString* shortURL = [[[NSMutableString alloc] init] autorelease];
    
    while (urlId > 0) {
        [shortURL appendString:[URL_ALPHABET substringWithRange:NSMakeRange(urlId % URL_ALPHABET_LENGTH, 1)]];
        urlId /= URL_ALPHABET_LENGTH;
    }
    
    return shortURL;
}

- (long) longURLToId:(NSString*) url {
    
    long idOfURL = 0;
    
    for (NSInteger i = 0; i <= [url length] - 1; i++) {
        
        NSString* symbol = [url substringWithRange:NSMakeRange(i, 1)];
        NSUInteger symbolLocation = [URL_ALPHABET rangeOfString:symbol].location;
        
        idOfURL = idOfURL * URL_ALPHABET_LENGTH + symbolLocation;
        
    }
    
    return labs(idOfURL);
}

- (NSString*) reverseString:(NSString*) str {
    
    NSMutableString* reversed = [NSMutableString string];
    
    NSInteger charIndex = [str length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subRange = NSMakeRange(charIndex, 1);
        NSString* stringWithRange = [str substringWithRange:subRange];
        [reversed appendString:stringWithRange];
    }
    return reversed;
}

@end
