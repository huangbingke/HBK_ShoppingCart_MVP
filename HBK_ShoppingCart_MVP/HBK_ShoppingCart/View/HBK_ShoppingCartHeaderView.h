//
//  HBK_ShoppingCartHeaderView.h
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBK_ShoppingCartModel.h"
@class HBK_ShoppingCartPresenter;
@interface HBK_ShoppingCartHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;

@property (nonatomic, assign) BOOL isClick;

@property (nonatomic, copy) void (^ClickBlock)(BOOL isClick);

- (void)configureData:(HBK_ShoppingCartPresenter *)presenter section:(NSInteger)section;



@end
