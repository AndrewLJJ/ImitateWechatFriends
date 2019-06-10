//
//  YMCircleViewController.m
//  CircleOfFriends
//
//  Created by 刘家俊 on 2017/8/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "YMCircleViewController.h"
#import "YMCircleCell.h"
#import "YMFamilyGroup.h"
#import "YMFamilyGroupFrame.h"
#import <MJExtension.h>

@interface YMCircleViewController () <UITableViewDelegate,UITableViewDataSource>

/* tableView */
@property (nonatomic, weak) UITableView *tableView;
/* 数据 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YMCircleViewController

#pragma mark - 懒加载
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self getData];
}

#pragma mark - 创建tableView
- (void)setupTableView
{
    //tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self setExtraCellLineHidden:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

//设置多于的分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}

#pragma mark - 获取数据
- (void)getData
{
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"FamilyGroup.plist" ofType:nil];
    NSArray *dicArr = [NSArray arrayWithContentsOfFile:fullPath];
    
    NSArray *arr = [YMFamilyGroup mj_objectArrayWithKeyValuesArray:dicArr];
    NSArray *newArr = [self framesWithFamilyGroup:arr];
    
    [self.dataSource addObjectsFromArray:newArr];
    [self.tableView reloadData];
    
}

//将model转化为frameModel
- (NSArray *)framesWithFamilyGroup:(NSArray *)groups
{
    NSMutableArray *frames = [NSMutableArray array];
    for (YMFamilyGroup *group in groups) {
        YMFamilyGroupFrame *frame = [[YMFamilyGroupFrame alloc] init];
        frame.familyGroup = group;
        [frames addObject:frame];
    }
    return frames;
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMFamilyGroupFrame *frame = self.dataSource[indexPath.row];
    return frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMCircleCell *cell = [YMCircleCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.frameModel = self.dataSource[indexPath.row];
    return cell;
}

@end
