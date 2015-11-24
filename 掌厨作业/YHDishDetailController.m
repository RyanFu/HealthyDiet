//
//  YHDishDetailController.m
//  掌厨作业
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHDishDetailController.h"
#import "AFHTTPRequestOperationManager.h"
#import "YHDishDetailHeaderView.h"
#import "YHDishDetailMaterialCell.h"
#import "YHDishDetailMaterialImageCell.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "YHDishDetailStepCell.h"
#import "YHDishDetailKnowledgeCell.h"

@interface YHDishDetailController ()<UITableViewDelegate, UITableViewDataSource>

// 视频视图
@property (weak, nonatomic) IBOutlet UIView *videoView;

// tableView视图
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 评论视图
@property (weak, nonatomic) IBOutlet UIView *responseView;

// 视频播放控制器
@property (nonatomic, strong)MPMoviePlayerController *moviePlayerController;

// 数据源
//@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, strong)NSMutableDictionary *dataSource;


@property (nonatomic, strong)NSArray *dataSourceKeys ;

@property (nonatomic, strong)NSMutableDictionary *sectionHeaderDataSourceArray;

@end

@implementation YHDishDetailController

// 懒加载数据源
//- (NSArray *)dataArray {
//    if (_dataArray == nil) {
//        _dataArray = [NSArray array];
//    }
//    return _dataArray;
//}

- (NSMutableDictionary *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableDictionary dictionary];
    }
    return _dataSource;
}


- (void)setVegetable:(YHVegetable *)vegetable {
    _vegetable = vegetable;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataSourceKeys = @[@"1", @"2", @"3", @"4"];
    
    // 下载数据
    [self initData];
    [self loadDataFromNetWork];
    
    
//    // 视屏播放上面的大图
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.videoView.bounds];
//    [self.videoView addSubview:imageView];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:_vegetable.imagePathThumbnails]];
    
    // 初始化视频播放
    [self initVideoPlay];
    
}

#pragma mark - 初始化视频播放
- (void)initVideoPlay {
    
    NSLog(@"视频播放路径。。。。。。:%@", _vegetable.materialVideoPath);
    
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_vegetable.materialVideoPath]];
    
    self.moviePlayerController.view.frame = self.videoView.bounds;

    // 播放控制条样式
    self.moviePlayerController.controlStyle = MPMovieControlStyleDefault;
    self.moviePlayerController.repeatMode = MPMovieControlStyleFullscreen;
    

    
    // 屏幕宽高比例
    self.moviePlayerController.scalingMode = MPMovieScalingModeAspectFit;
    
    [self.videoView addSubview:self.moviePlayerController.view];
    
    // 初始化开始时间
    self.moviePlayerController.initialPlaybackTime = -1;
    
    // 设置是否自动播放
    self.moviePlayerController.shouldAutoplay = NO;
    
    // 开始播放
    [self.moviePlayerController play];
    
    // 添加观察
    
    // 播放结束
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveDidFinish:) name:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey object:self.moviePlayerController];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0f;
    
}

// 通知消息
- (void)moveDidFinish:(NSNotification *)noti {
//    NSLog(@"播放结束了");
    // 停止播放
    [self.moviePlayerController stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// 初始化数据(四个分类的数组)
- (void)initData {
 
    
    
    _sectionHeaderDataSourceArray =
     @{
       @"1": @{@"title": @"所需材料", @"image": @"detail_material"},
       @"2": @{@"title": @"制作步骤", @"image": @"detail_step"},
       @"3": @{@"title": @"相关常识", @"image": @"detail_knowledge"},
       @"4": @{@"title": @"相宜相克", @"image": @"detail_suitable"}                                  };
    
}

// 从网络上下载数据
- (void)loadDataFromNetWork {
    
    for (int i = 0; i < self.dataSourceKeys.count; i++) {
        
        NSString *key = self.dataSourceKeys[i];
        
        // 参数
        NSDictionary *params = @{
            @"vegetable_id":_vegetable.vegetable_id,
            @"type":key,
            @"phonetype":@"0",
            @"is_traditional":@"0"
                                 };
        
//        NSLog(@"%@",_vegetable.vegetable_id);
        
        AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
        
        // 设置为Json解析
        requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
        
        // url:/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?
        NSString *urlStr = @"http://client.izhangchu.com/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?";
        
        //http://client.izhangchu.com/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?vegetable_id=7162&type=2&phonetype=0&is_traditional=0
        
        [requestManager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        
//            NSLog(@"%@", operation.response);
            
//            self.dataArray = [dic objectForKey:@"data"];
            
            [self.dataSource setObject:[dic objectForKey:@"data"] forKey:key];
            
//            NSLog(@"----------:%@",self.dataSource);
            
            [self.tableView reloadData];
            
        
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"连接发生错误");
        }];
        
    }
    
}


#pragma mark - tableView代理

// 有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

// 有多少行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    NSString *sectionKey = _dataSourceKeys[section];
    
    id data = _dataSource[sectionKey];
    
    switch (section) {
        case 0:
            return [[[data lastObject] objectForKey:@"TblSeasoning"] count] + 3;
            break;
        case 1:
            return [data count];
            
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 0;
            break;
            
        default:
            break;
    }
    
    // 一般不会到这步
    return 0;
}

// tableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self cellAtIndexPath:indexPath];
    
    return cell;
}

// 头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    YHDishDetailHeaderView *headerView = [YHDishDetailHeaderView headerView];
    
    NSString *key = _dataSourceKeys[section];

    NSDictionary *dic = [_sectionHeaderDataSourceArray objectForKey:key];

    headerView.name = [dic objectForKey:@"title"];
    headerView.iconImageName = [dic objectForKey:@"image"];

    return headerView;
}

// 头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

// tableViewCell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (indexPath.section) {
            
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    return [_vegetable.fittingRestriction boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 75, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + 44;
                    break;
                case 2:
                   return  [_vegetable.method boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 75, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + 44;
                    break;
                default:
                    return 200.0f;
                    break;
            }
        }
            
            break;
        case 1:
             return 237.0f;
            break;
        case 2:
            return 530.0f;
            break;
        case 3:
            return 200.0f;
            break;
        default:
            break;
    }
    
    return 30;
}

#pragma mark - 辅助方法

// 返回特定的cell
- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    switch (indexPath.section) {
            
        case 0: {
            cell = [self cellAtSectionOneWithIndexPathRow:indexPath.row];
        }
            break;
        case 1: {
            
            cell = [self cellAtSectionTwoWithIndexPathRow:indexPath.row];
        }
            break;
            
        case 2: {
            
              cell = [self cellAtSectionThreeWithIndexPathRow:indexPath.row];
        }
            break;
            
        case 3: {
            cell = [self cellAtSectionOneWithIndexPathRow:indexPath.row];
        }
            break;
        default: {
             cell = [self cellAtSectionOneWithIndexPathRow:indexPath.row];
        }
            break;
    }
    
    return cell;
}

// 第一个Section
- (UITableViewCell *)cellAtSectionOneWithIndexPathRow:(NSInteger )row{
    UITableViewCell *cell;
    
    NSString *sectionKey = self.dataSourceKeys[0];
    
    id data = [_dataSource objectForKey:sectionKey];
    
//    NSLog(@">>>>>>>>>%@", data);
    
    switch (row) {
        case 0:{
            YHDishDetailMaterialCell *materialCell = [YHDishDetailMaterialCell dishDetailMaterialCell];
            materialCell.title = @"原料:";
            materialCell.detailDecription = _vegetable.fittingRestriction;
//            cell.textLabel.text = @"123";
            cell = materialCell;
            
        }
            break;
            
        case 2:
        {
            YHDishDetailMaterialCell *materialCell = [YHDishDetailMaterialCell dishDetailMaterialCell];
            materialCell.title = @"调料:";
            materialCell.detailDecription = _vegetable.method;
            cell = materialCell;
        }
            break;
            
        default:
            {
                YHDishDetailMaterialImageCell *materialImageCell = [YHDishDetailMaterialImageCell materialImageCell];
                NSString *imagePath = nil;
                
                if (row == 1) {
                    imagePath = [[data lastObject] objectForKey:@"imagePath"];
                    
                } else {
                    // 不知道这个又没有用
//                    imagePath = [[[[data lastObject] objectForKey:@"TblSeasoning"]   objectAtIndex:row - 3] objectForKey:@"imagePath"];
                }
//                NSLog(@"………………………………………………imagePath:%@",imagePath);
                [materialImageCell.materialImageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
                cell = materialImageCell;
                
            }
        
            break;
    }
    
    return cell;
}

// 第二个Section
- (UITableViewCell *)cellAtSectionTwoWithIndexPathRow:(NSInteger )row {
//
    UITableViewCell *cell = nil;
    
    NSString *sectionKey = self.dataSourceKeys[1];
    // 数据
    id data = [_dataSource objectForKey:sectionKey];
    // 具体
    id dataItem = [data objectAtIndex:row];
    
    YHDishDetailStepCell *stepCell = [YHDishDetailStepCell cellWithTableView:self.tableView] ;
    
    stepCell.imagePath = [dataItem objectForKey:@"imagePath"];
    stepCell.describe = [dataItem objectForKey:@"describe"];
    stepCell.order_id = [dataItem objectForKey:@"order_id"];
    stepCell.backgroundColor = [UIColor clearColor];
    
    cell = stepCell;
    
    return cell;
}

// 第三个Section
- (UITableViewCell *)cellAtSectionThreeWithIndexPathRow:(NSInteger )row {
    
    YHDishDetailKnowledgeCell *cell = [YHDishDetailKnowledgeCell cellWithTableView:self.tableView];
    
    NSString *sectionKey = self.dataSourceKeys[3];
    // 数据
    id data = [_dataSource objectForKey:sectionKey];
    // 具体
    id dataItem = [data lastObject];
    
//    NSLog(@"&&&&&&&&\n%@", dataItem);
    
    NSString *imagePath = dataItem[@"imagePath"];
    NSString *describe = dataItem[@"nutritionAnalysis"];
    NSString *guide = dataItem[@"productionDirection"];
    
    [cell setImage:imagePath andDescribe:describe andGuide:guide];
    return cell;
}

@end
