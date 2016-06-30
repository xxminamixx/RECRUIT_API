//
//  TabBarController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/30.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "TabBarController.h"
//#import "FavoriteViewController.h"

@interface TabBarController ()
//@property FavoriteViewController *favoriteViewController;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"タブバーが呼ばれました。");
    self.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController
{
    NSLog(@"タブバーが押されました。");
    if ([viewController conformsToProtocol:@protocol(tabBarControllerDelegate)]) {
        // 各UIViewControllerのデリゲートメソッドを呼ぶ
        [(UIViewController<tabBarControllerDelegate>*)viewController didSelect:self];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
