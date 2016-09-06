//
//  ShopViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/24.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "HomeViewController.h" // 定数mainstoryboardを使うため
#import "ShopListViewController.h"
#import "ShopTableViewCell.h"
#import "ShopEntity.h"
#import "ShopDetailViewController.h"
#import "FavoriteShopManager.h"
#import "KissXMLHotpepperAPIFetcher.h"
#import "CuponViewController.h"

NSString * const shopListIDOfStoryboard  = @"Shop";


NSInteger loadNextCount = 0;

@interface ShopListViewController () <shopCellFavoriteDelegate, couponDelegate>

@property (weak, nonatomic) IBOutlet UITableView *shopTableView;

@property NSMutableArray *shopList;
@property KissXMLHotpepperAPIFetcher *shopFetcher;
@property BOOL isFavorite; // お気に入り登録されているか判定
@property double labelAlpha;


@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"検索結果一覧";
    self.shopFetcher = [KissXMLHotpepperAPIFetcher new];
    
    self.shopList = [NSMutableArray array];
    loadNextCount = 0;
    [self getShopList];
    
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

- (void) getShopList
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    // お店受け取りBlocks
    didFetchShopListBloack fetchCompleteBlock = ^(NSMutableArray *shopList){
        if (loadNextCount == 0) {
            self.shopList = shopList;
        } else {
            for (ShopEntity * entity in shopList) {
                [self.shopList addObject: entity];
            }
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    };
    
    if (self.areacode) {
        [self.shopFetcher shopRequestWithAreacode:self.areacode fetchCompleteBlock:fetchCompleteBlock loadNextCount:loadNextCount];
    }
    
    if (self.searchShopName) {
        [self.shopFetcher shopRequestWithShopName:self.searchShopName fetchCompleteBlock:fetchCompleteBlock];
    }
    
    if (self.genreCode) {
        [self.shopFetcher shopRequestWithGenrecode:self.genreCode fetchCompleteBlock:fetchCompleteBlock];
    }
}

#pragma mark - UITableViewDataSource 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //セクションに含まれるセルの数を返す
    return self.shopList.count + 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopTableViewCell *shopcell = [_shopTableView dequeueReusableCellWithIdentifier:shop_tableviewcell];
    FavoriteShopManager *favoriteShopManager = [FavoriteShopManager new];
    shopcell.favoriteDelegate = self;
    shopcell.couponDeleate = self;
    shopcell.favoriteButton.alpha = 0.2;
    
    if (self.shopList.count > indexPath.row){
        ShopEntity *shopEntity = self.shopList[indexPath.row];

        if (shopEntity.coupon != nil) {
            
        }
        
        if ([favoriteShopManager addedShopToFavorite:shopEntity.name]) {
            shopcell.favoriteButton.alpha = 1;
        }
        
        [shopcell setMyPropertyWithEntity:shopEntity];
        
        // URLをNSURLに変換
        NSURL *url = [NSURL URLWithString:shopEntity.logo];
        [shopcell imageRefresh:url];
        
        return shopcell;

    } else {
        UITableViewCell *loadNextCell = [UITableViewCell new];
        loadNextCell.textLabel.text = @"さらに読み込む";
        return loadNextCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shopList.count > indexPath.row) {
        ShopEntity *shopEntity = self.shopList[indexPath.row];
         ShopTableViewCell *shopcell = [_shopTableView dequeueReusableCellWithIdentifier:shop_tableviewcell];
        [shopcell setMyPropertyWithEntity:shopEntity];
        NSInteger couponHeight = [shopcell couponHeightChanger];
        return 125 + couponHeight;
    } else {
        return 50;
    }
}


#pragma mark - UITableViewDelegate

// セルがタップされたときの処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shopList.count > indexPath.row) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:mainStoryboard bundle:nil];
        ShopDetailViewController *shopDetailView = [storyboard instantiateViewControllerWithIdentifier:@"ShopDetail"];
        
        //次画面へ選択したEntityを渡す
        ShopEntity *serveShopEnity = self.shopList[indexPath.row];
        shopDetailView.shopEntity = serveShopEnity;
        
        // 画面をPUSHで遷移させる
        [self.navigationController pushViewController:shopDetailView animated:YES];
    } else {
        // 更読み処理
        loadNextCount++;
        [self getShopList];
        [self.shopTableView reloadData];
    }

}

#pragma mark - shopCellFavoriteDelegate

- (void)favoriteDidPush:(ShopEntity *)shopEntity
{
    NSLog(@"お気に入りがコールされました");
    
    // マネージャーに投げて既にお気に入りに登録されているかチェックする
    FavoriteShopManager *favoriteManager = [FavoriteShopManager new];
    if ([favoriteManager isAlreadyFavorite:shopEntity]) {
        // お気に入り登録処理
        // 詳細表示しているお店のEntityをManagerに渡す
        [favoriteManager favoriteShop:shopEntity];
        
        // お気に入りされた
        [self.shopTableView reloadData];
        
    } else {
        // お気に入り登録がされず削除処理がされた
        [self.shopTableView reloadData];
    }
}

-(void) couponDidPush:(NSString *)couponStr
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:mainStoryboard bundle:nil];
    CuponViewController *couponViewController = [storyboard instantiateViewControllerWithIdentifier:@"Coupon"];
    couponViewController.couponStr = couponStr;
    [self.navigationController pushViewController:couponViewController animated:YES];
}

@end
