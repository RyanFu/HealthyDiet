//
//  YHDishDetailMaterialCell.h
//  掌厨作业
//
//  Created by MS on 15-9-20.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHDishDetailMaterialCell : UITableViewCell

// 所需材料:标题
@property (nonatomic, strong)NSString *title;

// 所需材料:描述
@property (nonatomic, strong)NSString *detailDecription;

+ (instancetype)dishDetailMaterialCell;

@end
