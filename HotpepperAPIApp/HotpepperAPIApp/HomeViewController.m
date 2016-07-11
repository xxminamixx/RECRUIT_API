//
//  ViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "HomeViewController.h"
#import "ServiceAreaViewController.h"
#import "TabBarController.h"
#import "KissXMLHotpepperAPIFetcher.h"
#import "ShopListViewController.h"

@interface ViewController ()


- (IBAction)searchAdmitButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
- (IBAction)serviceAreaSearchButton:(id)sender;
- (IBAction)genreSearchButton:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ホーム";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)serviceAreaSearchButton:(id)sender {
    // ストーリーボードを指定する
    //ここで送るメッセージはstoryboard名前の“Main.storyboard”
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 遷移先のViewControllerをStoryBoardをもとに作成
    //ここで送るメッセージはsroryboard ID
    ServiceAreaViewController *areaView = [storyboard instantiateViewControllerWithIdentifier:@"ServiceArea"];
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:areaView animated:YES];
}

- (IBAction)genreSearchButton:(id)sender {
    
}




- (IBAction)searchAdmitButton:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShopListViewController *shopView = [storyboard instantiateViewControllerWithIdentifier:@"Shop"];
    
    //次画面へ選択したエリアコードを渡す
    shopView.searchShopName = self.searchField.text;
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:shopView animated:YES];

}
@end
