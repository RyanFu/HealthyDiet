//
//  YHDishDetailStepCell.m
//  掌厨作业
//
//  Created by MS on 15-9-20.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHDishDetailStepCell.h"

#import "UIImageView+WebCache.h"

@interface YHDishDetailStepCell ()

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@end

@implementation YHDishDetailStepCell


- (void)setImagePath:(NSString *)imagePath {
    _imagePath = imagePath;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:_imagePath]];
}

- (void)setDescribe:(NSString *)describe {
    _describe = describe;
    self.descriptionLabel.text = describe;
}

- (void)setOrder_id:(NSString *)order_id {
    _order_id = order_id;
    self.stepLabel.text = order_id;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (id)cellWithTableView:(UITableView *)tableView {
    
    
    NSString *identfier = NSStringFromClass(self);
    
    UINib *nib = [UINib nibWithNibName:identfier bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:identfier];
    
    return [tableView dequeueReusableCellWithIdentifier:identfier];

}

@end
