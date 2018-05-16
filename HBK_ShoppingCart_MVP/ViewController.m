//
//  ViewController.m
//  HBK_ShoppingCart_MVP
//
//  Created by 黄冰珂 on 2018/5/13.
//  Copyright © 2018年 KK. All rights reserved.
//

#import "ViewController.h"
#import "HBK_ShoppingCartViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


//进入购物车
- (IBAction)go:(UIButton *)sender {
    HBK_ShoppingCartViewController *shoppingCartVC = [[HBK_ShoppingCartViewController alloc] init];
    shoppingCartVC.isSubPage = YES;
    [self.navigationController pushViewController:shoppingCartVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
