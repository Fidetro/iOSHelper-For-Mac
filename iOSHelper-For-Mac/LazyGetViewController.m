//
//  LazyGetViewController.m
//  iOSHelper-For-Mac
//
//  Created by Fidetro on 2017/9/25.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#import "LazyGetViewController.h"
#import <objc/runtime.h>
#import "RegexHelper.h"
#import "CustomTextView.h"
@interface LazyGetViewController ()
@property (unsafe_unretained) IBOutlet CustomTextView *leftTextView;
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

@implementation LazyGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftTextView.placeholderAttributedString = [[NSAttributedString alloc] initWithString:@"@property (nonatomic, strong) UIButton *button;\n@property (nonatomic, strong) UILabel *label;\n@property (nonatomic, strong) UIImageView *imageView;" attributes:@{NSForegroundColorAttributeName:[NSColor placeholderTextColor],NSFontAttributeName:self.leftTextView.font == nil ? [NSFont systemFontOfSize:15] : self.leftTextView.font}];
}
- (IBAction)clickAction:(id)sender {
    NSArray *classNames = [RegexHelper matchString:self.leftTextView.string toRegexString:@"\\)(.+?)\\*"];
    NSArray *propertyNames = [RegexHelper matchString:self.leftTextView.string toRegexString:@"\\*(.+?)\\;"];
    
    NSString *getStrings = [NSString string];
    NSMutableString *addSubviewString = [NSMutableString string];
    for (NSInteger index = 0; index < classNames.count; index++) {
        NSString *className = classNames[index];
        NSString *propertyName = propertyNames[index];
        
        NSString *headString = [NSString stringWithFormat:@"- (%@ *)%@\r{\r    if(!_%@)\r    {\r",className,propertyName,propertyName];
        NSString *contentString = [NSString stringWithFormat:@"        _%@ = [[%@ alloc] init];\r",propertyName,className];
        contentString = [self setViewStyleWithContentString:contentString propertyName:propertyName className:className];
        [addSubviewString appendFormat:@"%@\r",[self isAddSubviewPropertyName:propertyName]];
        NSString *footString = [NSString stringWithFormat:@"    }\r    return _%@;\r}",propertyName];
        
        getStrings = [NSString stringWithFormat:@"%@%@%@%@\r",getStrings,headString,contentString,footString];
        
    }
    self.rightTextView.string = [addSubviewString length] == 0 ? getStrings : [NSString stringWithFormat:@"%@\r\r\r\r\r\r\r%@",getStrings,addSubviewString];
    
}

- (NSString *)setViewStyleWithContentString:(NSString *)contentString propertyName:(NSString *)propertyName className:(NSString *)className{
    
    NSString *setCodeString = @"";
    
    if ([className isEqualToString:@"UIButton"])
    {
        if (self.checkBoxButtonTitleNor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@ setTitle:<#(nullable NSString *)#> forState:UIControlStateNormal];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonTitleSel.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@ setTitle:<#(nullable NSString *)#> forState:UIControlStateSelected];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonImageNor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@ setImage:<#(nullable UIImage *)#> forState:UIControlStateNormal];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonImageSel.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@ setImage:<#(nullable UIImage *)#> forState:UIControlStateSelected];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonTitleColorNor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@ setTitleColor:<#(nullable UIColor *)#> forState:UIControlStateNormal];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonTitleColorSel.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@ setTitleColor:<#(nullable UIColor *)#> forState:UIControlStateSelected];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonTitleFont.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@.titleLabel setFont:<#(UIFont * _Nullable)#>];\r",setCodeString,propertyName];
        }
        if (self.checkBoxButtonBgColor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@ setBackgroundColor:<#(UIColor * _Nullable)#>];\r",setCodeString,propertyName];
        }
        if (self.checkBoxBgImageNor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@ setBackgroundImage:<#(nullable UIImage *)#> forState:UIControlStateNormal];\r",setCodeString,propertyName];
        }
        if (self.checkBoxBgImageSel.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@ setBackgroundImage:<#(nullable UIImage *)#> forState:UIControlStateSelected];\r",setCodeString,propertyName];
        }
    }else if ([className isEqualToString:@"UILabel"])
    {
        if (self.checkBoxLabelFont.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@ setFont:<#(UIFont * _Nullable)#>];\r",setCodeString,propertyName];
        }
        if (self.checkBoxLabelTextColor.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@[_%@ setTextColor:<#(UIColor * _Nullable)#>];\r",setCodeString,propertyName];
        }
        if (self.checkBoxLabelText.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@_%@.text = <#text#>;\r",setCodeString,propertyName];
        }
    }else if ([className isEqualToString:@"UIImageView"])
    {
        if (self.checkBoxImageViewImage.state == 1)
        {
            setCodeString = [NSString stringWithFormat:@"%@_%@.image = [UIImage imageNamed:<#(nonnull NSString *)#>];\r",setCodeString,propertyName];
        }
    }
    
    else{
        return contentString;
    }
    contentString = [NSString stringWithFormat:@"%@        %@",contentString,setCodeString];
    return contentString;
}



- (NSString *)isAddSubviewPropertyName:(NSString *)propertyName{
    NSString *superViewString = @"";
    if (self.checkBoxSelf.state == 0 && self.checkBoxSelfView.state == 0 &&self.checkBoxSelfContent.state == 0) {
        return superViewString;
    }else if (self.checkBoxSelf.state == 1){
        superViewString = [NSString stringWithFormat:@"[self addSubview:self.%@];",propertyName];
    }else if (self.checkBoxSelfView.state == 1){
        superViewString = [NSString stringWithFormat:@"[self.view addSubview:self.%@];",propertyName];
    }else if (self.checkBoxSelfContent.state == 1){
        superViewString = [NSString stringWithFormat:@"[self.contentView addSubview:self.%@];",propertyName];
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
