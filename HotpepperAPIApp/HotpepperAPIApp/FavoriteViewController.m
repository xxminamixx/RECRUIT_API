//
//  FavoriteViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/29.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "HomeViewController.h" // 定数mainstoryboardを使うため
#import "FavoriteViewController.h"
#import "ShopTableViewCell.h"
#import "ShopEntity.h"
#import "ShopDetailViewController.h"
#import "FavoriteShopManager.h"
#import "TabBarController.h"
#import "AppDelegate.h"
#import "CuponViewController.h"


@interface FavoriteViewController ()<shopCellFavoriteDelegate, couponDelegate>

@property (weak, nonatomic) IBOutlet UITableView *favoriteTableView;

@property FavoriteShopManager *favoriteShopManager;
@property NSMutableArray *shopList;

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"お気に入り";
    UIColor *navitationBarColor = [UIColor colorWithRed:60/255.0 green:179/255.0 blue:113/255.0 alpha:1.0];
    self.navigationController.navigationBar.barTintColor = navitationBarColor;
    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.favoriteTableView.delegate = self;
    self.favoriteTableView.dataSource = self;
    
    //ViewControllerのViewにTableViewCellを登録
    UINib *shopNib = [UINib nibWithNibName:kShopTableViewCell bundle:nil];
    [self.favoriteTableView registerNib:shopNib forCellReuseIdentifier:kShopTableViewCell];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.favoriteShopManager = [FavoriteShopManager new];
    
    getFavoriteShopList favoriteList = ^(NSMutableArray *shopList){
        self.shopList = shopList;
    };
    
    [self.favoriteShopManager setFavorite:favoriteList];
    
//    self.shopList = [self.favoriteShopManager getFavoriteList];
    [self.favoriteTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    //セクションに含まれるセルの数を返す
    return self.shopList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopTableViewCell *shopcell = [_favoriteTableView dequeueReusableCellWithIdentifier:kShopTableViewCell];
    shopcell.favoriteDelegate = self;
    shopcell.couponDeleate = self;
    
    // ラベルに都道府県セット処理
    ShopEntity *shopEntity = self.shopList[indexPath.row];
    [shopcell setMyPropertyWithEntity:shopEntity];
    
    // URLをNSURLに変換
    NSURL *url = [NSURL URLWithString:shopEntity.logo];
    [shopcell imageRefresh:url];
    
    return shopcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopEntity *shopEntity = self.shopList[indexPath.row];
    ShopTableViewCell *shopcell = [self.favoriteTableView dequeueReusableCellWithIdentifier:kShopTableViewCell];
    [shopcell setMyPropertyWithEntity:shopEntity];
    NSInteger couponHeight = [shopcell couponHeightChanger];
    return 125 + couponHeight;
}

// セルがタップされたときの処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //ここで送るメッセージはstoryboard名前の“Main.storyboard”
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:mainStoryboard bundle:nil];
    
    // 遷移先のViewControllerをStoryBoardをもとに作成
    //ここで送るメッセージはsroryboard ID
    ShopDetailViewController *shopDetailView = [storyboard instantiateViewControllerWithIdentifier:@"ShopDetail"];
    
    //次画面へ選択したEntityを渡す
    ShopEntity *serveShopEnity = self.shopList[indexPath.row];
    shopDetailView.shopEntity = serveShopEnity;
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:shopDetailView animated:YES];
}

- (void)favoriteDidPush:(ShopEntity *)shopEntity
{
    NSLog(@"お気に入り");
    
    // マネージャーに投げて既にお気に入りに登録されているかチェックする
    FavoriteShopManager *favoriteManager = [FavoriteShopManager new];
    if ([favoriteManager isAlreadyFavorite:shopEntity]) {
        // お気に入り登録処理
        // 詳細表示しているお店のEntityをManagerに渡す
        [favoriteManager favoriteShop:shopEntity];

        // お気に入りされた
        [self.favoriteTableView reloadData];
        
    } else {
        // 更新されたお気に入り情報を取得
        getFavoriteShopList favoriteList = ^(NSMutableArray *shopList){
            self.shopList = shopList;
        };
        
        [self.favoriteShopManager setFavorite:favoriteList];
        
        // お気に入り登録がされず削除処理がされた
        [self.favoriteTableView reloadData];
    }
}

- (void) couponDidPush:(NSString *)couponStr
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:mainStoryboard bundle:nil];
    CuponViewController *couponViewController = [storyboard instantiateViewControllerWithIdentifier:@"Coupon"];
    couponViewController.couponStr = couponStr;
    [self.navigationController pushViewController:couponViewController animated:YES];
}

@end
