//
//  ShopGenreViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/12.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "HomeViewController.h" // 定数mainstoryboardを使うため
#import "ShopGenreViewController.h"
#import "KissXMLHotpepperAPIFetcher.h"
#import "ServiceAreaTableViewCell.h"
#import "ShopGenreEntity.h"
#import "ShopGenreTableViewCell.h"
#import "ShopListViewController.h"

NSString * const genreIDOfStoryboard = @"ShopGenre";

@interface ShopGenreViewController()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *genreTableView;
@property NSMutableArray *genreList;

@end

@implementation ShopGenreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ジャンル一覧";
    KissXMLHotpepperAPIFetcher *fetcher = [KissXMLHotpepperAPIFetcher new];
    self.genreTableView.delegate = self;
    self.genreTableView.dataSource = self;
    
    // お店受け取りBlocks
    didGetchShopListOfGenreBlock didGetchShopListOfGenreBlock = ^(NSMutableArray *shopList){
        self.genreList = shopList;
    };
    
    [fetcher genreRequest:didGetchShopListOfGenreBlock];
    
    UINib *shopGenreNib = [UINib nibWithNibName:shopGenreCell bundle:nil];
    [self.genreTableView registerNib:shopGenreNib forCellReuseIdentifier:shopGenreCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    //セクションに含まれるセルの数を返す
    return self.genreList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopGenreTableViewCell *genreCell = [self.genreTableView dequeueReusableCellWithIdentifier:shopGenreCell];
    
    // ラベルに都道府県セット処理
    ShopGenreEntity *shopGenreEnthity = self.genreList[indexPath.row];
    genreCell.genreNameLabel.text = shopGenreEnthity.name;
    
    return genreCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

// セルがタップされたときの処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 押したセルのラベルを取得
    ShopGenreEntity *shopGenreEntity = [ShopGenreEntity new];
    shopGenreEntity = self.genreList[indexPath.row];
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:mainStoryboard bundle:nil];
    ShopListViewController *shopView = [storyboard instantiateViewControllerWithIdentifier:@"Shop"];
    shopView.genreCode = shopGenreEntity.code;
    [self.navigationController pushViewController:shopView animated:YES];
    
}

@end
