//
//  DishCell.m
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "DishCell.h"

@interface DishCell ()

// icon图片
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
// 名称文本
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// Hot图片
@property (weak, nonatomic) IBOutlet UIImageView *hotImageView;
// 第一个菜的图片
@property (weak, nonatomic) IBOutlet UIImageView *vegetableOneImageView;
// 第一个菜的名字
@property (weak, nonatomic) IBOutlet UILabel *dishNameOneLabel;
// 第二个菜的图片
@property (weak, nonatomic) IBOutlet UIImageView *vegetableTwoImageView;
// 第二个菜的名字
@property (weak, nonatomic) IBOutlet UILabel *dishNameTwoLabel;
// 第三个菜的图片
@property (weak, nonatomic) IBOutlet UIImageView *vegetableThreeImageView;
// 第四个菜的名字
@property (weak, nonatomic) IBOutlet UILabel *dishNameThreeLabel;

@end

@implementation DishCell

- (void)awakeFromNib {
    // Initialization code
}


+ (id)cellWihtTabelView:(UITableView *)tableView {
    
    NSString *cellName = NSStringFromClass([self class]);
    
    UINib *nib = [UINib nibWithNibName:cellName bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:cellName];
    
    return [tableView dequeueReusableCellWithIdentifier:cellName];
    
}

- (void)setDish:(YHDish *)dish {
    _dish = dish;
    NSURL *iconUrl = [NSURL URLWithString:dish.imageFilename];
    [self.iconImageView sd_setImageWithURL:iconUrl];
    
    self.nameLabel.text = dish.name;
 
    // 第一个蔬菜
    YHVegetable *vegetableOne = dish.vegetableList[0];
    NSURL *vegetabelOneUrl = [NSURL URLWithString:vegetableOne.imagePathThumbnails];
    [self.vegetableOneImageView sd_setImageWithURL:vegetabelOneUrl];
    self.dishNameOneLabel.text = vegetableOne.name;
    
    // 第二个蔬菜
    YHVegetable *vegetableTwo = dish.vegetableList[1];
    NSURL *vegetabelTwoUrl = [NSURL URLWithString:vegetableTwo.imagePathThumbnails];
    [self.vegetableOneImageView sd_setImageWithURL:vegetabelTwoUrl];
    self.dishNameOneLabel.text = vegetableTwo.name;
    
    // 第三个蔬菜
    YHVegetable *vegetableThree = dish.vegetableList[2];
    NSURL *vegetabelTHreeUrl = [NSURL URLWithString:vegetableThree.imagePathThumbnails];
    [self.vegetableOneImageView sd_setImageWithURL:vegetabelTHreeUrl];
    self.dishNameOneLabel.text = vegetableThree.name;
    
    
}

- (void)setDish:(YHDish *)dish andIndexPath:(NSIndexPath *)indexPath {
    _dish = dish;
    NSURL *iconUrl = [NSURL URLWithString:dish.imageFilename];
    [self.iconImageView sd_setImageWithURL:iconUrl];
    
    self.nameLabel.text = dish.name;
    
    // 第一个蔬菜
    YHVegetable *vegetableOne = dish.vegetableList[0];
    NSURL *vegetabelOneUrl = [NSURL URLWithString:vegetableOne.imagePathThumbnails];
    [self.vegetableOneImageView sd_setImageWithURL:vegetabelOneUrl];
    self.vegetableOneImageView.tag = 100;
    self.dishNameOneLabel.text = vegetableOne.name;
    // 添加手势
    self.vegetableOneImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dishDidSelected:)];
    [self.vegetableOneImageView addGestureRecognizer:tap1];
    
    // 第二个蔬菜
    YHVegetable *vegetableTwo = dish.vegetableList[1];
    NSURL *vegetabelTwoUrl = [NSURL URLWithString:vegetableTwo.imagePathThumbnails];
    [self.vegetableTwoImageView sd_setImageWithURL:vegetabelTwoUrl];
    self.dishNameTwoLabel.text = vegetableTwo.name;
    self.vegetableTwoImageView.tag = 101;
    // 添加手势
    self.vegetableTwoImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dishDidSelected:)];
    [self.vegetableTwoImageView addGestureRecognizer:tap2];
    
    // 第三个蔬菜
    YHVegetable *vegetableThree = dish.vegetableList[2];
    NSURL *vegetabelTHreeUrl = [NSURL URLWithString:vegetableThree.imagePathThumbnails];
    [self.vegetableThreeImageView sd_setImageWithURL:vegetabelTHreeUrl];
    self.dishNameThreeLabel.text = vegetableThree.name;
    self.vegetableThreeImageView.tag = 102;
    // 添加手势
    self.vegetableThreeImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dishDidSelected:)];
    [self.vegetableThreeImageView addGestureRecognizer:tap3];
    
    
    if (indexPath.section == 0 & indexPath.row == 0) {
        self.hotImageView.hidden = NO;
    }else {
        self.hotImageView.hidden = YES;
    }
        
}


// 图片被点了
- (void)dishDidSelected:(UITapGestureRecognizer *)tap {
    
    // 第几个图片被点了
    NSInteger index = tap.view.tag - 100;
    
    NSLog(@"%ld",tap.view.tag - 100);
    
    [self.delegate dishDidSlectedWithDish:self.dish andIndex:index];
}


@end
