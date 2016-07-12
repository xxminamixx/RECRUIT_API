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
#import "ShopListViewController.h"
#import "KissXMLHotpepperAPIFetcher.h"

NSString * const servicearea_tableviewcell = @"ServiceAreaTableViewCell";
NSMutableArray *receive_servicearea;

@interface ServiceAreaViewController ()
@property (weak, nonatomic) IBOutlet UITableView *serviceAreaTableView;
@end

@implementation ServiceAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"サービスエリア検索";
    
    // HotpepperAPIに自身のポインタをセット
    KissXMLHotpepperAPIFetcher *serviceAreaFetcher = [KissXMLHotpepperAPIFetcher new];
    
    // 自身の配列に格納するBlocks
    getServiceArea getServiceArea = ^(NSMutableArray *array){
        receive_servicearea = array;
    };
    
    [serviceAreaFetcher serviceAreaRequest:getServiceArea];
    
    self.serviceAreaTableView.delegate = self;
    self.serviceAreaTableView.dataSource = self;

    //ViewControllerのViewにTableViewCellを登録
    UINib *serviceAreaNib = [UINib nibWithNibName:servicearea_tableviewcell bundle:nil];
    [self.serviceAreaTableView registerNib:serviceAreaNib forCellReuseIdentifier:servicearea_tableviewcell];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    //セクションに含まれるセルの数を返す
    return receive_servicearea.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceAreaTableViewCell *areacell = [_serviceAreaTableView dequeueReusableCellWithIdentifier:servicearea_tableviewcell];
    
    // ラベルに都道府県セット処理
    ServiceAreaEntity *areaEnthity = receive_servicearea[indexPath.row];
    areacell.areaname_label.text = areaEnthity.name;
    
    return areacell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

// セルがタップされたときの処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 押したセルのラベルを取得
    ServiceAreaEntity *areaEntity = [ServiceAreaEntity new];
    areaEntity = receive_servicearea[indexPath.row];
    NSLog(@"%@", areaEntity.code);
    
    // ストーリーボードを指定する
    //ここで送るメッセージはstoryboard名前の“Main.storyboard”
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 遷移先のViewControllerをStoryBoardをもとに作成
    //ここで送るメッセージはsroryboard ID
    ShopListViewController *shopView = [storyboard instantiateViewControllerWithIdentifier:@"Shop"];
    
    //次画面へ選択したエリアコードを渡す
    shopView.areacode = areaEntity.code;
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:shopView animated:YES];
}

/*
// デリゲードメソッド
- (void) getServiceArea:(NSMutableArray *)servicearea
{
    NSLog(@"デリゲードメソッドが呼ばれました");
    receive_servicearea = servicearea;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.serviceAreaTableView reloadData];
    });

}
 */

@end
