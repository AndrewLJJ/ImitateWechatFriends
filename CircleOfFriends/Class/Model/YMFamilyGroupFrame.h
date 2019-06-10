//
//  YMFamilyGroupFrame.h
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YMFamilyGroup;

@interface YMFamilyGroupFrame : NSObject

/* originalView */
@property (nonatomic, assign) CGRect originalView;
/* 头像 */
@property (nonatomic, assign) CGRect photo;
/* 用户名 */
@property (nonatomic, assign) CGRect nameL;
/* 内容 */
@property (nonatomic, assign) CGRect contentL;
/* cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/* 配图 */
@property (nonatomic, assign) CGRect photoGroup;
/* 时间 */
@property (nonatomic, assign) CGRect timeL;
/* 回复 */
@property (nonatomic, assign) CGRect replyBtn;
/* UItableView */
@property (nonatomic, assign) CGRect tableView;
/* 缓存评论数据 */
@property (nonatomic, strong) NSMutableArray *replyData;



/* 数据 */
@property (nonatomic, strong) YMFamilyGroup *familyGroup;


@end
