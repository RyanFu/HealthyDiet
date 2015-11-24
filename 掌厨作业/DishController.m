//
//  DishController.m
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "DishController.h"
#import "DishCell.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "AFNetworkReachabilityManager.h"
#import "GPAdsView.h"
#import "Advertisement.h"
#import "UIImageView+WebCache.h"
#import "YHDish.h"
#import "YHVegetable.h"
#import "GPTabbar.h"
#import "YHSearchController.h"
#import "YHDishDetailController.h"

@interface DishController ()<UITableViewDataSource, UITableViewDelegate, DishCellDelegate>

@property (nonatomic, weak)UITableView *tableView;

@property (nonatomic, weak)UIView *adsView;

// 数据源
@property (nonatomic, strong)NSArray *dataArray;
// 广告数据
@property (nonatomic, strong)NSArray *adsArray;
// 临时的图片数组
@property (nonatomic, strong)NSArray *tempAdsImageUrlArr;

@end

@implementation DishController

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
//        // 设置背景颜色
//        tableView.backgroundColor = [UIColor colorWithRed:0.99f green:0.95f blue:0.89f alpha:1.00f];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (IBAction)search:(id)sender {
    
    YHSearchController *search = [[YHSearchController alloc] init];
    [self.navigationController pushViewController:search animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 替换导航栏的titleView
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    label.text = @"掌厨-全球最大的视屏厨房";
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    self.navigationItem.titleView = view;
    
    // 取消导航栏偏移
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    // 开启网络监控
    [self monitorNetworkTypw];
    
    
    // 下面数据的获取
    NSString *urlItemStr= @"http://client.izhangchu.com/HandheldKitchen/api/home/tblHomepageVegetable!getHomeVegetableList.do?";
    [self postRequest:urlItemStr];
    
    // 广告的地址,获取广告地址
    NSString *urlAdsStr = @"http://client.izhangchu.com/HandheldKitchen/api/home/tblHomepageVegetable!getSpecialList.do?";
    [self jsonGetRequest:urlAdsStr];
    
    UIImage *image = [UIImage imageNamed:@"tab_cookbook"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.tabBarItem.image = image;
    
    // 设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:0.99f green:0.95f blue:0.89f alpha:1.00f];
    self.tabBarController.tabBar.hidden = YES;
    
}

#pragma mark 控件的初始化
// 初始化tableView
- (void)loadTabelView {
    
    // 初始化tableView
    self.tableView.frame = CGRectMake(5, 44, self.view.frame.size.width - 10, self.view.frame.size.height - 44-49);
    
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark UITableViewDelegate

// 有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

// 每组中有多少个数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

// Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DishCell *cell = [DishCell cellWihtTabelView:tableView];
    [cell setDish:self.dataArray[indexPath.section] andIndexPath:indexPath];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 167.f;
}

// 头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 10)];
    view.backgroundColor = [UIColor colorWithRed:0.99f green:0.95f blue:0.89f alpha:1.00f];
    return view;
}

// 透视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}



#pragma mark 网络相关
// Get请求 Json数据 得到广告的数据
- (void)jsonGetRequest:(NSString *)urlStr {
    // 数据请求队列的管理器, 单例
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 设置json接续
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    // 发送Get请求
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = operation.responseData;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *dataArr = [dic objectForKey:@"data"];
        
        // 临时的模型数组
        NSMutableArray *tempArr = [NSMutableArray array];
        
        // 临时的图片路径数组
        NSMutableArray *tempImageUrlArr= [NSMutableArray array];
        for (NSDictionary *adsDic in dataArr) {
            Advertisement *ads = [[Advertisement alloc] initWithDict:adsDic];
            [tempArr addObject:ads];
            [tempImageUrlArr addObject:ads.imageFilename];
        }
        self.adsArray = tempArr;
        self.tempAdsImageUrlArr = tempImageUrlArr;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败:%@",error);
    }];
}

// 获取数据
- (void)postRequest:(NSString *)urlStr  {
    
    // 数据请求队列的管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 请求json数据
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    // 设置post键值对
    NSDictionary *dict = @{
                           @"user_id":@"0",
                           @"is_traditional":@"0",
                           @"page":@"1",
                           @"pageRecord":@"3",
                           @"phonetype":@"1"
                           };
    
//    NSString *str = @"http://121.41.88.179:80/HandheldKitchen/api/home/tblHomepageVegetable!getHomeVegetableList.do?&user_id=0&is_traditional=0&page=1&pageRecord=3&phonetype=1";
    
    // 下载数据
    [manager POST:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        
        // 得到data
        NSArray *arr = [dict objectForKey:@"data"];
        
        NSMutableArray *dishArray = [NSMutableArray array];
        
        
        // 获得数据
        for (NSDictionary *dict in arr) {
            YHDish *dish = [[YHDish alloc] initWithDict:dict];
            [dishArray addObject:dish];
        }
        
        self.dataArray = dishArray;
        
        // 得到数据后初始化dataView
        [self loadTabelView];
        
        // 刷新tableView
        [self.tableView reloadData];
        
        // 添加广告图片
        GPAdsView *adsView = [GPAdsView adsView];
        // 这个两个顺序替换了下竟然差别这么大!;如果把先执行下面的那个, 因为没有添加进tableView中, 所有得不到尺寸为0. 所以显示不出来图片
        self.tableView.tableHeaderView = adsView;
        [adsView setImages:self.tempAdsImageUrlArr];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"出现错误:error:%@", error);
    }];
}



// 网络监控
- (void)monitorNetworkTypw {
    
    // 请求队列的管理员
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"www.baidu.com"]];
    
    // 注册网络变化的回调block
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"WiFi");
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN)
        {
            NSLog(@"3G/GPRS");
        }else if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"网络未连接");
        }
    }];
    
    // 启动网络监控
    [manager.reachabilityManager startMonitoring];
    // 当网络状态有变, 回调block
    
}

// 点击某个菜的图片后跳转到详细界面的事件
- (void)dishDidSlectedWithDish:(YHDish *)dish andIndex:(NSInteger)index {
//    NSLog(@"dish:\n%@", dish);
    YHDishDetailController *dishDetailController = [[YHDishDetailController alloc] init];
    dishDetailController.vegetable = [dish.vegetableList objectAtIndex:index];
    [self.navigationController pushViewController:dishDetailController animated:YES];
    
}

@end
