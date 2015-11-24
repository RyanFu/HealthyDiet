//
//  YHSquareController.m
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHSquareController.h"
#import "AFNetworking.h"
#import "YHSharedDish.h"
#import "YHSquareDishCell.h"

@interface YHSquareController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation YHSquareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 替换导航栏的titleView
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    label.text = @"掌厨-全球最大的视屏厨房";
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];

    self.navigationItem.titleView = view;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self getDataFromUrl:@"http://client.izhangchu.com/HandHeldKitchenCommunity/api/theme/themeProduct!getProductList.do?"];
    
}

#pragma mark 初始化
// CollectionView的初始化
- (void)initCollectionView {
    // 初始化UICollectionView
    CGRect collectionViewRect = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewRect collectionViewLayout:layout];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    // 设置背景颜色
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.99f green:0.95f blue:0.89f alpha:1.00f];
    
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark 请求网络数据
- (void)getDataFromUrl:(NSString *)url {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    NSDictionary *parameters = @{
                                 @"page":@"1",
                                 @"pageRecord":@"30",
                                 @"is_traditional":@"0"
                                 };
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 获得所有的数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        
        // 从中拿出data
        NSArray *array = [dict objectForKey:@"data"];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            YHSharedDish *dish = [[YHSharedDish alloc] initWithDict:dict];
            [tempArray addObject:dish];
        }
//         NSLog(@"tempArray-:%@",tempArray);
        
        // 得到数据源
        self.dataArray = tempArray;
        
        // 显示Collection
        [self initCollectionView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误:%@", error);
    }];
    
}


#pragma mark -CollectionViewDelegate

// 每组多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// 多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

// Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    YHSquareDishCell *cell = [YHSquareDishCell cellWithCollectionView:collectionView andIndexPath:indexPath];
    cell.sharedDish = self.dataArray[indexPath.row];
    
    return cell;
}

// cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"别摸我->%ld-%ld", indexPath.section, indexPath.row);
}

// Cell Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(172.f, 185.f);
}

// 设置空隙的尺寸
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

// 单元格中的间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 10, 5, 5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
