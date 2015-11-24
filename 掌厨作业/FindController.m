//
//  FindController.m
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "FindController.h"
#import "YHItem.h"
#import "YHItemCell.h"

@interface FindController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak)UITableView *tableView;

@end

@interface FindController ()

// 数据源
@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation FindController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 替换导航栏的titleView
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    label.text = @"掌厨-全球最大的视屏厨房";
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    self.navigationItem.titleView = view;
    
    
    //初始化数据源
    self.dataArray = @[
                       @[[YHItem itemWithTitle:@"食材大全" icon:@"expl_food" andType:0],
                         [YHItem itemWithTitle:@"家电厨具佳肴" icon:@"expl_household" andType:1],
                         [YHItem itemWithTitle:@"卖汤汤" icon:@"expl_soup" andType:2]],
                       @[[YHItem itemWithTitle:@"摇一摇" icon:@"expl_shake" andType:3],
                         [YHItem itemWithTitle:@"扫一扫" icon:@"expl_scan" andType:4]],
                       
                       @[[YHItem itemWithTitle:@"新书推荐" icon:@"expl_newbook" andType:5],
                         [YHItem itemWithTitle:@"发现搜索" icon:@"expl_found" andType:6]]
                       ];
    
    
    // 初始化tableView
    CGRect TabelViewRect = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height);
    UITableView *tableView = [[UITableView alloc] initWithFrame:TabelViewRect style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    // 关闭导航的自动偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置背景颜色
    self.tableView.backgroundColor = [UIColor colorWithRed:0.99f green:0.95f blue:0.89f alpha:1.00f];
    
    
    // 设置tabbar
    UIImage *normalImage = [[UIImage imageNamed:@"tab_explore"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage = [[UIImage imageNamed:@"tab_explore_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:normalImage selectedImage:selectedImage];
    self.tabBarItem = tabbarItem;
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - UITabelViewDelegate 
// 没行显示多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray[section] count];
}

// 显示多少组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

// Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHItemCell *cell = [YHItemCell cellWithTableView:tableView];
    cell.item = [self.dataArray[indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}

// Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

// Cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"你竟然点我——>%ld-%ld", indexPath.section, indexPath.row);
}

@end
