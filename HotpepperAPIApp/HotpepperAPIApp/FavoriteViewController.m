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

NSString * const kShopTableViewCell = @"ShopTableViewCell";
NSArray *shopList;

@interface FavoriteViewController ()<FavoriteDelegate>
@property (weak, nonatomic) IBOutlet UITableView *favoriteTableView;
@property FavoriteShopManager *favoriteShopManager;
@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.favoriteShopManager.favoriteDelegate = self;
    
    self.favoriteTableView.delegate = self;
    self.favoriteTableView.dataSource = self;
    
    //ViewControllerのViewにTableViewCellを登録
    UINib *shopNib = [UINib nibWithNibName:kShopTableViewCell bundle:nil];
    [self.favoriteTableView registerNib:shopNib forCellReuseIdentifier:kShopTableViewCell];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    //セクションに含まれるセルの数を返す
    return shopList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopTableViewCell *shopcell = [_favoriteTableView dequeueReusableCellWithIdentifier:kShopTableViewCell];
    
    // ラベルに都道府県セット処理
    ShopEntity *shopEntity = shopList[indexPath.row];
    shopcell.shopName.text = shopEntity.name;
    shopcell.shopDescription.text = shopEntity.detail;
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
    ShopEntity *serveShopEnity = shopList[indexPath.row];
    shopDetailView.shopEntity = serveShopEnity;
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:shopDetailView animated:YES];
 }


// デリゲードメソッド
- (void)getFavorite:(NSArray *)favoriteShop
{
    NSLog(@"お気に入りのデリゲードメソッドが呼ばれました");
    
    // 受け取った配列をプライペード配列に格納
    shopList = favoriteShop;
}

@end
