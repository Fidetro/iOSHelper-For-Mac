//
//  JSONToPropertyViewController.m
//  iOSHelper-For-Mac
//
//  Created by Fidetro on 2017/9/25.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#import "JSONToPropertyViewController.h"
#import "RegexHelper.h"
@interface JSONToPropertyViewController ()
@property (unsafe_unretained) IBOutlet NSTextView *leftTextView;
@property (unsafe_unretained) IBOutlet NSTextView *rightTextView;

@end

@implementation JSONToPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (IBAction)toPropertyAction:(NSButton *)sender {
    
    
    NSArray *propertyNames = [RegexHelper matchString:self.leftTextView.string toRegexString:@"\"(.+?)\":"];
    NSDictionary *jsonDic = [self jsonStringToDictionary:self.leftTextView.string];
    NSString *string = [NSString string];
    
    for (NSString *propertyName in propertyNames) {
        
        if (jsonDic[propertyName] != nil) {
            
            if ([jsonDic[propertyName] isKindOfClass:[NSDictionary class]]) {
                string = [NSString stringWithFormat:@"%@/** <#Description#> **/\n@property(nonatomic,strong) NSDictionary *%@;\n",string,propertyName];
            }else if ([jsonDic[propertyName] isKindOfClass:[NSArray class]]){
                string = [NSString stringWithFormat:@"%@/** <#Description#> **/\n@property(nonatomic,strong) NSArray *%@;\n",string,propertyName];
            }else if ([jsonDic[propertyName] isKindOfClass:[NSNumber class]]){
                string = [NSString stringWithFormat:@"%@/** <#Description#> **/\n@property(nonatomic,strong) NSNumber *%@;\n",string,propertyName];
            }else {
                string = [NSString stringWithFormat:@"%@/** <#Description#> **/\n@property(nonatomic,copy) NSString *%@;\n",string,propertyName];
            }
            
        }
        
    }
    
    if ([string length] != 0) {
        self.rightTextView.string = string;
    }
    
}

- (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString {
    
    
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingAllowFragments
                         
                                                          error:&error];
    
    if(error) {
        
        self.rightTextView.string = [NSString stringWithFormat:@"%@",error];
        NSLog(@"json解析失败：%@",error);
        
        return nil;
        
    }
    
    return dic;
    
}



@end
