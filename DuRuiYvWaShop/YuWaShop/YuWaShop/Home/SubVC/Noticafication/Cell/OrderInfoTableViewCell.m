//
//  OrderInfoTableViewCell.m
//  YuWaShop
//
//  Created by double on 17/4/8.
//  Copyright © 2017年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "OrderInfoTableViewCell.h"

@implementation OrderInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(AllOrderModel *)model{
    _model = model;
    [self setDataUI];
}

- (void)setDataUI{
    self.customer_nameLabel.text = self.model.customer_name;
    self.create_timeLabel.text = [JWTools getTime:self.model.create_time];
    self.total_moneyLabel.text = [NSString stringWithFormat:@"￥%@",self.model.total_money];
    self.orderStatusLabel.text = self.model.order_type;
}



@end
