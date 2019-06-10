//
//  YMCircleCell.m
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "YMCircleCell.h"
#import "YMFamilyGroupFrame.h"
#import <UIImageView+WebCache.h>
#import "YMFamilyGroup.h"
#import "YMPhotoGroup.h"
#import "YMCommentCell.h"
#import "YMCommentFrame.h"

@interface YMCircleCell () <UITableViewDelegate,UITableViewDataSource>

/* originalView */
@property (nonatomic, weak) UIView *originalView;
/* 头像 */
@property (nonatomic, weak) UIImageView *photo;
/* 用户名 */
@property (nonatomic, weak) UILabel *nameL;
/* 内容 */
@property (nonatomic, weak) UILabel *contentL;
/* 图片 */
@property (nonatomic, weak) YMPhotoGroup *photoGroup;
/* 时间 */
@property (nonatomic, weak) UILabel *timeL;
/* 回复 */
@property (nonatomic, weak) UIButton *replyBtn;
/* UItableView */
@property (nonatomic, weak) UITableView *tableView;

/* 评论 */
@property (nonatomic, strong) NSMutableArray *commentData;


@end

@implementation YMCircleCell

#pragma mark - 懒加载
- (NSMutableArray *)commentData
{
    if (!_commentData) {
        _commentData = [NSMutableArray new];
    }
    return _commentData;
}

#pragma mark - 构建方法
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"YMCircleCell";
    YMCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YMCircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /* originalView */
        UIView *originalView = [[UIView alloc] init];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        /* 头像 */
        UIImageView *photo = [[UIImageView alloc] init];
        [originalView addSubview:photo];
        self.photo = photo;
        
        /* 用户名 */
        UILabel *nameL = [[UILabel alloc] init];
        nameL.textColor = [UIColor blueColor];
        nameL.font = LabelFontRegular(15);
        [originalView addSubview:nameL];
        self.nameL = nameL;
        
        /* 内容 */
        UILabel *contentL = [[UILabel alloc] init];
        contentL.textColor = YMColor(51, 51, 52);
        contentL.font = LabelFontRegular(15);
        contentL.numberOfLines = 0;
        [originalView addSubview:contentL];
        self.contentL = contentL;
        
        /* 图片 */
        YMPhotoGroup *photoGroup = [[YMPhotoGroup alloc] init];
        [originalView addSubview:photoGroup];
        self.photoGroup = photoGroup;
        
        /* 时间 */
        UILabel *timeL = [[UILabel alloc] init];
        timeL.textColor = YMColor(51, 51, 56);
        timeL.font = LabelFontRegular(13);
        [originalView addSubview:timeL];
        self.timeL = timeL;
        
        /* 回复 */
        UIButton *replyBtn = [[UIButton alloc] init];
        [replyBtn setImage:[UIImage imageNamed:@"reply.png"] forState:UIControlStateNormal];
        [originalView addSubview:replyBtn];
        self.replyBtn = replyBtn;
        
        /* UItableView */
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.scrollEnabled = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [originalView addSubview:tableView];
        self.tableView = tableView;
        
    }
    return self;
}

- (void)setFrameModel:(YMFamilyGroupFrame *)frameModel
{
    _frameModel = frameModel;
    
    /* originalView */
    self.originalView.frame = frameModel.originalView;
    
    /* 头像 */
    self.photo.frame = frameModel.photo;
    self.photo.image = [UIImage imageNamed:frameModel.familyGroup.icon];
    
    /* 用户名 */
    self.nameL.frame = frameModel.nameL;
    self.nameL.text = frameModel.familyGroup.name;
    
    /* 内容 */
    self.contentL.frame = frameModel.contentL;
    self.contentL.text = frameModel.familyGroup.shuoshuoText;
    
    /* 图片 */
    if (frameModel.familyGroup.pictures.count) { //有配图
        self.photoGroup.frame = frameModel.photoGroup;
        self.photoGroup.photoItemArray = frameModel.familyGroup.pictures;
        self.photoGroup.hidden = NO;
    } else {
        self.photoGroup.hidden = YES;
    }
    
    /* 时间 */
    self.timeL.frame = frameModel.timeL;
    self.timeL.text = frameModel.familyGroup.time;
    
    /* 回复 */
    self.replyBtn.frame = frameModel.replyBtn;
    
    /* UItableView */
    self.tableView.frame = frameModel.tableView;
    
    if (frameModel.replyData.count) {
        [self.commentData addObjectsFromArray:frameModel.replyData];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.commentData.count) {
        return 0;
    }
    return self.commentData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.commentData.count) {
        return 0;
    }
    YMCommentFrame *frame = self.commentData[indexPath.row];
    return frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMCommentCell *cell = [YMCommentCell cellWithTableView:tableView];
    cell.frameModel = self.commentData[indexPath.row];
    return cell;
}


@end
