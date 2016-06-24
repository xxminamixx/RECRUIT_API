//
//  ServiceAreaViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ServiceAreaViewController.h"
#import "ServiceAreaTableViewCell.h"
#import "ServiceAreaEntity.h"
#import "HotpepperAPIFetcher.h"

NSString * const servicearea_tableviewcell = @"ServiceAreaTableViewCell";
NSMutableArray *receive_servicearea;
//HotpepperAPIFetcher *areafetcher;

@interface ServiceAreaViewController () <serviceAreaDelegate>
@property (weak, nonatomic) IBOutlet UITableView *serviceAreaTableView;
@end

@implementation ServiceAreaViewController

void dispatch_sync(dispatch_queue_t queue, dispatch_block_t block)
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 都道府県リクエストを送る
    // フェッチャクラスのメソッドが呼ばれる前にcellの処理が終わってしまう
    HotpepperAPIFetcher *areafetcher = [HotpepperAPIFetcher new];
    
    // HotpepperAPIに自身のポインタをセット
    areafetcher.delegate = self;
    [areafetcher serviceAreaRequest];
    
    // フェッチャーから都道府県配列を受け取る
    // receive_servicearea = [areafetcher servicearea];
    
    _serviceAreaTableView.delegate = self;
    _serviceAreaTableView.dataSource = self;

    //ViewControllerのViewにTableViewCellを登録
    UINib *serviceAreaNib = [UINib nibWithNibName:servicearea_tableviewcell bundle:nil];
    [self.serviceAreaTableView registerNib:serviceAreaNib forCellReuseIdentifier:servicearea_tableviewcell];
    
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [self.serviceAreaTableView reloadData];
    [super viewWillAppear:animated];
}
*/

/*
-(void)viewDidAppear:(BOOL)animated
{
    [self.serviceAreaTableView reloadData];
    [super viewDidAppear:animated];
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    //セクションに含まれるセルの数を返す
    
    return receive_servicearea.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // セルの内容を返す
    //ServiceAreaTableViewCell *areacell = [tableView dequeueReusableCellWithIdentifier:servicearea_tableviewcell forIndexPath:indexPath];
    //修正
     ServiceAreaTableViewCell *areacell = [_serviceAreaTableView dequeueReusableCellWithIdentifier:servicearea_tableviewcell];
    
    // ラベルに都道府県セット処理
    ServiceAreaEntity *areaenthity = [ServiceAreaEntity new];
    
    // 配列をEntityに戻す
    areaenthity = receive_servicearea[indexPath.row];
    //areacell.textLabel.text = areaenthity.name;
    //修正　outletされたラベルにセットしていなかった。
    areacell.areaname_label.text = areaenthity.name;
    
    return areacell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

// セルがタップされたときの処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //一覧画面へ遷移する処理
    //一覧を表示するためにフェッチャーでリクエスト
    HotpepperAPIFetcher *shopfetcher;
    NSLog(@"%@", indexPath);
}

// デリゲードメソッド
- (void) getServiceArea:(NSMutableArray *)servicearea
{
    NSLog(@"デリゲードメソッドが呼ばれました");
    receive_servicearea = servicearea;
    
    [_serviceAreaTableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.serviceAreaTableView reloadData];
    });

}

@end
