//
//  XHUIFactory.m
//  Perfect_food
//
//  Created by qianfeng on 16/1/16.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "XHUIFactory.h"

@implementation XHUIFactory

+ (UIButton *)creatBtnWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action{

    //创建btn
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    return button;
}
/**
 * 计算size的方法
 */
+ (CGSize)calculateSizeByText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}
/**
 *  XMLTool
 */
//+ (NSDictionary *)dictWithXMLElement:(ONOXMLElement *)element{
//    
//    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
//    
//    for (ONOXMLElement *tempE in element.children) {
//        
//        NSString *key = tempE.tag;
//        id value = tempE.stringValue;
//        
//        if (tempE.children.count > 1) {
//            
//            NSMutableArray *mArray = [NSMutableArray new];
//            
//            for (ONOXMLElement *elem in tempE.children) {
//                
//                
//                NSDictionary *rstDict = [self dictWithXMLElement:elem];
//                
//                if (rstDict.count) {
//                    
//                    [mArray addObject:rstDict];
//                }
//                else{
//                
//                    [mArray addObject:elem.stringValue];
//                }
//          
//            }
//            
//            value = mArray;
//        }
//        
//        [mDict setObject:value forKey:key];
//        
//    }
//    
//    return mDict;
//
//}
@end
