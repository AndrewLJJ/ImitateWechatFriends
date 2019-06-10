//
//  YMPhotoGroup.h
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMPhotoGroup : UIView

/* 外界传入的图片 */
@property (nonatomic, strong) NSArray *photoItemArray;

+ (CGSize)ym_sizeWithCount:(NSUInteger)count;

@end
