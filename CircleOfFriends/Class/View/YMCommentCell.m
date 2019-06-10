//
//  YMCommentCell.m
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "YMCommentCell.h"
#import "YMCommentFrame.h"

@interface YMCommentCell ()

/* originalView */
@property (nonatomic, weak) UIView *originalView;
/* 内容 */
@property (nonatomic, weak) UILabel *contentL;


@end

@implementation YMCommentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"YMCommentCell";
    YMCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YMCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        /* originalView */
        UIView *originalView = [[UIView alloc] init];
        originalView.backgroundColor = YMTableViewBackgroundColor;
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        /* 内容 */
        UILabel *contentL = [[UILabel alloc] init];
        contentL.numberOfLines = 0;
        contentL.textColor = YMColor(51, 51, 52);
        contentL.font = LabelFontRegular(13);
        [originalView addSubview:contentL];
        self.contentL = contentL;
        
    }
    return self;
}

- (void)setFrameModel:(YMCommentFrame *)frameModel
{
    _frameModel = frameModel;
    
    /* originalView */
    self.originalView.frame = frameModel.originalView;
    
    /* 内容 */
    self.contentL.text = frameModel.comment;
    self.contentL.frame = frameModel.contentL;
    
}

@end
