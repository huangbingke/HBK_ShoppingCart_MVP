//
//  HBK_BasePresenter.h
//  HBK_ShoppingCart_MVP
//
//  Created by 黄冰珂 on 2018/5/15.
//  Copyright © 2018年 KK. All rights reserved.
//
//此类为Presenter的基类, 主要做绑定视图的作用, 之后每个控制器的Presenter类要继承此类.

#import <Foundation/Foundation.h>

@interface HBK_BasePresenter<E> : NSObject
{
    //MVP中负责更新的视图
    __weak E _view;
}


/**
 初始化
 @param view 要绑定的视图
 */
- (instancetype)initWithView:(E)view;


/**
 绑定视图
 @param view 要绑定的视图
 */
- (void)attachView:(E)view;


/**
 解绑视图
 @param view 要解绑的视图
 */
- (void)detachView:(E)view;



@end
