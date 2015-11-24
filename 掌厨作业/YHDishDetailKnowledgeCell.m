//
//  YHDishDetailKnowledgeCell.m
//  掌厨作业
//
//  Created by MS on 15-9-20.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHDishDetailKnowledgeCell.h"
#import "UIImageView+WebCache.h"


@interface YHDishDetailKnowledgeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *guideLabel;

@end

@implementation YHDishDetailKnowledgeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString *cellName = NSStringFromClass([self class]);
    
    UINib *nib = [UINib nibWithNibName:cellName bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:cellName];
    
    return [tableView dequeueReusableCellWithIdentifier:cellName];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setImage:(NSString *)imagePath andDescribe:(NSString *)describe andGuide:(NSString *)guide {
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
    self.descriptionLabel.text = describe;
    self.guideLabel.text = guide;
}

@end
