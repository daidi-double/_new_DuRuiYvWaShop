//
//  YWHomeQuickPayListTableViewCell.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/29.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomeNoPayListTableViewCell.h"
#import "JWTools.h"

@implementation YWHomeNoPayListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(AllOrderModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}
- (void)dataSet{
    self.nameLabel.text = self.model.customer_name;
    self.timeLabel.text = [JWTools dateWithStr:self.model.pay_time];
    self.priceLabel.text = [NSString stringWithFormat:@"+%@元",self.model.pay_money];
    
}

- (NSString *)strDelZeraWithStr:(NSString *)str{
    NSString * priceStr = [str stringByReplacingOccurrencesOfString:@".00" withString:@""];
    priceStr = [priceStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    return priceStr;
}

@end
