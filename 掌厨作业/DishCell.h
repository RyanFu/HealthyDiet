//
//  DishCell.h
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHDish.h"
#import "UIImageView+WebCache.h"

@protocol DishCellDelegate <NSObject>

/**
 *  对应的图片被点击了
 */
- (void)dishDidSlectedWithDish:(YHDish *)dish andIndex:(NSInteger)index;

@end

@class DishCell;
@interface DishCell : UITableViewCell

// 菜的详情
@property (nonatomic, strong)YHDish *dish;

// 代理
@property (nonatomic, weak)id<DishCellDelegate>delegate;

- (void)setDish:(YHDish *)dish andIndexPath:(NSIndexPath *)indexPath;

+ (id )cellWihtTabelView:(UITableView *)tableView;

@end
