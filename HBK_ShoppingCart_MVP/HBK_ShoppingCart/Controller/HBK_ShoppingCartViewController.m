//
//  HBK_ShoppingCartViewController.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShoppingCartViewController.h"
#import "HBK_ShoppingCartModel.h"
#import "HBK_ShoppingCartCell.h"
#import "HBK_ShoppingCartHeaderView.h"
#import "HBK_ShopppingCartBottomView.h"
#import "HBK_ShoppingCartPresenter.h"
#import "HBK_ShoppingCartProtocol.h"
#define kBottomHeight        kFit(50)

@interface HBK_ShoppingCartViewController ()<UITableViewDelegate, UITableViewDataSource, HBK_ShoppingCartProtocol, HBK_ShopppingCartBottomViewDelegate>


@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) HBK_ShopppingCartBottomView *bottomView;
@property (nonatomic, strong) HBK_ShoppingCartPresenter *presenter;

@end

@implementation HBK_ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"购物车";
    [self setSubViews];
    
    [self.presenter loadingDataForPlist];
    
}
#pragma  mark --------------------- UI ------------------
- (void)setSubViews {
    CGFloat tabBarHeight = kTabBarHeight;
    if (self.isSubPage) {
        tabBarHeight = kTabBarHeight-49;
    } else {
        tabBarHeight = kTabBarHeight;
    }
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight-tabBarHeight - kBottomHeight) style:(UITableViewStyleGrouped)];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    self.myTableView.tableFooterView = [[UIView alloc] init];
    [self.myTableView registerNib:[UINib nibWithNibName:@"HBK_ShoppingCartCell" bundle:nil] forCellReuseIdentifier:@"HBK_ShoppingCartCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"HBK_ShoppingCartHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HBK_ShoppingCartHeaderView"];
    
    self.bottomView = [[[NSBundle mainBundle] loadNibNamed:@"HBK_ShopppingCartBottomView" owner:nil options:nil] objectAtIndex:0];
    self.bottomView.frame = CGRectMake(0, kScreenHeight - tabBarHeight - kBottomHeight, kScreenWidth, kBottomHeight);
    self.bottomView.delegate = self;
    [self.view addSubview:self.bottomView];
}

#pragma mark ------------------ <UITableViewDelegate, UITableViewDataSource> ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.presenter.storeArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presenter.storeArray[section].goodsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBK_ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBK_ShoppingCartCell"];
    [cell configureData:self.presenter indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kFit(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HBK_ShoppingCartHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HBK_ShoppingCartHeaderView"];
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    [headerView configureData:self.presenter section:section];
    return headerView;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除?" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        kWeakSelf(self);
        [alert addAction:[UIAlertAction actionWithTitle:@"是" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            kStrongSelf(self);
            [self.presenter deleteGoodsWithIndexPath:indexPath];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"否" style:(UIAlertActionStyleDefault) handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - ------------------- HBK_ShoppingCartProtocol --------------------------
- (void)showLoadingHUD {
    NSLog(@"加载loading");
}

- (void)hideLoadingHUD {
    NSLog(@"隐藏loading");
}
- (void)reloadData {
    NSLog(@"刷新");
    [self.myTableView reloadData];
}

- (void)isAllSelect:(BOOL)selected {
    self.bottomView.isClick = selected;
}
- (void)isAllSelectSection:(BOOL)selected section:(NSInteger)section {
    HBK_ShoppingCartHeaderView *headerView = (HBK_ShoppingCartHeaderView *)[self.myTableView headerViewForSection:section];
    headerView.isClick = selected;
}

- (void)bottomViewAllPrice:(double)price {
    self.bottomView.allPriceLabel.text = [NSString stringWithFormat:@"合计 ￥%.2f", price];
}
- (void)deleteRowForIndexPath:(NSIndexPath *)indexPath {
    [self.myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
}
- (void)bottomViewIsClick:(BOOL)isClick {
    self.bottomView.isClick = isClick;
}


#pragma mark - -------------------- HBK_ShopppingCartBottomViewDelegate ----------------------------
- (void)shopppingCartBottomViewDidAllClickGoods:(BOOL)isClick {
    [self.presenter shoppingCartBottomViewAllSelectGoods:isClick];
}
- (void)shopppingCartBottomViewDidAccount {
    NSLog(@"去结算");
}
#pragma mark - Getter -
- (HBK_ShoppingCartPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[HBK_ShoppingCartPresenter alloc] init];
        [_presenter attachView:self];
    }
    return _presenter;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
