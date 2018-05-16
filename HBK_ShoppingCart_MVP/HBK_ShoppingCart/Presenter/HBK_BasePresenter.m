//
//  HBK_BasePresenter.m
//  HBK_ShoppingCart_MVP
//
//  Created by 黄冰珂 on 2018/5/15.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "HBK_BasePresenter.h"

@implementation HBK_BasePresenter



- (instancetype)initWithView:(id)view {
    if (self = [super init]) {
        _view = view;
    }
    return self;
}

- (void)attachView:(id)view {
    _view = view;
}

- (void)detachView:(id)view {
    _view = nil;
}





@end
