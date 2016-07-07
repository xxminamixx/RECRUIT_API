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

@interface ShopListViewController () <shopDelegate, shopCellFavoriteDelegate>
@property (weak, nonatomic) IBOutlet UITableView *shopTableView;
@property HotpepperAPIFetcher *shopfetcher;
@property BOOL isFavorite; // お気に入り登録されているか判定
@property double labelAlpha;
@property NSDate *beforeCellTime;
@property NSDate *afterCellTime;
@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"検索結果一覧";
    
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
    shopcell.favoriteButton.alpha = 0.2;
    
    
    if ([favoriteShopManager addedShopToFavorite:shopEntity.name]) {
        shopcell.favoriteButton.alpha = 1;
    }
    
    [shopcell setMyPropertyWithEntity:shopEntity];
    //[shopcell setShopLogoWithURL:shopEntity.logo];
    
    // URLをNSURLに変換
    NSURL *url = [NSURL URLWithString:shopEntity.logo];

    [shopcell sd_setImageWithURL:url
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           [self.shopTableView setNeedsLayout];
                           [self.shopTableView layoutIfNeeded];
                       }];
    //　処理時間計算
    if (indexPath.row % 2 == 0) {
        self.afterCellTime = [NSDate date];
        // 開始時間と終了時間の差を表示
        NSTimeInterval interval = [self.afterCellTime timeIntervalSinceDate:self.beforeCellTime];
        NSLog(@"処理時間 = %.3f秒",interval);
    } else {
        self.beforeCellTime = [NSDate date];
    }
    
    return shopcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}


#pragma mark - UITableViewDelegate
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


// 日付をミリ秒までの表示にして文字列で返すメソッド
- (NSString*)getDateString:(NSDate*)date
{
    // 日付フォーマットオブジェクトの生成
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    // フォーマットを指定の日付フォーマットに設定
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss.SSS"];
    // 日付の文字列を生成
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

@end
