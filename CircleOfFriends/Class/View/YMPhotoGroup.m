//
//  YMPhotoGroup.m
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "YMPhotoGroup.h"
#import "YMPhoto.h"
#import <UIImageView+WebCache.h>
#import "SDPhotoBrowser.h"

#define YMStatusPhotoWH(count) (SCREENWIDTH - YMStatusPhotoMargin * 5) / (1.5 * count)
#define YMStatusPhotoMargin 10
#define YMStatusPhotoMaxCol(count) ((count==4)?2:3)
#define YMOneImageWH 200
#define YMTwoImageWH 150

@interface YMPhotoGroup () <SDPhotoBrowserDelegate>


@end

@implementation YMPhotoGroup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    _photoItemArray = photoItemArray;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [photoItemArray enumerateObjectsUsingBlock:^(YMPhoto *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *image = [[UIImageView alloc] init];
        NSString *objStr = [NSString stringWithFormat:@"%@",obj];
        
//        [image sd_setImageWithURL:[NSURL URLWithString:objStr] placeholderImage:nil];
        image.image = [UIImage imageNamed:objStr];
        
        image.clipsToBounds = YES;
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.userInteractionEnabled = YES;
        image.tag = idx;
        [self addSubview:image];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
        [image addGestureRecognizer:tap];
    }];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    long imageCount = self.photoItemArray.count;
    
    int perRowImageCount = ((imageCount == 4) ? 2 : 3);//如果是两张或三张
    CGFloat w = YMStatusPhotoWH(perRowImageCount);
    CGFloat h = YMStatusPhotoWH(perRowImageCount);
    [self.subviews enumerateObjectsUsingBlock:^(UIImageView *image, NSUInteger idx, BOOL *stop) {
        
        long rowIndex = idx / perRowImageCount;
        int columnIndex = idx % perRowImageCount;
        CGFloat x = columnIndex * (w + YMStatusPhotoMargin);
        CGFloat y = rowIndex * (h + YMStatusPhotoMargin);
        
        //一张图片
        if (imageCount == 1) {
            image.frame = CGRectMake(x, y, YMOneImageWH, YMOneImageWH);
        } else if (imageCount == 2) { //两张图
            x = columnIndex * (YMTwoImageWH + YMStatusPhotoMargin);
            image.frame = CGRectMake(x, y, YMTwoImageWH, YMTwoImageWH);
        } else {
            image.frame = CGRectMake(x, y, w, h);
        }
        
    }];
    
}

#pragma mark - photobrowser代理方法
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    //    return [self.subviews[index] currentImage];
    
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [self.photoItemArray[index]stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}

- (void)imageClick:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.photoItemArray.count; // 图片总数
    browser.currentImageIndex = tap.view.tag;
    browser.delegate = self;
    [browser show];
}

+ (CGSize)ym_sizeWithCount:(NSUInteger)count
{
    //单图
    if (count == 1) {
        return CGSizeMake(YMOneImageWH, YMOneImageWH);
    } else if (count == 2) {
        return CGSizeMake(YMTwoImageWH * 2, YMTwoImageWH);
    } else {
        
        //最大列数（一行最多有多少列）
        int maxCols = YMStatusPhotoMaxCol(count);
        //列数
        NSUInteger cols = (count >= maxCols) ? maxCols : count;
        CGFloat photosW = cols * YMStatusPhotoWH(maxCols) + (cols - 1) * YMStatusPhotoMargin;
        
        //行数
        NSUInteger rows = (count + maxCols - 1) / maxCols;
        CGFloat photosH = rows * YMStatusPhotoWH(maxCols) + (rows - 1) * YMStatusPhotoMargin;
        
        return CGSizeMake(photosW, photosH);
    }
    
}

@end
