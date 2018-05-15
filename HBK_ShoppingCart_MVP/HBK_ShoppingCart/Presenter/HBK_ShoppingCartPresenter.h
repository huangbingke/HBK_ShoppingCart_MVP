//
//  HBK_ShoppingCartPresenter.h
//  HBK_ShoppingCart_MVP
//
//  Created by 黄冰珂 on 2018/5/13.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HBK_StoreModel;

@interface HBK_ShoppingCartPresenter<E> : NSObject

{
    //MVP中负责更新的视图
    __weak E _view;
}



@property (nonatomic, strong) NSMutableArray <HBK_StoreModel *> *storeArray;













@end
