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
#import "ShopGenreViewController.h"

NSString * const mainStoryboard = @"Main";
NSString * const serviceAreaIDOfStoryboard = @"ServiceArea";
NSString * const genreIDOfStoryboard = @"ShopGenre";
NSString * const shopListIDOfStoryboard  = @"Shop";

@interface ViewController ()<UITextFieldDelegate>

- (IBAction)searchAdmitButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
- (IBAction)serviceAreaSearchButton:(id)sender;
- (IBAction)genreSearchButton:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ホーム";
    UIColor *navitationBarColor = [UIColor colorWithRed:60/255.0 green:179/255.0 blue:113/255.0 alpha:1.0];
    self.navigationController.navigationBar.barTintColor = navitationBarColor;
    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.searchField setDelegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)serviceAreaSearchButton:(id)sender {
    // ストーリーボードを指定する
    //ここで送るメッセージはstoryboard名前の“Main.storyboard”
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:mainStoryboard bundle:nil];
    
    // 遷移先のViewControllerをStoryBoardをもとに作成
    //ここで送るメッセージはsroryboard ID
    ServiceAreaViewController *areaView = [storyboard instantiateViewControllerWithIdentifier:serviceAreaIDOfStoryboard];
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:areaView animated:YES];
}

- (IBAction)genreSearchButton:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:mainStoryboard bundle:nil];
    ShopGenreViewController *genreView = [storyboard instantiateViewControllerWithIdentifier:genreIDOfStoryboard];
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:genreView animated:YES];

}

- (IBAction)searchAdmitButton:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:mainStoryboard bundle:nil];
    ShopListViewController *shopView = [storyboard instantiateViewControllerWithIdentifier:shopListIDOfStoryboard];
    
    //次画面へ選択したエリアコードを渡す
    shopView.searchShopName = self.searchField.text;
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:shopView animated:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
