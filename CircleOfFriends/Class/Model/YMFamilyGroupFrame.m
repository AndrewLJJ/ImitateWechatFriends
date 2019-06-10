//
//  YMFamilyGroupFrame.m
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "YMFamilyGroupFrame.h"
#import "YMFamilyGroup.h"
#import "YMPhotoGroup.h"
#import "YMCommentFrame.h"

@implementation YMFamilyGroupFrame

- (void)setFamilyGroup:(YMFamilyGroup *)familyGroup
{
    _familyGroup = familyGroup;
    
    /* 头像 */
    CGFloat photoWH = YMFamilyPhotoWH;
    self.photo = CGRectMake(YMFamilyLeftMargin, YMFamilyTopMargin, photoWH, photoWH);
    
    /* 用户名 */
    CGSize nameSize = [YMStringSize ym_sizeWithText:familyGroup.name font:LabelFontRegular(15) maxW:MAXFLOAT];
    CGFloat nameX = CGRectGetMaxX(self.photo) + YMFamilyControlMargin;
    self.nameL = (CGRect){{nameX,YMFamilyTopMargin},nameSize};
    
    /* 内容 */
    CGFloat contentX = CGRectGetMaxX(self.photo) + YMFamilyControlMargin;
    CGFloat contentW = SCREENWIDTH - contentX - YMFamilyContentMargin;
    CGSize contentSize = [YMStringSize ym_sizeWithText:familyGroup.shuoshuoText font:LabelFontRegular(15) maxW:contentW];
    CGFloat contentY = CGRectGetMaxY(self.nameL) + YMFamilyControlMargin;
    self.contentL = (CGRect){{contentX,contentY},contentSize};
    
    /** 配图 */
    //用于存有配图和没有配图的求助背图的y值
    CGFloat photoBackY;
    if (familyGroup.pictures.count) { //有配图
        CGFloat groupX = contentX;
        CGFloat groupY = CGRectGetMaxY(self.contentL) + YMFamilyControlMargin;
        CGSize groupSize = [YMPhotoGroup ym_sizeWithCount:familyGroup.pictures.count];
        self.photoGroup = (CGRect){{groupX,groupY},groupSize};
        
        photoBackY = CGRectGetMaxY(self.photoGroup) + YMFamilyControlMargin;
    } else { //无配图
        photoBackY = CGRectGetMaxY(self.contentL) + YMFamilyControlMargin;
    }
    
    /* 时间 */
    CGFloat timeX = contentX;
    CGFloat timeY = photoBackY;
    CGSize timeSize = [YMStringSize ym_sizeWithText:familyGroup.time font:LabelFontRegular(13) maxW:MAXFLOAT];
    self.timeL = (CGRect){{timeX ,timeY},timeSize};
    
    /* 回复 */
    CGFloat replyBtnWH = YMFamilyReplyBtn;
    CGFloat replyBtnX = SCREENWIDTH - replyBtnWH - YMFamilyRightMargin * 2;
    CGFloat replyBtnY = timeY;
    self.replyBtn = CGRectMake(replyBtnX, replyBtnY, replyBtnWH, replyBtnWH);
    
    /* UItableView */
    //要点在这一步，首先将评论的model转化为frameModel,然后用NSArray保存，在将cellHeight遍历出来即可相加就可以得到tableView的高度
    CGFloat tableViewHeight = 0.0;
    if (familyGroup.replys.count) { //如果有评论
        CGFloat tableViewX = YMFamilyLeftMargin + YMFamilyControlMargin + YMFamilyPhotoWH;
        CGFloat tableViewY = CGRectGetMaxY(self.replyBtn) + YMFamilyBottomMargin;
        CGFloat tableViewW = SCREENWIDTH - tableViewX - YMFamilyRightMargin - YMFamilyLeftMargin;
        
        NSArray *frameArr = [self frameWithComment:familyGroup.replys];
        for (int i = 0; i < frameArr.count; i ++) {
            YMCommentFrame *frame = frameArr[i];
            tableViewHeight += frame.cellHeight;
            //保存评论转化为frameModel的数据
            [self.replyData addObject:frame];
        }
        self.tableView = CGRectMake(tableViewX, tableViewY, tableViewW, tableViewHeight);
        
        //最后还要加一个边距
        tableViewHeight += YMFamilyBottomMargin;
        
    } else {
        tableViewHeight = 0.0;
    }
    
    /* originalView */
    CGFloat originalViewH = CGRectGetMaxY(self.replyBtn) + YMFamilyBottomMargin + tableViewHeight;
    self.originalView = CGRectMake(0, 0, SCREENWIDTH, originalViewH);
    
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.originalView);
    
}

//将评论数据转化为frameModel，这里因为评论数据是字符串，所以没有创建model
- (NSArray *)frameWithComment:(NSArray *)comments
{
    NSMutableArray *frames = [NSMutableArray new];
    for (NSString *str in comments) {
        YMCommentFrame *frame = [[YMCommentFrame alloc] init];
        frame.comment = str;
        [frames addObject:frame];
    }
    return frames;
}

#pragma mark - 懒加载
- (NSMutableArray *)replyData
{
    if (!_replyData) {
        _replyData = [NSMutableArray new];
    }
    return _replyData;
}

@end
