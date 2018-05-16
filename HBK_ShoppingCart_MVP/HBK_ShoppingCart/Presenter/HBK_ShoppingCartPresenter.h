//
//  HBK_ShoppingCartPresenter.h
//  HBK_ShoppingCart_MVP
//
//  Created by 黄冰珂 on 2018/5/13.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "HBK_BasePresenter.h"
#import <UIKit/UIKit.h>
@class HBK_StoreModel;
@class HBK_GoodsModel;
@interface HBK_ShoppingCartPresenter : HBK_BasePresenter




//数据源
@property (nonatomic, strong) NSMutableArray <HBK_StoreModel *> *storeArray;
//选中的商品集合
@property (nonatomic, strong) NSMutableArray <HBK_GoodsModel *> *selectArray;

/** 模仿请求数据 */
- (void)loadingDataForPlist;


/** 判断是否全选 */
- (void)judgeIsAllSelect;

/** 判断某一个分区是否全选*/
- (void)judgeIsAllSelectSection:(NSInteger)section;

/** 计算价格 */
- (double)countPrice;

/** 刷新 */
- (void)reloadData;

/** 全选 */
- (void)shoppingCartBottomViewAllSelectGoods:(BOOL)isClick;

/** 删除某个商品 */
- (void)deleteGoodsWithIndexPath:(NSIndexPath *)indexPath;




@end
