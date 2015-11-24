//
//  YHAboutMeController.m
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHAboutMeController.h"
#import "YHMyItem.h"
#import "YHAboutMeCell.h"

@interface YHAboutMeController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

// 数据源
@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation YHAboutMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 替换导航栏的titleView
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    label.text = @"掌厨-全球最大的视屏厨房";
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    self.navigationItem.titleView = view;
    
    // 初始化数据源
    self.dataArray = @[
                       @[[YHMyItem myItemWithTitle:@"我的信息" icon:@"me_info" andType:0],
                         ],
                       @[[YHMyItem myItemWithTitle:@"缓存视频" icon:@"me_videocache" andType:1],
                         [YHMyItem myItemWithTitle:@"消息列表" icon:@"me_msg" andType:2],
                         [YHMyItem myItemWithTitle:@"检查更新" icon:@"me_checkversion" andType:3],
                         [YHMyItem myItemWithTitle:@"意见反馈" icon:@"me_feedback" andType:4],
                         [YHMyItem myItemWithTitle:@"给我们评分" icon:@"me_grade" andType:5],
                         [YHMyItem myItemWithTitle:@"关于我们" icon:@"me_about" andType:6],]
                       ];
    
    
    // 初始化tabelView
    CGRect tabelViewRect = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44);
    UITableView *tableView = [[UITableView alloc] initWithFrame: tabelViewRect style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置背景颜色
    self.tableView.backgroundColor = [UIColor colorWithRed:0.99f green:0.95f blue:0.89f alpha:1.00f];
    
    self.tabBarController.tabBar.hidden = YES;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate

// 分为多少组
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

// 每组多少数据
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray[section] count];
}

// Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHAboutMeCell *cell = [YHAboutMeCell cellWithTabelView:tableView];
    
    cell.myItem = [self.dataArray[indexPath.section] objectAtIndex:indexPath.row];
    return cell;
    
}

// Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

// Cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"不要点我->%ld-%ld", indexPath.section, indexPath.row);
}

// 设置tableView滑入的动画
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 设置Cell的显示动画为3D缩放
    // xy方向缩放的初始值为0.1
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0);
    
    // 设置动画的时间为0.25秒,xy方向缩放的最终值为1
    [UIView animateWithDuration:2 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
    }];
}

@end
