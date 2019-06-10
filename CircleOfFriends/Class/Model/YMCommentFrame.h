//
//  YMCommentFrame.h
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/4.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMCommentFrame : NSObject

/* originalView */
@property (nonatomic, assign) CGRect originalView;
/* 内容 */
@property (nonatomic, assign) CGRect contentL;
/* cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/* 评论 */
@property (nonatomic, strong) NSString *comment;


@end
