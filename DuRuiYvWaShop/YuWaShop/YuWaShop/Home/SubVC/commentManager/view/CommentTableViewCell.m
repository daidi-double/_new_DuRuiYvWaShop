//
//  CommentTableViewCell.m
//  YuWa
//
//  Created by 黄佳峰 on 16/9/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "CommentModel.h"
#import "JWTools.h"
#import "MyLabel.h"
@interface CommentTableViewCell()
@property(nonatomic,strong)NSMutableArray*maSaveImageView;

@property(nonatomic,strong)UIView*lineView;
@property(nonatomic,strong)UIImageView*messageImageView;
@property(nonatomic,strong)MyLable*sellerShowLabel;
@property(nonatomic,strong)NSMutableArray * allRep_contents;
@property(nonatomic,strong)NSMutableArray * rep_contents;
@property(nonatomic,strong)NSMutableArray * labelHeight;

@end
@implementation CommentTableViewCell
- (NSMutableArray *)rep_contents{
    if (!_rep_contents) {
        _rep_contents = [NSMutableArray array];
    }
    return _rep_contents;
}
- (NSMutableArray *)allRep_contents{
    if (!_allRep_contents) {
        _allRep_contents = [NSMutableArray array];
    }
    return _allRep_contents;
}
-(NSMutableArray * )labelHeight{
    if (!_labelHeight) {
        _labelHeight = [NSMutableArray array];
    }
    return _labelHeight;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
    UIButton*accordButton=[self viewWithTag:233];
    accordButton.userInteractionEnabled=NO;
}

-(void)giveValueWithModel:(ShopdetailModel *)model{
    //默认的数据
    UIImageView*imageView=[self viewWithTag:1];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.customer_img] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
    UILabel*nameLabel=[self viewWithTag:2];
    nameLabel.text=model.customer_name;
    
    UILabel*timeLabel=[self viewWithTag:3];
    timeLabel.text=[JWTools getTime:model.ctime];
    
    //星星数量 -------------------------------------------------------
    CGFloat realZhengshu;
    CGFloat realXiaoshu;

    NSString*starNmuber=model.score;
    NSString*zhengshu=[starNmuber substringToIndex:1];
    realZhengshu=[zhengshu floatValue];
    NSString*xiaoshu=[starNmuber substringFromIndex:1];
    CGFloat CGxiaoshu=[xiaoshu floatValue];
    
    if (CGxiaoshu>0.5) {
        realXiaoshu=0;
        realZhengshu= realZhengshu+1;
    }else if (CGxiaoshu>0&&CGxiaoshu<=0.5){
        realXiaoshu=0.5;
    }else{
        realXiaoshu=0;
        
    }
    
    for (int i=30; i<35; i++) {
        UIImageView*imageView=[self viewWithTag:i];
        if (imageView.tag-30<realZhengshu) {
            //亮
            imageView.image=[UIImage imageNamed:@"home_lightStar"];
        }else if (imageView.tag-30==realZhengshu&&realXiaoshu!=0){
            //半亮
            imageView.image=[UIImage imageNamed:@"home_halfStar"];
            
        }else{
            //不亮
            imageView.image=[UIImage imageNamed:@"home_grayStar"];
        }
        
        
    }

    // --------------------------------------------------------
    
#pragma  50 的地方
    NSString*detailStr=model.customer_content;
   MyLable *detailLabel=[self viewWithTag:112];
    if (!detailLabel) {
        MyLog(@"model.rep_list = %@",model.rep_list);
        detailLabel=[[MyLable alloc]initWithFrame:CGRectMake(65, 50, kScreen_Width-65-50, 0)];
        detailLabel.font=FONT_CN_24;
        detailLabel.numberOfLines=0;
        detailLabel.tag=112;
        [detailLabel setVerticalAlignment:VerticalAlignmentTop];
       [self.contentView addSubview:detailLabel];
    }
    
       detailLabel.text=detailStr;
    CGFloat strHeight=[detailLabel.text boundingRectWithSize:CGSizeMake(kScreen_Width-65-50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:detailLabel.font} context:nil].size.height;
