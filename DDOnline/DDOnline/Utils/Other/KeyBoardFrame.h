//
//  KeyBoardFrame.h
//  Perfect_food
//
//  Created by Aaron on 2/5/16.
//  Copyright © 2016 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface KeyBoardFrame : NSObject
singleton_h(keyBoardF)
/**
 *  键盘的y值
 */
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat height;
@end
