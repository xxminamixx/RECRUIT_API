//
//  ShopGenreViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/12.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ShopGenreViewController.h"
#import "KissXMLHotpepperAPIFetcher.h"
#import "ServiceAreaTableViewCell.h"
#import "ShopGenreEntity.h"
#import "ShopGenreTableViewCell.h"

NSString * const shopGenreCell = @"ShopGenreTableViewCell";

@interface ShopGenreViewController()<UITableViewDelegate,UITableViewDataSource,shopGenreDelegate>
@property (weak, nonatomic) IBOutlet UITableView *genreTableView;
@property NSMutableArray *genreList;
@end

@implementation ShopGenreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ジャンル一覧";
    KissXMLHotpepperAPIFetcher *fetcher = [KissXMLHotpepperAPIFetcher new];
    fetcher.genreDelegate = self;
    self.genreTableView.delegate = self;
    self.genreTableView.dataSource = self;
    [fetcher genreRequest];
    
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
    genreCell.genreNameLabel.text = shopGenreEnthity.genreName;
    
    return genreCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)getGenre:(NSMutableArray *)genreList;
{
    // 自身のプロパティにフェッチしたジャンルEntity配列を格納
    self.genreList = genreList;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.genreTableView reloadData];
    });
}

@end
