//
//  XHTextField.m
//  jianzhi
//
//  Created by qianfeng on 16/2/20.
//  Copyright © 2016年 JXH. All rights reserved.
//

#import "XHTextField.h"


@implementation XHTextField


- (CGRect)placeholderRectForBounds:(CGRect)bounds{

    CGRect rect = bounds;
    rect.origin.x += JPedding;
    
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
  
    CGRect rect = bounds;
    rect.origin.x += JPedding;
    
    return rect;

}

- (CGRect)textRectForBounds:(CGRect)bounds{
   
    CGRect rect = bounds;
    rect.origin.x += JPedding;
    
    return rect;
}




@end
