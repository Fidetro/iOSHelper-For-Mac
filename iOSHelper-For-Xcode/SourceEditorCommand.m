//
//  SourceEditorCommand.m
//  iOSHelper-For-Xcode
//
//  Created by Fidetro on 2018/12/21.
//  Copyright © 2018 Fidetro. All rights reserved.
//

#import "SourceEditorCommand.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    
    completionHandler(nil);
}

@end
