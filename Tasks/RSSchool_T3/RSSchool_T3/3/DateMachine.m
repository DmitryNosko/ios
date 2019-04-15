#import "DateMachine.h"
#import "ChangeDateCommand.h"
#import "CommandMeneger.h"

@interface DateMachine ()
@property (unsafe_unretained, nonatomic) UILabel* dateLabel;
@property (unsafe_unretained, nonatomic) UITextField* startDateTextField;
@property (unsafe_unretained, nonatomic) UITextField* stepTextField;
@property (unsafe_unretained, nonatomic) UITextField* dateUnitTextField;
@property (assign, nonatomic) NSInteger addOperationAmount;
@property (assign, nonatomic) NSInteger subOperationamount;
@property (assign, nonatomic) NSInteger allOperationsAmount;
@end

static NSString* const DATE_FORMAT = @"dd/MM/yyyy HH:mm";
static NSString* const EMPTY_STRING = @"";
@implementation DateMachine
- (instancetype)init
{
    self = [super init];
    if (self) {
        _addOperationAmount = 0;
        _subOperationamount = 0;
        _allOperationsAmount = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField* startDate = [self createTextFieldWithFrame:50 y:150 width:320 height:30 returnKeyType:UIReturnKeyNext placeHolder:@"Start date" tag:1 keyBoardType:UIKeyboardTypeASCIICapable];
    [self.view addSubview:startDate];
    self.startDateTextField = startDate;
    
    UITextField* step = [self createTextFieldWithFrame:50 y:200 width:320 height:30 returnKeyType:UIReturnKeyNext placeHolder:@"Step" tag:2 keyBoardType:UIKeyboardTypeNumbersAndPunctuation];
    [self.view addSubview:step];
    self.stepTextField = step;
    
    UITextField* dateUnit = [self createTextFieldWithFrame:50 y:250 width:320 height:30 returnKeyType:UIReturnKeyDone placeHolder:@"Date unit" tag:3 keyBoardType:UIKeyboardTypeASCIICapable];
    [self.view addSubview:dateUnit];
    self.dateUnitTextField = dateUnit;
    
    UIButton* addButton = [self createButtonWithFrame:50 y:400 width:100 height:100 buttonType:UIButtonTypeCustom normalState:@"Add" highlightedState:@"Done"];
    [addButton addTarget:self action:@selector(addDateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton* subButton = [self createButtonWithFrame:270 y:400 width:100 height:100 buttonType:UIButtonTypeCustom normalState:@"Sub" highlightedState:@"Done"];
    [subButton addTarget:self action:@selector(subDateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subButton];
    
    
    UILabel* dateLabel = [self createLabelWithFrame:50 y:50 width:320 height:30 backColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter textColor:[UIColor whiteColor]];
    [self.view addSubview:dateLabel];
    self.dateLabel = dateLabel;
    self.dateLabel.text = [self p_currentDate];
    
}

#pragma mark - Actions

- (void) changeDate:(NSString*) fromString isAdd:(BOOL) isAdd {
    NSInteger valueToProcess = isAdd ? [self.stepTextField.text integerValue] : -[self.stepTextField.text integerValue];
    
    id<ChangeDateCommand> dateCommand = [[[[CommandMeneger alloc] init] autorelease] getCommand:[self.dateUnitTextField.text lowercaseString]];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:DATE_FORMAT];
    NSDate* changedDate = [dateCommand changeDate:[formatter dateFromString:fromString] withValue:valueToProcess];
    self.dateLabel.text = [self p_stringFromDate:changedDate];
    self.startDateTextField.text = [self p_stringFromDate:changedDate];
}

- (void) addDateAction:(UIButton*) button {
    [self actionForButton:YES operationCounter:_addOperationAmount];
}

- (void) subDateAction:(UIButton*) button {
    [self actionForButton:NO operationCounter:_subOperationamount];
}

- (void) actionForButton:(BOOL) isAdd operationCounter:(NSInteger) operationAmount {
    
    if ([self.startDateTextField.text isEqualToString:EMPTY_STRING]) {
        [self changeDate:self.dateLabel.text isAdd:isAdd];
    } else if (!([self.startDateTextField.text isEqualToString:EMPTY_STRING]) && operationAmount == 0 && _allOperationsAmount == 0){
        [self changeDate:self.startDateTextField.text isAdd:isAdd];
        operationAmount++;
        _allOperationsAmount++;
    } else {
        [self changeDate:self.dateLabel.text isAdd:isAdd];
    }
    
}


#pragma mark - CreateElemets

- (UITextField*) createTextFieldWithFrame:
(CGFloat) x y:(CGFloat) y width:(CGFloat) width height:(CGFloat) height
                            returnKeyType:(UIReturnKeyType) returnKeyType placeHolder:(NSString*) placeHolder tag:(NSInteger) tag keyBoardType:(UIKeyboardType) keyBoardType{
    
    UITextField* textField = [[[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)] autorelease];
    textField.keyboardType = keyBoardType;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.textColor = [UIColor whiteColor];
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.keyboardAppearance = UIKeyboardAppearanceLight;
    textField.returnKeyType = returnKeyType;
    textField.tag = tag;
    textField.placeholder = placeHolder;
    textField.delegate = self;
    textField.autocorrectionType = NO;
    return textField;
}

- (UIButton*) createButtonWithFrame:(CGFloat) x y:(CGFloat) y width:(CGFloat) width height:(CGFloat) height buttonType:(UIButtonType) buttonType normalState:(NSString*) normalState highlightedState:(NSString*)highlightedState {
    UIButton* button = [UIButton buttonWithType:buttonType];
    button.frame = CGRectMake(x, y, width, height);
    [button setTitle:normalState forState:UIControlStateNormal];
    [button setTitle:highlightedState forState:UIControlStateHighlighted];
    button.backgroundColor = [UIColor lightGrayColor];
    return button;
}

- (UILabel*) createLabelWithFrame:(CGFloat) x y:(CGFloat) y width:(CGFloat) width height:(CGFloat) height  backColor:(UIColor*) backColor textAligment:(NSTextAlignment) textAligment textColor:(UIColor*) textColor {
    UILabel* label = [[[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)] autorelease];
    label.backgroundColor = backColor;
    label.textColor = textColor;
    label.textAlignment = textAligment;
    return label;
}

#pragma mark - UITextFieldDelegate

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    BOOL isValid = YES;
    
    if (textField.tag == 2) {
        return ([string substringFromIndex:0].integerValue || [[string substringFromIndex:0] isEqualToString:@"0"]);
    }
    
    if (textField.tag == 3) {
        NSArray* components = [string componentsSeparatedByCharactersInSet:[NSCharacterSet letterCharacterSet]];
        return [components count] > 1;
    }
    
    return isValid;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.startDateTextField]) {
        [self.stepTextField becomeFirstResponder];
    } else if ([textField isEqual:self.stepTextField]){
        [self.dateUnitTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - Date methods

- (NSString*) p_stringFromDate:(NSDate*) date {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:DATE_FORMAT];
    return [formatter stringFromDate:date];
}

- (NSString*) p_currentDate {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:DATE_FORMAT];
    return [formatter stringFromDate:[NSDate date]];
}

- (void)dealloc
{
    [_dateLabel release];
    [_startDateTextField release];
    [_stepTextField release];
    [_dateUnitTextField release];
    [super dealloc];
}

@end
