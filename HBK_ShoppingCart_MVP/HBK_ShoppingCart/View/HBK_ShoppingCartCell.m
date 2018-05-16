//
//  HBK_ShoppingCartCell.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShoppingCartCell.h"
#import "HBK_ShoppingCartPresenter.h"

@interface HBK_ShoppingCartCell ()

@property (nonatomic, strong) HBK_GoodsModel *goodsModel;
@property (nonatomic, strong) HBK_StoreModel *storeModel;

@property (nonatomic, weak) HBK_ShoppingCartPresenter *presenter;
@property (nonatomic, weak) NSIndexPath *indexPath;

@end
@implementation HBK_ShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//减
- (IBAction)cut:(UIButton *)sender {
    NSInteger count = [self.countLabel.text integerValue];
    count--;
    if (count <= 0) {
        return;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)count];
    self.goodsModel.count = self.countLabel.text;

    [self.storeModel.goodsArray replaceObjectAtIndex:self.indexPath.row withObject:self.goodsModel];
    if ([self.presenter.selectArray containsObject:self.goodsModel]) {
        [self.presenter.selectArray removeObject:self.goodsModel];
        [self.presenter.selectArray addObject:self.goodsModel];
        [self.presenter countPrice];
    }
    
}

//加
- (IBAction)add:(UIButton *)sender {
    NSInteger count = [self.countLabel.text integerValue];
    count++;
    self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)count];
    self.goodsModel.count = self.countLabel.text;
    
    HBK_StoreModel *storeModel = self.presenter.storeArray[self.indexPath.section];
    
    [storeModel.goodsArray replaceObjectAtIndex:self.indexPath.row withObject:self.goodsModel];
    if ([self.presenter.selectArray containsObject:self.goodsModel]) {
        [self.presenter.selectArray removeObject:self.goodsModel];
        [self.presenter.selectArray addObject:self.goodsModel];
        [self.presenter countPrice];
    }
}

//选中
- (IBAction)click:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.goodsModel.isSelect = sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"clicked"] forState:(UIControlStateNormal)];
        [self.presenter.selectArray addObject:self.goodsModel];
    } else {
        [sender setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
        [self.presenter.selectArray removeObject:self.goodsModel];
    }    
    
    [self.presenter judgeIsAllSelect];
    [self.presenter judgeIsAllSelectSection:self.indexPath.section];
    [self.presenter countPrice];

}

- (void)configureData:(HBK_ShoppingCartPresenter *)presenter indexPath:(NSIndexPath *)indexPath {
    self.presenter = presenter;
    self.indexPath = indexPath;
    self.storeModel = presenter.storeArray[indexPath.section];
    self.goodsModel = self.storeModel.goodsArray[indexPath.row];
    self.clickBtn.selected = self.goodsModel.isSelect;
    if (self.goodsModel.isSelect) {
        [self.clickBtn setImage:[UIImage imageNamed:@"clicked"] forState:(UIControlStateNormal)];
    } else {
        [self.clickBtn setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
    }
    self.countLabel.text = [NSString stringWithFormat:@"%@", self.goodsModel.count];
    self.goodImageView.backgroundColor = kRandomColor;
    self.goodsNameLabel.text = self.goodsModel.goodsName;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元", self.goodsModel.realPrice];
    self.brandLabel.text = [NSString stringWithFormat:@"%@", self.goodsModel.shopName];
}










@end
