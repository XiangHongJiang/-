//
//  UIViewController+SpliteView.m
//  UIday18-网络数据请求
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 JXH. All rights reserved.
//

#import "UIViewController+SpliteView.h"
#import <objc/runtime.h>

@interface UIViewController()

/**
 *  记录当前展开状态
 */
@property (nonatomic, assign) BOOL expan;

@end

const char *key;

@implementation UIViewController (SpliteView)

//- (void)spliteView{
//
//    static int i = 0;
//    
//    if (i % 2 == 0) {
//        
//        self.view.transform = CGAffineTransformMakeTranslation(200, 0);
//        
//        i = 0;
//    }
//    else{
//    
//        self.view.transform = CGAffineTransformIdentity;
//        
//        i = 1;
//    }
//    
//    i++;
//    
//}

- (void)spliteView{

    if ((self.expan = !self.expan)) {
        
        self.view.transform = CGAffineTransformMakeTranslation(JScreenWidth - JTopSpace - JTabBarHeight, 0);

    }
    else{
    
        self.view.transform = CGAffineTransformIdentity;

    }

}

-(void)setExpan:(BOOL)expan{

    objc_setAssociatedObject(self, &key, @(expan), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)expan{

    return [objc_getAssociatedObject(self, &key) boolValue];
}

@end
