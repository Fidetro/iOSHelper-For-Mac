//
//  CellCodeViewController.m
//  iOSHelper-For-Mac
//
//  Created by Fidetro on 2017/9/25.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#import "CellCodeViewController.h"
#import "RegexHelper.h"
@interface CellCodeViewController ()
@property (unsafe_unretained) IBOutlet NSTextView *leftTextView;
@property (unsafe_unretained) IBOutlet NSTextView *rightTextView;
@property (weak) IBOutlet NSTextField *typeTextField;
@end

@implementation CellCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)toCellAction:(NSButton *)sender {
    NSString *classname = [[RegexHelper matchString:self.leftTextView.string toRegexString:@"@interface(.+?):"]firstObject];
    NSString *superClassname = [[RegexHelper matchString:self.leftTextView.string toRegexString:@":(.+?)$"]firstObject];
    classname = [classname stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *type = [self.typeTextField.stringValue length] == 0 ? self.leftTextView.string : self.typeTextField.stringValue;
    if ([type containsString:@"UITableViewCell"])
    {
        [self tableViewCellStringWithClassName:classname superClassName:superClassname];
        
    }
    else if ([type containsString:@"UITableViewHeaderFooterView"])
    {
        [self tableViewHeaderFooterViewStringWithClassName:classname superClassName:superClassname];
    }
    else if ([type containsString:@"UICollectionReusableView"])
    {
        [self collectionReusableViewStringWithClassName:classname superClassName:superClassname];
    }
    else if ([type containsString:@"UICollectionViewCell"])
    {
        [self collectionViewCellStringWithClassName:classname superClassName:superClassname];
    }
    else
    {
        [self tableViewCellStringWithClassName:classname superClassName:superClassname];
    }
    
}
- (void)collectionReusableViewStringWithClassName:(NSString *)classname
                                   superClassName:(NSString *)superClassName
{
    NSString *indentifier = [NSString stringWithFormat:@"k%@Identifier",classname];
    NSString *interfaceIdentifier = [NSString stringWithFormat:@"extern NSString *const %@;",indentifier];
    NSString *interfacename = [NSString stringWithFormat:@"@interface %@ : %@\n\n \n\n@end",classname,superClassName];
    NSString *constString = [NSString stringWithFormat:@"NSString *const %@ = @\"%@\";",indentifier,indentifier];
    NSString *implementationString = [NSString stringWithFormat:@"@implementation %@",classname];
    NSString *initString = [NSString stringWithFormat:@"- (instancetype)initWithFrame:(CGRect)frame\n{\nself = [super initWithFrame:frame];\nif (self)\n{\nself.backgroundColor = [UIColor clearColor];\n[self masLayoutSubview];\n}\nreturn self;\n}"];
    NSString *masString = [NSString stringWithFormat:@"- (void)masLayoutSubview\n{\n}"];
    self.rightTextView.string = [NSString stringWithFormat:@"%@\n%@\n\n\n\n\n\n%@\n%@\n\n\n%@\n\n%@",interfaceIdentifier,interfacename,constString,implementationString,initString,masString];
}

- (void)collectionViewCellStringWithClassName:(NSString *)classname
                               superClassName:(NSString *)superClassName
{
    NSString *indentifier = [NSString stringWithFormat:@"k%@Identifier",classname];
    NSString *interfaceIdentifier = [NSString stringWithFormat:@"extern NSString *const %@;",indentifier];
    NSString *interfacename = [NSString stringWithFormat:@"@interface %@ : %@\n\n \n\n@end",classname,superClassName];
    NSString *constString = [NSString stringWithFormat:@"NSString *const %@ = @\"%@\";",indentifier,indentifier];
    NSString *implementationString = [NSString stringWithFormat:@"@implementation %@",classname];
    NSString *initString = [NSString stringWithFormat:@"- (instancetype)initWithFrame:(CGRect)frame\n{\nself = [super initWithFrame:frame];\nif (self)\n{\nself.contentView.backgroundColor = [UIColor clearColor];\n[self masLayoutSubview];\n}\nreturn self;\n}"];
    NSString *masString = [NSString stringWithFormat:@"- (void)masLayoutSubview\n{\n}"];
    self.rightTextView.string = [NSString stringWithFormat:@"%@\n%@\n\n\n\n\n\n%@\n%@\n\n\n%@\n\n%@",interfaceIdentifier,interfacename,constString,implementationString,initString,masString];
}
- (void)tableViewHeaderFooterViewStringWithClassName:(NSString *)classname
                                      superClassName:(NSString *)superClassName
{
    NSString *indentifier = [NSString stringWithFormat:@"k%@Identifier",classname];
    NSString *interfaceIdentifier = [NSString stringWithFormat:@"extern NSString *const %@;",indentifier];
    NSString *interfacename = [NSString stringWithFormat:@"@interface %@ : %@\n\n+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;\n\n@end",classname,superClassName];
    NSString *constString = [NSString stringWithFormat:@"NSString *const %@ = @\"%@\";",indentifier,indentifier];
    NSString *implementationString = [NSString stringWithFormat:@"@implementation %@",classname];
    NSString *dequeueString = [NSString stringWithFormat:@"+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView\n{\n%@ *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:%@];\n if (view == nil)\n{\nview = [[%@ alloc]initWithReuseIdentifier:%@];\n}\nreturn view;\n}",classname,indentifier,classname,indentifier];
    NSString *initString = [NSString stringWithFormat:@"- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier\n{\nself = [super initWithReuseIdentifier:%@];\nif (self)\n{\nself.contentView.backgroundColor = [UIColor clearColor];\n[self masLayoutSubview];\n}\nreturn self;\n}",indentifier];
    NSString *masString = [NSString stringWithFormat:@"- (void)masLayoutSubview\n{\n}"];
    self.rightTextView.string = [NSString stringWithFormat:@"%@\n%@\n\n\n\n\n\n%@\n%@\n\n%@\n\n%@\n\n%@",interfaceIdentifier,interfacename,constString,implementationString,dequeueString,initString,masString];
}

- (void)tableViewCellStringWithClassName:(NSString *)classname
                          superClassName:(NSString *)superClassName
{
    NSString *indentifier = [NSString stringWithFormat:@"k%@Identifier",classname];
    NSString *interfaceIdentifier = [NSString stringWithFormat:@"extern NSString *const %@;",indentifier];
    NSString *interfacename = [NSString stringWithFormat:@"@interface %@ : %@\n\n+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;\n\n@end",classname,superClassName];
    NSString *constString = [NSString stringWithFormat:@"NSString *const %@ = @\"%@\";",indentifier,indentifier];
    NSString *implementationString = [NSString stringWithFormat:@"@implementation %@",classname];
    NSString *dequeueString = [NSString stringWithFormat:@"+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView\n{\n%@ *cell = [tableView dequeueReusableCellWithIdentifier:%@];\n if (cell == nil)\n{\ncell = [[%@ alloc]init];\n}\nreturn cell;\n}",classname,indentifier,classname];
    NSString *initString = [NSString stringWithFormat:@"- (instancetype)init\n{\nself = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:%@];\nif (self)\n{\nself.selectionStyle = UITableViewCellSelectionStyleNone;\nself.backgroundColor = [UIColor clearColor];\n[self masLayoutSubview];\n}\nreturn self;\n}",indentifier];
    NSString *masString = [NSString stringWithFormat:@"- (void)masLayoutSubview\n{\n}"];
    self.rightTextView.string = [NSString stringWithFormat:@"%@\n%@\n\n\n\n\n\n%@\n%@\n\n%@\n\n%@\n\n%@",interfaceIdentifier,interfacename,constString,implementationString,dequeueString,initString,masString];
}


@end
