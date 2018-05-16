//
//  HBK_ShoppingCartProtocol.h
//  HBK_ShoppingCart_MVP
//
//  Created by 黄冰珂 on 2018/5/13.
//  Copyright © 2018年 KK. All rights reserved.
//
//此处写一写协议, 比如刷新, 加载动画的展示和隐藏

#import <Foundation/Foundation.h>

@protocol HBK_ShoppingCartProtocol <NSObject>


@required;

- (void)showLoadingHUD;
- (void)hideLoadingHUD;
- (void)reloadData;

- (void)isAllSelect:(BOOL)selected;
- (void)isAllSelectSection:(BOOL)selected section:(NSInteger)section;
- (void)bottomViewAllPrice:(double)price;
- (void)deleteRowForIndexPath:(NSIndexPath *)indexPath;
- (void)bottomViewIsClick:(BOOL)isClick;

@end
