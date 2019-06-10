//
//  ViewController.m
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "ViewController.h"
#import "YMCircleViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *openCircle;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault; //默认的值是黑色的
}

- (BOOL)prefersStatusBarHidden
{
    return NO; // 是否隐藏状态栏
}

- (IBAction)openCircleClcik {
    
    YMCircleViewController *circleVC = [[YMCircleViewController alloc] init];
    [self.navigationController pushViewController:circleVC animated:YES];
}





@end
