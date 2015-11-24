//
//  YHDishDetailKnowledgeCell.h
//  掌厨作业
//
//  Created by MS on 15-9-20.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHDishDetailKnowledgeCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setImage:(NSString *)imagePath andDescribe:(NSString *)describe andGuide:(NSString *)guide;

@end
