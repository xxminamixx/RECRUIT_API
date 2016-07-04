//
//  ConfirmViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/01.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ConfirmViewController.h"
#import "FavoriteShopManager.h"
#import "FavoriteViewController.h"

@interface ConfirmViewController ()
- (IBAction)cancelAction:(id)sender;
- (IBAction)deleteComitAction:(id)sender;
@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
-(void)showConfirmView{
    ConfirmViewController *confirmViewController = [ConfirmViewController new];
    [self presentViewController:confirmViewController animated:YES completion:nil];
}
 */

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)deleteComitAction:(id)sender {
    FavoriteShopManager *favoriteShopManager = [FavoriteShopManager new];
    [favoriteShopManager allDeleteFavorite];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 遷移先のViewControllerをStoryBoardをもとに作成
    //ここで送るメッセージはsroryboard ID
    FavoriteViewController *favoritelView = [storyboard instantiateViewControllerWithIdentifier:@"FavoriteShop"];
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:favoritelView animated:YES];
    */

}
@end