//    if (strHeight < 16.8*4) {
//        detailLabel.height = strHeight;
//    }else{
//        detailLabel.height = 16.8 * 4;
//    }
    detailLabel.height=strHeight;//1行高度为16.8
    
    
    NSArray*imageArray=model.img_url;
    CGFloat Top=detailLabel.bottom+10;
    CGFloat Left=65;
    CGFloat HJianju=10;
    CGFloat VJianJu=10;
    CGFloat With=(kScreen_Width-65-30-2*HJianju)/3;
    CGFloat Height=With;
    
    for (UIView*view in self.maSaveImageView) {
        [view removeFromSuperview];
    }
    _maSaveImageView=[NSMutableArray array];
    for (int i=0; i<imageArray.count; i++) {
        int HNmuber=i%3;
        int VNumber=i/3;
        
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(Left+(With+HJianju)*HNmuber, Top+(Height+VJianJu)*VNumber, With, Height)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        [self.contentView addSubview:imageView];
        [_maSaveImageView addObject:imageView];
        
    }
    
    //图片的底部
    NSUInteger VNumber=(imageArray.count-1)/3;
    CGFloat imageVHeight;

    if (imageArray.count>0) {
        imageVHeight=Height+(Height+VJianJu)*VNumber+10;
    }else{
        imageVHeight=0;
    }
    CGFloat realImageViewBottom=Top+imageVHeight;
//    if (strHeight <= 16.8*4) {
//        
//        realImageViewBottom=Top+imageVHeight;     //图片底部的位置
//    }else{
//        
//        realImageViewBottom = imageVHeight+Top/1.4;
//        
//    }
    
