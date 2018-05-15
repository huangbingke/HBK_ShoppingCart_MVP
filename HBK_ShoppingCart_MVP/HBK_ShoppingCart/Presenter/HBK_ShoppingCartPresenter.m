//
//  HBK_ShoppingCartPresenter.m
//  HBK_ShoppingCart_MVP
//
//  Created by 黄冰珂 on 2018/5/13.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "HBK_ShoppingCartPresenter.h"

@implementation HBK_ShoppingCartPresenter



















- (NSMutableArray<HBK_StoreModel *> *)storeArray {
    if (!_storeArray) {
        _storeArray = [NSMutableArray new];
    }
    return _storeArray;
}


@end
