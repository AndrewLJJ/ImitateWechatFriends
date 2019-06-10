//
//  YMStringSize.h
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMStringSize : NSObject

//label自适应宽高
+ (CGSize)ym_sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW;

@end
