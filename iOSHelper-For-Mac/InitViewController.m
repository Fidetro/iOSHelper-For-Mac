//
//  InitViewController.m
//  iOSHelper-For-Mac
//
//  Created by Fidetro on 2018/7/6.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

#import "InitViewController.h"
#import "RegexHelper.h"
@interface InitViewController ()
@property (unsafe_unretained) IBOutlet NSTextView *leftTextView;
@property (unsafe_unretained) IBOutlet NSTextView *rightTextView;

@property (weak) IBOutlet NSButton *checkBoxSelfView;
@property (weak) IBOutlet NSButton *checkBoxSelf;
@property (weak) IBOutlet NSButton *checkBoxSelfContent;

@property (weak) IBOutlet NSButton *checkBoxLabelFont;
@property (weak) IBOutlet NSButton *checkBoxLabelTextColor;
@property (weak) IBOutlet NSButton *checkBoxLabelText;
@property (weak) IBOutlet NSButton *checkBoxImageViewImage;

@property (weak) IBOutlet NSButton *checkBoxButtonTitleNor;
@property (weak) IBOutlet NSButton *checkBoxButtonTitleSel;
@property (weak) IBOutlet NSButton *checkBoxButtonImageNor;
@property (weak) IBOutlet NSButton *checkBoxButtonImageSel;
@property (weak) IBOutlet NSButton *checkBoxButtonTitleColorNor;
@property (weak) IBOutlet NSButton *checkBoxButtonTitleColorSel;
@property (weak) IBOutlet NSButton *checkBoxButtonTitleFont;
@property (weak) IBOutlet NSButton *checkBoxButtonBgColor;
@property (weak) IBOutlet NSButton *checkBoxBgImageNor;
@property (weak) IBOutlet NSButton *checkBoxBgImageSel;
@end

@implementation InitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (IBAction)clickAction:(id)sender {
    NSArray *classNames = [RegexHelper matchString:self.leftTextView.string toRegexString:@"\\)(.+?)\\*"];
    NSArray *propertyNames = [RegexHelper matchString:self.leftTextView.string toRegexString:@"\\*(.+?)\\;"];
    
    NSString *getStrings = [NSString string];
    NSMutableString *useFunctionString = [NSMutableString string];
    for (NSInteger index = 0; index < classNames.count; index++) {
        NSString *className = classNames[index];
        NSString *propertyName = propertyNames[index];
        
        NSString *firstLetter = [propertyName substringToIndex:1];
        NSString *upFirstLetter = [firstLetter uppercaseString];
        NSString *functionName = [NSString stringWithFormat:@"setup%@%@",upFirstLetter,[propertyName substringWithRange:NSMakeRange(1, propertyName.length-1)]];
        [useFunctionString appendFormat:@"[self %@];\r",functionName];
        NSString *headString = [NSString stringWithFormat:@"- (void)%@\r{",functionName];
        NSString *contentString = [NSString stringWithFormat:@"\r   self.%@ = [[%@ alloc] init];\r",propertyName,className];
        contentString = [self setViewStyleWithContentString:contentString propertyName:propertyName className:className];
        contentString = [NSString stringWithFormat:@"%@%@",contentString,[self isAddSubviewPropertyName:propertyName]];
//        [addSubviewString appendFormat:@"%@\r",[self isAddSubviewPropertyName:propertyName]];
        NSString *footString = @"}";
        
        getStrings = [NSString stringWithFormat:@"%@%@%@%@\r\r",getStrings,headString,contentString,footString];
        
    }
    self.rightTextView.string = [NSString stringWithFormat:@"%@\r\r%@",useFunctionString,getStrings];
    
}

- (NSString *)setViewStyleWithContentString:(NSString *)contentString propertyName:(NSString *)propertyName className:(NSString *)className{
    
    NSString *setCodeString = @"";
    
    if ([className isEqualToString:@"UIButton"])
    {
        if (self.checkBoxButtonTitleNor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@ setTitle:<#(nullable NSString *)#> forState:UIControlStateNormal];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonTitleSel.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@ setTitle:<#(nullable NSString *)#> forState:UIControlStateSelected];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonImageNor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@ setImage:<#(nullable UIImage *)#> forState:UIControlStateNormal];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonImageSel.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@ setImage:<#(nullable UIImage *)#> forState:UIControlStateSelected];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonTitleColorNor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@ setTitleColor:<#(nullable UIColor *)#> forState:UIControlStateNormal];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonTitleColorSel.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@ setTitleColor:<#(nullable UIColor *)#> forState:UIControlStateSelected];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonTitleFont.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@.titleLabel setFont:<#(UIFont * _Nullable)#>];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonBgColor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@ setBackgroundColor:<#(UIColor * _Nullable)#>];\r",setCodeString,propertyName];
        }
        if (self.checkBoxBgImageNor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@ setBackgroundImage:<#(nullable UIImage *)#> forState:UIControlStateNormal];\r",setCodeString,propertyName];
        }
        if (self.checkBoxBgImageSel.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@ setBackgroundImage:<#(nullable UIImage *)#> forState:UIControlStateSelected];\r",setCodeString,propertyName];
        }
    }else if ([className isEqualToString:@"UILabel"])
    {
        if (self.checkBoxLabelFont.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@ setFont:<#(UIFont * _Nullable)#>];\r",setCodeString,propertyName];
        }
        if (self.checkBoxLabelTextColor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   [self.%@ setTextColor:<#(UIColor * _Nullable)#>];\r",setCodeString,propertyName];
        }
        if (self.checkBoxLabelText.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   self.%@.text = <#text#>;\r",setCodeString,propertyName];
        }
    }else if ([className isEqualToString:@"UIImageView"])
    {
        if (self.checkBoxImageViewImage.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@   self.%@.image = [UIImage imageNamed:<#(nonnull NSString *)#>];\r",setCodeString,propertyName];
        }
    }
    
    else{
        return contentString;
    }
    contentString = [NSString stringWithFormat:@"%@%@",contentString,setCodeString];
    return contentString;
}



- (NSString *)isAddSubviewPropertyName:(NSString *)propertyName{
    NSString *superViewString = @"";
    if (self.checkBoxSelf.state == 0 && self.checkBoxSelfView.state == 0 &&self.checkBoxSelfContent.state == 0) {
        return superViewString;
    }else if (self.checkBoxSelf.state == 1){
        superViewString = [NSString stringWithFormat:@"   [self addSubview:self.%@];\r",propertyName];
    }else if (self.checkBoxSelfView.state == 1){
        superViewString = [NSString stringWithFormat:@"   [self.view addSubview:self.%@];\r",propertyName];
    }else if (self.checkBoxSelfContent.state == 1){
        superViewString = [NSString stringWithFormat:@"   [self.contentView addSubview:self.%@];\r",propertyName];
    }
    
    return superViewString;
}

- (IBAction)selectAddViewAction:(NSButton *)sender {
    
    self.checkBoxSelf.state = 0;
    self.checkBoxSelfContent.state = 0;
}
- (IBAction)selectAddSelfAction:(NSButton *)sender {
    self.checkBoxSelfView.state = 0;
    
    self.checkBoxSelfContent.state = 0;
}
- (IBAction)selectAddSubviewContentAction:(NSButton *)sender {
    self.checkBoxSelfView.state = 0;
    self.checkBoxSelf.state = 0;
    
}

@end
