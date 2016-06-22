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

@interface ServiceAreaViewController ()
@property (weak, nonatomic) IBOutlet UITableView *serviceAreaTableView;

@end

@implementation ServiceAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _serviceAreaTableView.delegate = self;
    _serviceAreaTableView.dataSource = self;

    //ViewControllerのViewにTableViewCellを登録
    UINib *serviceAreaNib = [UINib nibWithNibName:@"ServiceAreaTableViewCell" bundle:nil];
    [self.serviceAreaTableView registerNib:serviceAreaNib forCellReuseIdentifier:@"ServiceArea"];

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
    //セルの内容を返す
    ServiceAreaTableViewCell *areaCell = [ServiceAreaTableViewCell new];
    areaCell = [_serviceAreaTableView dequeueReusableCellWithIdentifier:@"ServiceArea"];
    //NSArray *areaname = [ServiceAreaEntity getAreaName];
    //areaCell.textLabel.text = areaname[0];
    
    return areaCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 125;
}

//セルがタップされたときの処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //一覧画面へ遷移する処理
    //一覧を表示するためにフェッチャーでリクエスト
    NSLog(@"%@", indexPath);
}


@end
