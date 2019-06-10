//
//  YMCommentFrame.m
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/4.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "YMCommentFrame.h"
#import "YMStringSize.h"

@implementation YMCommentFrame

- (void)setComment:(NSString *)comment
{
    _comment = comment;
    
    
    
    /* 内容 */
    CGFloat contentX = YMFamilyControlMargin;
    CGFloat contentY = YMFamilyCommentMargin;
    
    //original的宽度
    CGFloat originalW = SCREENWIDTH - YMFamilyLeftMargin -YMFamilyPhotoWH - YMFamilyControlMargin - YMFamilyRightMargin * 2 ;
    
    CGFloat contentW = originalW - YMFamilyControlMargin * 2;
    CGSize contentSize = [YMStringSize ym_sizeWithText:comment font:LabelFontRegular(13) maxW:contentW];
    self.contentL = (CGRect){{contentX,contentY},contentSize};
    
    /* originalView */
    CGFloat originalH = CGRectGetMaxY(self.contentL) + YMFamilyCommentMargin;
    self.originalView = CGRectMake(0, 0, originalW, originalH);
    
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.originalView);
    
}

@end
