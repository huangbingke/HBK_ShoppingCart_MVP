//
//  HBK_ShoppingCartHeaderView.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShoppingCartHeaderView.h"
#import "HBK_ShoppingCartPresenter.h"

@interface HBK_ShoppingCartHeaderView ()

@property (nonatomic, strong) HBK_StoreModel *storeModel;
@property (nonatomic, weak) HBK_ShoppingCartPresenter *presenter;


@end
@implementation HBK_ShoppingCartHeaderView

- (IBAction)click:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.storeModel.isSelect = sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"clicked"] forState:(UIControlStateNormal)];
        for (HBK_GoodsModel *goodsModel in self.storeModel.goodsArray) {
            goodsModel.isSelect = YES;
            if (![self.presenter.selectArray containsObject:goodsModel]) {
                [self.presenter.selectArray addObject:goodsModel];
            }
        }
    } else {
        [sender setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
        for (HBK_GoodsModel *goodsModel in self.storeModel.goodsArray) {
            goodsModel.isSelect = NO;
            if ([self.presenter.selectArray containsObject:goodsModel]) {
                [self.presenter.selectArray removeObject:goodsModel];
            }
        }
    }
    [self.presenter judgeIsAllSelect];
    [self.presenter reloadData];
    [self.presenter countPrice];
}

- (void)setIsClick:(BOOL)isClick {
    _isClick = isClick;
    self.clickBtn.selected = isClick;
    if (isClick) {
        [self.clickBtn setImage:[UIImage imageNamed:@"clicked"] forState:(UIControlStateNormal)];
    } else {
        [self.clickBtn setImage:[UIImage imageNamed:@"unClick"] forState:(UIControlStateNormal)];
    }
}


- (void)configureData:(HBK_ShoppingCartPresenter *)presenter section:(NSInteger)section {
    self.presenter = presenter;
    self.storeModel = presenter.storeArray[section];
    self.storeNameLabel.text = self.storeModel.shopName;
    self.isClick = self.storeModel.isSelect;
}




@end
