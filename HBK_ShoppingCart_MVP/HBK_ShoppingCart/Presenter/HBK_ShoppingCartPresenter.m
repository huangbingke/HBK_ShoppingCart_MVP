//
//  HBK_ShoppingCartPresenter.m
//  HBK_ShoppingCart_MVP
//
//  Created by 黄冰珂 on 2018/5/13.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "HBK_ShoppingCartPresenter.h"
#import "HBK_ShoppingCartProtocol.h"
#import "HBK_ShoppingCartModel.h"

@implementation HBK_ShoppingCartPresenter















#pragma mark  -------------------- 此处模仿网络请求, 加载plist文件内容

- (void)loadingDataForPlist {
    //加载动画
    [_view showLoadingHUD];
    //延迟1秒执行, 模仿网络请求
    sleep(1);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ShopCarNew" ofType:@"plist"];
    NSDictionary *dataDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"%@", dataDic);
    NSArray *dataArray = dataDic[@"data"];
    if (dataArray.count > 0) {
        for (NSDictionary *dic in dataArray) {
            HBK_StoreModel *model = [[HBK_StoreModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.storeArray addObject:model];
        }
        //隐藏加载动画
        [_view hideLoadingHUD];
        //刷新视图
        [self reloadData];
    }
}

#pragma mark - --------- 逻辑处理 ----------------
- (void)judgeIsAllSelect {
    NSInteger count = 0;
    //先遍历购物车商品, 得到购物车有多少商品
    for (HBK_StoreModel *storeModel in self.storeArray) {
        count += storeModel.goodsArray.count;
    }
    //如果购物车总商品数量 等于 选中的商品数量, 即表示全选了
    if (count == self.selectArray.count) {
        [_view isAllSelect:YES];
    } else {
        [_view isAllSelect:NO];
    }
}

- (void)judgeIsAllSelectSection:(NSInteger)section {
    HBK_StoreModel *storeModel = self.storeArray[section];
    BOOL isSelectSection = YES;
    //遍历分区商品, 如果有商品的没有被选择, 跳出循环, 说明没有全选
    for (HBK_GoodsModel *goodsModel in storeModel.goodsArray) {
        if (goodsModel.isSelect == NO) {
            isSelectSection = NO;
            break;
        }
    }
    //全选了以后, 改变一下选中状态
    [_view isAllSelectSection:isSelectSection section:section];
    storeModel.isSelect = isSelectSection;
}

- (double)countPrice {
    double totlePrice = 0.0;
    for (HBK_GoodsModel *goodsModel in self.selectArray) {
        double price = [goodsModel.realPrice doubleValue];
        totlePrice += price * [goodsModel.count integerValue];
    }
    [_view bottomViewAllPrice:totlePrice];
    return totlePrice;
}

- (void)reloadData {
    [_view reloadData];
}

- (void)shoppingCartBottomViewAllSelectGoods:(BOOL)isClick {
    for (HBK_GoodsModel *goodsModel in self.selectArray) {
        goodsModel.isSelect = NO;
    }
    [self.selectArray removeAllObjects];
    if (isClick) {//选中
        NSLog(@"全选");
        for (HBK_StoreModel *storeModel in self.storeArray) {
            storeModel.isSelect = YES;
            for (HBK_GoodsModel *goodsModel in storeModel.goodsArray) {
                goodsModel.isSelect = YES;
                [self.selectArray addObject:goodsModel];
            }
        }
    } else {//取消选中
        NSLog(@"取消全选");
        for (HBK_StoreModel *storeModel in self.storeArray) {
            storeModel.isSelect = NO;
        }
    }
    [self reloadData];
    [self countPrice];
}

- (void)deleteGoodsWithIndexPath:(NSIndexPath *)indexPath {
    HBK_StoreModel *storeModel = [self.storeArray objectAtIndex:indexPath.section];
    HBK_GoodsModel *goodsModel = [storeModel.goodsArray objectAtIndex:indexPath.row];
    [storeModel.goodsArray removeObjectAtIndex:indexPath.row];
    [_view deleteRowForIndexPath:indexPath];
    if (storeModel.goodsArray.count == 0) {
        [self.storeArray removeObjectAtIndex:indexPath.section];
    }
    
    if ([self.selectArray containsObject:goodsModel]) {
        [self.selectArray removeObject:goodsModel];
        [self countPrice];
    }
    
    NSInteger count = 0;
    for (HBK_StoreModel *storeModel in self.storeArray) {
        count += storeModel.goodsArray.count;
    }
    if (self.selectArray.count == count) {
        [_view bottomViewIsClick:YES];
    } else {
        [_view bottomViewIsClick:NO];
    }
    
    if (count == 0) {
        //此处加载购物车为空的视图
        
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}



#pragma mark - getter -
- (NSMutableArray<HBK_StoreModel *> *)storeArray {
    if (!_storeArray) {
        _storeArray = [NSMutableArray<HBK_StoreModel *> new];
    }
    return _storeArray;
}

- (NSMutableArray<HBK_GoodsModel *> *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray<HBK_GoodsModel *> new];
    }
    return _selectArray;
}

@end
