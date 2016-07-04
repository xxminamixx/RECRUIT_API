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
    // ストーリーボードを指定する
    //ここで送るメッセージはstoryboard名前の“Main.storyboard”
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 遷移先のViewControllerをStoryBoardをもとに作成
    //ここで送るメッセージはsroryboard ID
    ConfirmViewController *confirmViewController = [storyboard instantiateViewControllerWithIdentifier:@"Confirm"];
    
    /*
    // 画面をPUSHで遷移させる
    [self.navigationController pushViewController:confirmViewController animated:YES];
    */
    
    
    confirmViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    // UINavigationControllerに向けてモーダルで画面遷移
    [self presentViewController:confirmViewController animated:NO completion:nil];
     
}
@end
