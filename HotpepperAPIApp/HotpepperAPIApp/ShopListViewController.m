//
//  ShopViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/24.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ShopListViewController.h"
#import "HotpepperAPIFetcher.h"
#import "ShopTableViewCell.h"
#import "ShopEntity.h"
#import "ShopDetailViewController.h"
#import "FavoriteShopManager.h"

NSString * const shop_tableviewcell = @"ShopTableViewCell";
NSMutableArray *recieve_shop;

@interface ShopListViewController () <shopDelegate>
@property (weak, nonatomic) IBOutlet UITableView *shopTableView;
@property HotpepperAPIFetcher *shopfetcher;

@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shopfetcher = [HotpepperAPIFetcher new];
    _shopfetcher.shopdelegate = self;
    [_shopfetcher shopRequest:_areacode];
    
    _shopTableView.delegate = self;
    _shopTableView.dataSource = self;

    
    //　メモリ確保
    recieve_shop = [NSMutableArray array];
    
    //ViewControllerのViewにTableViewCellを登録
    UINib *shopNib = [UINib nibWithNibName:shop_tableviewcell bundle:nil];
    [self.shopTableView registerNib:shopNib forCellReuseIdentifier:shop_tableviewcell];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.shopTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    //セクションに含まれるセルの数を返す
    return recieve_shop.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopTableViewCell *shopcell = [_shopTableView dequeueReusableCellWithIdentifier:shop_tableviewcell];
    FavoriteShopManager *favoriteShopManager = [FavoriteShopManager new];
    ShopEntity *shopEntity = recieve_shop[indexPath.row];
    
    // お気に入り情報をフェッチ
    NSMutableArray *mutableFetchResults = [favoriteShopManager fetchEntityList];
    
    for (int i = 0; i < mutableFetchResults.count; i++) {
        ShopEntity *fetchShopEntity = mutableFetchResults[i];
        
        // フェッチしたEntityと表示しているセルのEntityの名前が同じならお気に入りボタンステータス変更
        if ([fetchShopEntity.name isEqualToString: shopEntity.name]) {
            shopcell.favoriteButton.alpha = 0.2;
        }

    }
    
     // ラベルに都道府県セット処理
    shopcell.shopName.text = shopEntity.name;
    shopcell.shopDescription.text = shopEntity.detail;
    [shopcell setShopLogoWithURL:shopEntity.logo];
    return shopcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
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
    ShopEntity *serveShopEnity = recieve_shop[indexPath.row];
    shopDetailView.shopEntity = serveShopEnity;
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:shopDetailView animated:YES];
}


- (void)getShop:(NSMutableArray *)shop
{
    NSLog(@"デリゲードメソッドが呼ばれました");
    recieve_shop = shop;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.shopTableView reloadData];
    });
}



@end
