//
//  YHDishDetailMaterialCell.m
//  掌厨作业
//
//  Created by MS on 15-9-20.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHDishDetailMaterialCell.h"

@interface YHDishDetailMaterialCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;



@end

@implementation YHDishDetailMaterialCell

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setDetailDecription:(NSString *)detailDecription {
    _detailDecription = detailDecription;
    _detailDescriptionLabel.text = detailDecription;
}

- (void)awakeFromNib {
    
}

+ (instancetype)dishDetailMaterialCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
