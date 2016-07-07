//
//  ConfigViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/01.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ConfigViewController.h"
#import "ConfirmViewController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)deleteAction:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"UIAlertControllerStyle.Alert" message:@"iOS8" preferredStyle:UIAlertControllerStyleAlert];
    
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
    
   
    /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConfirmViewController *confirmViewController = [storyboard instantiateViewControllerWithIdentifier:@"Confirm"];
    
    
    // 画面をPUSHで遷移させる
    //[self.navigationController pushViewController:confirmViewController animated:YES];
    
    
    confirmViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:confirmViewController animated:NO completion:nil];
    */
}

- (IBAction)versionAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConfirmViewController *confirmViewController = [storyboard instantiateViewControllerWithIdentifier:@"Version"];
    [self.navigationController pushViewController:confirmViewController animated:YES];
}

- (void)cancelButtonPushed {}
- (void)otherButtonPushed {}
@end
