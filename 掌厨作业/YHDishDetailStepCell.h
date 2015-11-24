//
//  YHDishDetailStepCell.h
//  掌厨作业
//
//  Created by MS on 15-9-20.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHDishDetailStepCell : UITableViewCell

// 图片路径
@property (nonatomic, strong)NSString *imagePath;

// 图片描述
@property (nonatomic, strong)NSString *describe;

// 步骤
@property (nonatomic, strong)NSString *order_id;

+ (id)cellWithTableView:(UITableView *)tableView;

@end
