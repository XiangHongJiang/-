//
//  KeyBoardFrame.m
//  Perfect_food
//
//  Created by Aaron on 2/5/16.
//  Copyright © 2016 叶无道. All rights reserved.
//

#import "KeyBoardFrame.h"
#import <UIKit/UIKit.h>
@implementation KeyBoardFrame
singleton_m(keyBoardF)

- (void)saveY:(NSNotification *)notification
{
    KeyBoardFrame *frame = [KeyBoardFrame sharedkeyBoardF];
    NSDictionary * info = notification.userInfo;
    
    CGRect rect =  [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];//结束时键盘的frame位置

    frame.y = rect.origin.y;
    NSLog(@"%f",frame.y);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.height = rect.size.height;
    });
}
@end
