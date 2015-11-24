//
//  MainController.m
//  掌厨作业
//
//  Created by MS on 15-9-5.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "MainController.h"
#import "GPTabbar.h"
//#import "YHNavDishController.h"
//#import "YHNavFindController.h"
//#import "YHNavMineController.h"
//#import "YHNavSquareController.h"


@interface MainController ()<GPTabbarDelegate>

//@property (nonatomic, weak)YHNavDishController *navDishController;
//
//@property (nonatomic, weak)YHNavFindController *navFindController;
//
//@property (nonatomic, weak)YHNavMineController *navMineController;
//
//@property (nonatomic, weak)YHNavSquareController *navSquareController;

@end

@implementation MainController

#pragma mark 懒加载



- (void)viewDidLoad {
    [super viewDidLoad];
    
    GPTabbar *tabbar = [GPTabbar tabbar];
    [self.view addSubview:tabbar];
    NSMutableArray *array = [NSMutableArray array];
    
    // 第一个button
    UIButton *btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOne setImage:[UIImage imageNamed:@"tab_cookbook"] forState:UIControlStateNormal];
    [btnOne setImage:[UIImage imageNamed:@"tab_cookbook_hl"] forState:UIControlStateSelected];
    [btnOne setTitle:@"菜谱" forState:UIControlStateNormal];
    [btnOne setTitleEdgeInsets:UIEdgeInsetsMake(25, -90, 0, 0)];
    [array addObject:btnOne];
    
    // 第二个button
    UIButton *btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnTwo setBackgroundImage:[UIImage imageNamed:@"tab_explore"] forState:UIControlStateNormal];
    [btnTwo setBackgroundImage:[UIImage imageNamed:@"tab_explore_hl"] forState:UIControlStateSelected];
    [btnTwo setTitle:@"发现" forState:UIControlStateNormal];
    [btnTwo setTitleEdgeInsets:UIEdgeInsetsMake(25, 0, 0, 0)];
    [array addObject:btnTwo];
    
    // 第三个button
    UIButton *btnThree = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnThree setBackgroundImage:[UIImage imageNamed:@"tab_plaza"] forState:UIControlStateNormal];
    [btnThree setBackgroundImage:[UIImage imageNamed:@"tab_plaza_hl"] forState:UIControlStateSelected];
    [btnThree setTitle:@"广场" forState:UIControlStateNormal];
    [btnThree setTitleEdgeInsets:UIEdgeInsetsMake(25, 0, 0, 0)];
    
    
    [array addObject:btnThree];
    
    // 第四个button
    UIButton *btnFour = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFour setBackgroundImage:[UIImage imageNamed:@"tab_aboutme"] forState:UIControlStateNormal];
    [btnFour setBackgroundImage:[UIImage imageNamed:@"tab_aboutme_hl"] forState:UIControlStateSelected];
    [btnFour setTitle:@"我的" forState:UIControlStateNormal];
    [btnFour setTitleEdgeInsets:UIEdgeInsetsMake(25, 0, 0, 0)];
    [array addObject:btnFour];
    
    for (UIButton *button  in array) {
        UIButton *newButton = button;
        
        [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [newButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    
    [tabbar setItems:array];
    
    tabbar.delegate = self;
    
    NSString *str = @"你好";
    
    if ([str containsString:@"你"]) {
        NSLog(@"包含");
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

/**
Could not find a navigation controller for segue 'Square'. Push segues can only be used when the source controller is managed by an instance of UINavigationController.'
 */
- (void)tabbarItemSelected:(GPTabbar *)tabbar andItem:(UIButton *)item andIndex:(int)index {

    self.selectedIndex = index;
}



@end
