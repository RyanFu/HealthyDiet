//
//  YHDishDetailHeaderView.h
//  掌厨作业
//
//  Created by MS on 15-9-21.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHDishDetailHeaderView : UITableViewHeaderFooterView


@property (nonatomic, strong)NSString *name;

@property (nonatomic, strong)NSString *iconImageName;

+ (instancetype)headerView;

@end
