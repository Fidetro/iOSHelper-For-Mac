//
//  RegexHelper.m
//  iOSHelper-For-Mac
//
//  Created by Fidetro on 2017/9/25.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#import "RegexHelper.h"

@implementation RegexHelper
+ (NSArray *)matchString:(NSString *)string toRegexString:(NSString *)regexStr
{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray * matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSTextCheckingResult *match in matches) {
        
        for (int i = 1; i < [match numberOfRanges]; i++) {
            
            NSString *component = [string substringWithRange:[match rangeAtIndex:i]];
            component = [component stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除空格
            [array addObject:component];
            
        }
        
    }
    
    return array;
}
@end
