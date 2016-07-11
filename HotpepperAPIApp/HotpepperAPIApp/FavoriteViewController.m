//
//  FavoriteViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/29.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "FavoriteViewController.h"
#import "ShopTableViewCell.h"
#import "ShopEntity.h"
#import "ShopDetailViewController.h"
#import "FavoriteShopManager.h"
#import "TabBarController.h"
#import "AppDelegate.h"


NSString * const kShopTableViewCell = @"ShopTableViewCell";

@interface FavoriteViewController ()<FavoriteDelegate, shopCellFavoriteDelegate>
@property (weak, nonatomic) IBOutlet UITableView *favoriteTableView;
@property FavoriteShopManager *favoriteShopManager;
@property NSMutableArray *shopList;
@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"お気に入り";
    self.favoriteShopManager.favoriteDelegate = self;
    
    self.favoriteTableView.delegate = self;
    self.favoriteTableView.dataSource = self;
    
    //ViewControllerのViewにTableViewCellを登録
    UINib *shopNib = [UINib nibWithNibName:kShopTableViewCell bundle:nil];
    [self.favoriteTableView registerNib:shopNib forCellReuseIdentifier:kShopTableViewCell];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.favoriteShopManager = [FavoriteShopManager new];
   self.shopList = [self.favoriteShopManager fetchEntityList];
    [self.favoriteTableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    int couponHeight = [shopcell couponHeightChanger];
    return 125 + couponHeight;
}

// セルがタップされたときの処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //ここで送るメッセージはstoryboard名前の“Main.storyboard”
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 遷移先のViewControllerをStoryBoardをもとに作成
    //ここで送るメッセージはsroryboard ID
    ShopDetailViewController *shopDetailView = [storyboard instantiateViewControllerWithIdentifier:@"ShopDetail"];
    
    //次画面へ選択したEntityを渡す
    ShopEntity *serveShopEnity = self.shopList[indexPath.row];
    shopDetailView.shopEntity = serveShopEnity;
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:shopDetailView animated:YES];
}


// デリゲードメソッド
- (void)getFavorite:(NSMutableArray *)favoriteShop
{
    NSLog(@"お気に入りのデリゲードメソッドが呼ばれました");
    
    // 受け取った配列をプライペード配列に格納
    self.shopList = favoriteShop;
}

- (void)favoriteCall:(ShopEntity *)shopEntity
{
    NSLog(@"お気に入り");
    
    // マネージャーに投げて既にお気に入りに登録されているかチェックする
    FavoriteShopManager *favoriteManager = [FavoriteShopManager new];
    if ([favoriteManager isAlreadyFavorite:shopEntity]) {
        // お気に入り登録処理
        // 詳細表示しているお店のEntityをManagerに渡す
        [favoriteManager getFavoriteShop:shopEntity];

        // お気に入りされた
        [self.favoriteTableView reloadData];
        
    } else {
        // 更新されたお気に入り情報を取得
        self.shopList = [favoriteManager fetchEntityList];

        // お気に入り登録がされず削除処理がされた
        [self.favoriteTableView reloadData];
    }
}


@end
