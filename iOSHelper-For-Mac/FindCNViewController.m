//
//  FindCNViewController.m
//  iOSHelper-For-Mac
//
//  Created by Fidetro on 2017/9/25.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#import "FindCNViewController.h"
#import "RegexHelper.h"
@interface FindCNViewController ()
@property (unsafe_unretained) IBOutlet NSTextView *leftTextView;
@property (unsafe_unretained) IBOutlet NSTextView *rightTextView;
@end

@implementation FindCNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)toPropertyAction:(NSButton *)sender {
    NSArray *cnArray = [RegexHelper matchString:self.leftTextView.string toRegexString:@"@\"(.+?)\""];
    NSArray *replaceArray = [self replaceRepeatStringWithArray:cnArray];
    NSMutableString *showString = [NSMutableString string];
    
    for (NSString *string in replaceArray) {
        [showString appendFormat:@"%@\n",string];
    }
    self.rightTextView.string = showString;
}

- (NSArray *)replaceRepeatStringWithArray:(NSArray *)array
{
    NSMutableArray *replaceArray = [NSMutableArray array];
    for (NSString *string in array)
    {
        if ([replaceArray containsObject:string])
        {
            continue;
        }
        else
        {
            [replaceArray addObject:string];
        }
    }
    return [replaceArray copy];
}

@end
