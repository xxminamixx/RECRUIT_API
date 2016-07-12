//
//  ShopViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/24.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ShopListViewController.h"
#import "ShopTableViewCell.h"
#import "ShopEntity.h"
#import "ShopDetailViewController.h"
#import "FavoriteShopManager.h"
#import "KissXMLHotpepperAPIFetcher.h"
#import "CuponViewController.h"

NSString * const shop_tableviewcell = @"ShopTableViewCell";
NSString * const nullCupon = @"http://hpr.jp/S/S511.jsp?SP=J000981130&uid=NULLGWDOCOMO&vos=hpp336";
NSMutableArray *recieve_shop;

@interface ShopListViewController () <shopDelegate, shopCellFavoriteDelegate, couponDelegate>
@property (weak, nonatomic) IBOutlet UITableView *shopTableView;
@property KissXMLHotpepperAPIFetcher *shopFetcher;
@property BOOL isFavorite; // お気に入り登録されているか判定
@property double labelAlpha;
@property NSDate *beforeCellTime;
@property NSDate *afterCellTime;
@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"検索結果一覧";
    
    self.shopFetcher = [KissXMLHotpepperAPIFetcher new];
    self.shopFetcher.shopDelegate = self;
    
    if (self.areacode != nil) {
        [self.shopFetcher shopRequestWithAreacode:self.areacode];
    }
    
    if (self.searchShopName != nil) {
        [self.shopFetcher shopRequestWithShopName:self.searchShopName];
    }
    
    if (self.genreCode != nil) {
        [self.shopFetcher shopRequestWithGenrecode:self.genreCode];
    }
    
    _shopTableView.delegate = self;
    _shopTableView.dataSource = self;

    //ViewControllerのViewにTableViewCellを登録
    UINib *shopNib = [UINib nibWithNibName:shop_tableviewcell bundle:nil];
    [self.shopTableView registerNib:shopNib forCellReuseIdentifier:shop_tableviewcell];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.shopTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource 

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    //セクションに含まれるセルの数を返す
    return recieve_shop.count;
}


// TODO: セルの最後まで読み込まないとブロック内が実行されない
// TODO: セルの再利用で画面に収まるcellが表示されたらこのメソッドが待機状態になる
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopTableViewCell *shopcell = [_shopTableView dequeueReusableCellWithIdentifier:shop_tableviewcell];
    ShopEntity *shopEntity = recieve_shop[indexPath.row];
    FavoriteShopManager *favoriteShopManager = [FavoriteShopManager new];
    shopcell.favoriteDelegate = self;
    shopcell.couponDeleate = self;
    shopcell.favoriteButton.alpha = 0.2;
    
    if (shopEntity.coupon != nil) {
        
    }
    
    if ([favoriteShopManager addedShopToFavorite:shopEntity.name]) {
        shopcell.favoriteButton.alpha = 1;
    }
    
    [shopcell setMyPropertyWithEntity:shopEntity];
    //[shopcell setShopLogoWithURL:shopEntity.logo];
    
    // URLをNSURLに変換
    NSURL *url = [NSURL URLWithString:shopEntity.logo];
    [shopcell imageRefresh:url];
    
    return shopcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopEntity *shopEntity = recieve_shop[indexPath.row];
     ShopTableViewCell *shopcell = [_shopTableView dequeueReusableCellWithIdentifier:shop_tableviewcell];
    [shopcell setMyPropertyWithEntity:shopEntity];
    int couponHeight = [shopcell couponHeightChanger];
    return 125 + couponHeight;
}


#pragma mark - UITableViewDelegate
// セルがタップされたときの処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShopDetailViewController *shopDetailView = [storyboard instantiateViewControllerWithIdentifier:@"ShopDetail"];
    
    //次画面へ選択したEntityを渡す
    ShopEntity *serveShopEnity = recieve_shop[indexPath.row];
    shopDetailView.shopEntity = serveShopEnity;
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:shopDetailView animated:YES];
}


#pragma mark - fetch shopEntity
- (void)getShop:(NSMutableArray *)shop
{
    NSLog(@"デリゲードメソッドが呼ばれました");
    recieve_shop = shop;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.shopTableView reloadData];
    });
}

- (void)favoriteCall:(ShopEntity *)shopEntity
{
    NSLog(@"お気に入りがコールされました");
    
    // マネージャーに投げて既にお気に入りに登録されているかチェックする
    FavoriteShopManager *favoriteManager = [FavoriteShopManager new];
    if ([favoriteManager isAlreadyFavorite:shopEntity]) {
        // お気に入り登録処理
        // 詳細表示しているお店のEntityをManagerに渡す
        [favoriteManager getFavoriteShop:shopEntity];
        
        // お気に入りされた
        [self.shopTableView reloadData];
        
    } else {
        // お気に入り登録がされず削除処理がされた
        [self.shopTableView reloadData];
    }
}

-(void) couponRequest:(NSString *)couponStr
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CuponViewController *couponViewController = [storyboard instantiateViewControllerWithIdentifier:@"Coupon"];
    couponViewController.couponStr = couponStr;
    [self.navigationController pushViewController:couponViewController animated:YES];
}


@end
