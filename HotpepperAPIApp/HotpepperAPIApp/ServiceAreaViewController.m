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
NSMutableArray *servicearea;
int count = 0;

@interface ServiceAreaViewController ()
@property (weak, nonatomic) IBOutlet UITableView *serviceAreaTableView;

@end

@implementation ServiceAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 都道府県リクエストを送る
    // フェッチャクラスのメソッドが呼ばれる前にcellの処理が終わってしまう
    HotpepperAPIFetcher *areafetcher = [HotpepperAPIFetcher new];
    [areafetcher serviceAreaRequest];
    
    // フェッチャーから都道府県配列を受け取る
    servicearea = [areafetcher servicearea];
    
    _serviceAreaTableView.delegate = self;
    _serviceAreaTableView.dataSource = self;

    //ViewControllerのViewにTableViewCellを登録
    UINib *serviceAreaNib = [UINib nibWithNibName:servicearea_tableviewcell bundle:nil];
    [self.serviceAreaTableView registerNib:serviceAreaNib forCellReuseIdentifier:servicearea_tableviewcell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    //セクションに含まれるセルの数を返す
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    // セルの内容を返す
    ServiceAreaTableViewCell *areacell = [tableView dequeueReusableCellWithIdentifier:servicearea_tableviewcell forIndexPath:indexPath];
    areacell = [_serviceAreaTableView dequeueReusableCellWithIdentifier:servicearea_tableviewcell];
    
    //ラベルに都道府県セット処理
    ServiceAreaEntity *servicearea_entity = [ServiceAreaEntity new];
    servicearea_entity = servicearea[count];
    areacell.textLabel.text = servicearea_entity.name;
    count++;
    
    return areacell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 125;
}

// セルがタップされたときの処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //一覧画面へ遷移する処理
    //一覧を表示するためにフェッチャーでリクエスト
    NSLog(@"%@", indexPath);
}


@end
