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
NSMutableArray *shopList;

@interface FavoriteViewController ()<FavoriteDelegate, shopCellFavoriteDelegate>
@property (weak, nonatomic) IBOutlet UITableView *favoriteTableView;
@property FavoriteShopManager *favoriteShopManager;
@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"お気に入り";
    
    self.favoriteTableView.delegate = self;
    self.favoriteTableView.dataSource = self;
    
    //ViewControllerのViewにTableViewCellを登録
    UINib *shopNib = [UINib nibWithNibName:kShopTableViewCell bundle:nil];
    [self.favoriteTableView registerNib:shopNib forCellReuseIdentifier:kShopTableViewCell];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    shopList = [NSMutableArray array];
    
    //イベントのフェッチ
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FavoriteShopEntity"
                                              inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext
                                            executeFetchRequest:request error:&error] mutableCopy];
    
    // 起動時eventArrayに保持していたデータを格納処理追加
    shopList = mutableFetchResults;
    
    // setFavoriteにcontextを渡す
    // tabberbottunを押したら呼ぶ
    // [self.favoriteShopManager setFavorite];

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
    return shopList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopTableViewCell *shopcell = [_favoriteTableView dequeueReusableCellWithIdentifier:kShopTableViewCell];
    shopcell.favoriteDelegate = self;
    
    // ラベルに都道府県セット処理
    ShopEntity *shopEntity = shopList[indexPath.row];
    [shopcell setMyPropertyWithEntity:shopEntity];
    
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
- (void)getFavorite:(NSMutableArray *)favoriteShop
{
    NSLog(@"お気に入りのデリゲードメソッドが呼ばれました");
    
    // 受け取った配列をプライペード配列に格納
    shopList = favoriteShop;
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
        [self.favoriteTableView reloadData];
        
    } else {
        // お気に入り登録がされず削除処理がされた
        [self.favoriteTableView reloadData];
    }
}


@end