//    
//    if (detailLabel.height > 16.8*4 ) {
//        static int a = 0;
//        UIButton * allCommentBtn = nil;
//        if (a == 0) {
//        allCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        }
//        allCommentBtn.frame = CGRectMake(65, realImageViewBottom - 20, 80, 20);
////        [allCommentBtn setBackgroundColor:CNaviColor];
//        [allCommentBtn setTitle:@"查看全部" forState:UIControlStateNormal];
////        [allCommentBtn setTitle:@"收起内容" forState:UIControlStateSelected];
//        [allCommentBtn setTitleColor:CNaviColor forState:UIControlStateNormal];
//        [allCommentBtn setTitleColor:CNaviColor forState:UIControlStateSelected];
//        allCommentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        allCommentBtn.selected = NO;
//        [allCommentBtn addTarget:self action:@selector(seeMore:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.contentView addSubview:allCommentBtn];
//            a ++ ;
//       
//    
//    }

    [self.lineView removeFromSuperview];
    [self.messageImageView removeFromSuperview];
    [self.sellerShowLabel removeFromSuperview];
    self.sellerShowLabel=nil;
    
    
    
    
    NSString*seller_content=model.seller_content;
    if (seller_content==nil||[seller_content isEqualToString:@""]) {
        return;
    }
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(65, realImageViewBottom, kScreen_Width-65, 1)];
    self.lineView.backgroundColor=RGBCOLOR(226, 226, 226, 1);
    [self.contentView addSubview:self.lineView];

    self.messageImageView=[[UIImageView alloc]initWithFrame:CGRectMake(65, self.lineView.bottom+2, 20, 20)];
    self.messageImageView.image=[UIImage imageNamed:@"messageImage"];
    [self.contentView addSubview:self.messageImageView];
    
    self.sellerShowLabel=[[MyLable alloc]initWithFrame:CGRectMake(65+20+10, self.lineView.bottom+2, kScreen_Width-65-30-20, 0)];
    self.sellerShowLabel.text = seller_content;
    self.sellerShowLabel.font = [UIFont systemFontOfSize:14];
    self.sellerShowLabel.numberOfLines=0;
    CGFloat labelHeight=[seller_content boundingRectWithSize:CGSizeMake(kScreen_Width-65-30-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    MyLable * seller_contentLabel;
    if (seller_contentLabel) {
        [seller_contentLabel removeFromSuperview];
    }
    CGFloat repLabelHeight = 0.0;
    if (self.rep_contents.count != 0) {
        [self.rep_contents removeAllObjects];
    }
    if (self.allRep_contents.count != 0) {
        [self.allRep_contents removeAllObjects];
    }
    if (self.labelHeight.count != 0) {
        [self.labelHeight removeAllObjects];
    }
    [self.labelHeight addObject:@(0)];
    for (NSDictionary * contentDic in model.rep_list) {
        NSString * rep = contentDic[@"content"];
        [self.rep_contents addObject:rep];
        repLabelHeight=[rep boundingRectWithSize:CGSizeMake(kScreen_Width-65-30-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.sellerShowLabel.font} context:nil].size.height;
        [self.labelHeight addObject:@(repLabelHeight)];
    }
    
    [self.allRep_contents addObject:self.rep_contents];
    [self.allRep_contents addObject:self.labelHeight];
    
    self.sellerShowLabel.height =labelHeight;
    for (int i = 0; i < model.rep_list.count; i ++) {
        self.messageImageView = [[UIImageView alloc]initWithFrame:CGRectMake(65, 60 + labelHeight + strHeight+ [_allRep_contents[1][i] floatValue]*i +5, 20, 20)];
        seller_contentLabel = [[MyLable alloc]initWithFrame:CGRectMake(95, 60 + labelHeight + strHeight+ [_allRep_contents[1][i] floatValue]*i +5 , kScreen_Width - 65 -30 -20, [_allRep_contents[1][i] floatValue] +5)];
//        if (i == 0) {
//            self.messageImageView.y = 60 + labelHeight + strHeight+ 5;
//            seller_contentLabel.y = 60 + labelHeight + strHeight + 5;
//        }
        self.messageImageView.image=[UIImage imageNamed:@"messageImage"];
        [self.contentView addSubview:self.messageImageView];
        seller_contentLabel.font = [UIFont systemFontOfSize:14];
        seller_contentLabel.numberOfLines = 0;
        seller_contentLabel.text = _allRep_contents[0][i];
        seller_contentLabel.height =[_allRep_contents[1][i+1] floatValue];
        [self.contentView addSubview:seller_contentLabel];
        
    }
    
    [self.contentView addSubview:self.sellerShowLabel];

}

//- (void)seeMore:(UIButton*)sender{
//    sender.selected = !sender.selected;
//    MyLable *detailLabel=[self viewWithTag:112];
//    CGFloat strHeight=[detailLabel.text boundingRectWithSize:CGSizeMake(kScreen_Width-65-50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:detailLabel.font} context:nil].size.height;
//
//    if (sender.selected == YES) {
//        detailLabel.numberOfLines = 0;
//        detailLabel.height = strHeight;
//        sender.y = strHeight + 50;
//        [sender setTitle:@"收起内容" forState:UIControlStateNormal];
//
//    }else{
////        [self.cellDelegate changCellHeight:1];
//        detailLabel.numberOfLines = 4;
//         [sender setTitle:@"查看全部" forState:UIControlStateNormal];
//    }
//    [self.cellDelegate changCellHeight:0];
//    
//}
//

+(CGFloat)getCellHeight:(ShopdetailModel*)model{
    NSString*detailStr=model.customer_content;
    CGFloat strHeight=[detailStr boundingRectWithSize:CGSizeMake(kScreen_Width-65-50, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    CGFloat imageTop =50+strHeight+10;
    
    NSArray*imageArray=model.img_url;
    
    CGFloat HJianju=10;
    CGFloat VJianJu=10;
    CGFloat With=(kScreen_Width-65-30-2*HJianju)/3;
    CGFloat Height=With;
    
    CGFloat imageBottom;
    
    if (imageArray.count>0) {
        NSUInteger VNumber=(imageArray.count-1)/3;
        CGFloat imageVHeight=Height+(Height+VJianJu)*VNumber+5;
        imageBottom=imageTop+imageVHeight;
        
    }
    else{
        imageBottom=imageTop;
    }
    
    
    if (model.seller_content==nil||[model.seller_content isEqualToString:@""]) {
        return imageBottom;
    }
    CGFloat repLabelHeight = 0.0;
    NSString * rep = nil;
    NSMutableArray * rep_contentArr;
    if (rep_contentArr) {
        [rep_contentArr removeAllObjects];
    }
    rep_contentArr = [NSMutableArray array];
    CGFloat labelHeight = 0.0 ;
    for (NSDictionary * contentDic in model.rep_list) {
        
        rep = contentDic[@"content"];
        [rep_contentArr addObject:rep];
        repLabelHeight=[rep boundingRectWithSize:CGSizeMake(kScreen_Width-65-30-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        labelHeight = labelHeight + repLabelHeight;
    }
    
    //图片的底部
    //    CGFloat labelHeight=[model.seller_content boundingRectWithSize:CGSizeMake(kScreen_Width-65-30 -20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    CGRect labelH = [model.seller_content boundingRectWithSize:CGSizeMake(kScreen_Width-65-30 -20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    //        return imageBottom +labelHeight +20;
    //    MyLog(@"imageBottom + labelH.size.height + 10 = %f,%f,%f",imageBottom + labelH.size.height + 10,imageBottom,labelH.size.height);
    
    return imageBottom + labelH.size.height + 20 + labelHeight;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
