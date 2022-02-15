//
//  CustomTextView.h
//  iOSHelper-For-Mac
//
//  Created by karimzhang on 2022/2/15.
//  Copyright © 2022 Fidetro. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTextView : NSTextView

@property (nonatomic, strong) NSAttributedString *placeholderAttributedString;
@end

NS_ASSUME_NONNULL_END
