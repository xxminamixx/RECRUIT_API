//
//  ConfigViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/01.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ConfigViewController.h"
#import "FavoriteShopManager.h"
#import "SearchNumberViewController.h"
#import "VersionViewController.h"

@interface ConfigViewController ()
@property SearchNumberViewController *searchNumberViewController;
@property (strong, nonatomic) IBOutlet UIView *configView;
@property ConfigViewController *configViewController;
- (IBAction)searchNumberAction:(id)sender;
- (IBAction)deleteAction:(id)sender;
- (IBAction)versionAction:(id)sender;
@end

@implementation ConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"設定";
    UIColor *navitationBarColor = [UIColor colorWithRed:60/255.0 green:179/255.0 blue:113/255.0 alpha:1.0];
    self.navigationController.navigationBar.barTintColor = navitationBarColor;
    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.searchNumberViewController = [SearchNumberViewController new];
    [self addChildViewController:self.searchNumberViewController];
    [self.searchNumberViewController didMoveToParentViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Version Confirmation
- (IBAction)versionAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VersionViewController *versionViewController = [storyboard instantiateViewControllerWithIdentifier:@"Version"];
    [self.navigationController pushViewController:versionViewController animated:YES];
}


#pragma mark - Serch Number Changer
- (IBAction)searchNumberAction:(id)sender
{
    NSLog(@"一覧画面表示件数を変更します");
    /*
    self.searchNumberViewController.pickerView.frame = CGRectMake(0, 0, 100, 100);
    [self.configViewController.configView addSubview:self.searchNumberViewController.pickerView];
     */
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 遷移先のViewControllerをStoryBoardをもとに作成
    //ここで送るメッセージはsroryboard ID
     SearchNumberViewController *searchNumberViewController = [storyboard instantiateViewControllerWithIdentifier:@"SearchNumber"];
    
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:searchNumberViewController animated:YES];
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
