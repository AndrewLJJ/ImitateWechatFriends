//
//  YMFamilyGroup.h
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMFamilyGroup : NSObject

@property (strong,nonatomic) NSString *icon;  //头像
@property (strong,nonatomic) NSString *name;  //昵称
@property (strong,nonatomic) NSString *shuoshuoText; //说说
@property (strong,nonatomic) NSString *time;    //发表的时间,存的是nadate，应该要有时间操作
@property (strong,nonatomic) NSArray *pictures;   //发表的图片
@property (strong,nonatomic) NSArray *replys;   //评论

@end
