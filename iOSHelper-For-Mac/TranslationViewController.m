//
//  TranslationViewController.m
//  iOSHelper-For-Mac
//
//  Created by Fidetro on 2017/9/25.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#import "TranslationViewController.h"

@interface TranslationViewController ()
@property (unsafe_unretained) IBOutlet NSTextView *leftTextView;
@property (unsafe_unretained) IBOutlet NSTextView *rightTextView;
@end

@implementation TranslationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)toPropertyAction:(NSButton *)sender {
    NSString *string = self.leftTextView.string;
    NSMutableArray *array = [NSMutableArray array];
    NSMutableString *showString = [NSMutableString string];

    for (NSString *str in [string componentsSeparatedByString:@"\n"])
    {
        if (![str isEqualToString:@""])
        {
            [array addObject:str];
        }
    }
    if (array.count%2 != 0)
    {
        self.rightTextView.string = @"有缺少没对齐的翻译";
        return;
    }
    for (int i = 0; i < array.count/2; i++)
    {
        [showString appendFormat:@"\"%@\" = \"%@\";\n",array[i*2],array[i*2+1]];
    }
    self.rightTextView.string = [showString copy];
    
}

@end
