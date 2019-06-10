//
//  YMCircleCell.h
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMFamilyGroupFrame;

@interface YMCircleCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/* 数据 */
@property (nonatomic, strong) YMFamilyGroupFrame *frameModel;


@end
