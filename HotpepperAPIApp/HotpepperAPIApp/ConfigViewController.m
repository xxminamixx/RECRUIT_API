//
//  ConfigViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/01.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ConfigViewController.h"
#import "ConfirmViewController.h"
#import "FavoriteShopManager.h"

@interface ConfigViewController ()
- (IBAction)deleteAction:(id)sender;
- (IBAction)versionAction:(id)sender;
@end

@implementation ConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"設定";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Version Confirmation
- (IBAction)versionAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConfirmViewController *confirmViewController = [storyboard instantiateViewControllerWithIdentifier:@"Version"];
    [self.navigationController pushViewController:confirmViewController animated:YES];
}

# pragma mark - Favorite Delete
- (IBAction)deleteAction:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"お気に入りを削除" message:@"本当にお気に入りを全て削除しますか？" preferredStyle:UIAlertControllerStyleAlert];
    
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"いいえ" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
        [self cancelButtonPushed];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)cancelButtonPushed
{
    // キャンセル処理
}

- (void)otherButtonPushed
{
    //　削除確定処理
    FavoriteShopManager *favoriteShopManager = [FavoriteShopManager new];
    [favoriteShopManager allDeleteFavorite];

}
@end
