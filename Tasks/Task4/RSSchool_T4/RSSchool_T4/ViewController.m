#import "ViewController.h"
#import "PhoneNumberFormat.h"
#import "PhoneNumberFormatter.h"
#import "PhoneNumberRules.h"

@interface ViewController () <UITextFieldDelegate>
@property (retain, nonatomic) PhoneNumberFormat* globalFormat;
@property (retain, nonatomic) PhoneNumberFormatter* phoneFormatter;
@property (unsafe_unretained, nonatomic) UILabel* flagLabel;
@property (retain, nonatomic) PhoneNumberRules* phoneNumberRules;
@end

static NSString* const EMPTY_STRING = @"";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _phoneNumberRules = [[PhoneNumberRules alloc] init];
    
    _phoneFormatter = [[PhoneNumberFormatter alloc] init];
    UITextField* phoneNumberField = [self createTextFieldWithFrame:30 y:150 width:350 height:50 placeHolder:@"Input your number" keyBoardType:UIKeyboardTypePhonePad];
    phoneNumberField.delegate = self;
    [self.view addSubview:phoneNumberField];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(phoneNumberField.bounds.origin.x + 20, phoneNumberField.bounds.origin.y, 50, 50)];
    [phoneNumberField addSubview:label];
    self.flagLabel = label;
    [label release];
}

- (void)dealloc
{
    [_phoneFormatter release];
    [_globalFormat release];
    [_phoneNumberRules release];
    [super dealloc];
}

#pragma mark - Methods

- (UITextField*) createTextFieldWithFrame:
(CGFloat) x y:(CGFloat) y width:(CGFloat) width height:(CGFloat) height placeHolder:(NSString*) placeHolder keyBoardType:(UIKeyboardType) keyBoardType{
    
    UITextField* textField = [[[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)] autorelease];
    textField.keyboardType = keyBoardType;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.textColor = [UIColor blackColor];
    textField.backgroundColor = [UIColor clearColor];
    textField.layer.borderWidth = 1.f;
    textField.layer.cornerRadius = 30.f;
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.keyboardAppearance = UIKeyboardAppearanceLight;
    textField.placeholder = placeHolder;
    textField.delegate = self;
    textField.autocorrectionType = NO;
    return textField;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)inputString {
    
    NSString* fullPhoneNumber = [textField.text stringByReplacingCharactersInRange:range withString:inputString];
    if ([fullPhoneNumber length] == 0) {
        textField.text = EMPTY_STRING;
    }
    
    if ([fullPhoneNumber length] == 1) {
        NSArray* notValidComponents = [inputString componentsSeparatedByCharactersInSet:[[_phoneNumberRules getPphoneNumberSymbolsSet] invertedSet]];
        if ([[notValidComponents componentsJoinedByString:EMPTY_STRING] isEqualToString:@"+"]) {
            return YES;
        }
    } else {
        NSArray* notValidComponents = [inputString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
        if ([notValidComponents count] > 1) {
            return NO;
        }
    }
    
    NSString* decimalString = [[fullPhoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:EMPTY_STRING];
    
    if ([decimalString length] <= MAX_COUNTRY_CODE_LENGTH) {
        [self setFlagAndFormat:decimalString];
    }
    
    NSString* formatedString = [self getFormatedText:decimalString fullPhoneNumber:fullPhoneNumber];
    
    if (![formatedString isEqualToString:EMPTY_STRING]) {
        textField.text = formatedString;
    }
    
    return NO;
}

- (NSString*) getFormatedText:(NSString*) decimalPhoneNumber fullPhoneNumber:(NSString*) fullPhoneNumber {
    
    NSString* formatedString = EMPTY_STRING;
    
    NSString* plusPrefix = [[fullPhoneNumber componentsSeparatedByCharactersInSet:[[_phoneNumberRules getPlusSymbolSet] invertedSet]] componentsJoinedByString:EMPTY_STRING];
    
    if (_globalFormat != nil) {
        if ([decimalPhoneNumber length] <= _globalFormat.localNumberLength + _globalFormat.areaCodeLength + _globalFormat.countryCodeLength) {
            formatedString = [plusPrefix stringByAppendingString:[_phoneFormatter setFormatForPhohne:decimalPhoneNumber fullPhoneNumber:fullPhoneNumber globalFormat:_globalFormat]];
        }
    } else if ([decimalPhoneNumber length] <= MAX_PHONE_NUMBER_LENGTH){
        formatedString = [plusPrefix stringByAppendingString:decimalPhoneNumber];
    }
    
    return formatedString;
}

- (void) setFlagAndFormat:(NSString*) decimalString {
    
    PhoneNumberFormat* currentFormat = [[_phoneNumberRules getPhoneFormatForCountryCode] objectForKey:decimalString];
    
    if (currentFormat != nil) {
        _globalFormat = currentFormat;
        [self.flagLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:_globalFormat.country]]];
    } else if (_globalFormat != nil && _globalFormat.countryCodeLength > [decimalString length]) {
        _globalFormat = nil;
        [self.flagLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"white"]]];
    }
}



@end


