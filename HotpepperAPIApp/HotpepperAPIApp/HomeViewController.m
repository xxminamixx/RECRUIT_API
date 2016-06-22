//
//  ViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "HomeViewController.h"
#import "ServiceAreaViewController.h"
#import "HotpepperAPIFetcher.h"


@interface ViewController ()
- (IBAction)serviceAreaSearchButton:(id)sender;
- (IBAction)genreSearchButton:(id)sender;
@property HotpepperAPIFetcher *areafetcher;
@end

@implementation ViewController

/*
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"このメソッドは画面遷移前に呼ばれます");
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)serviceAreaSearchButton:(id)sender {
    
    HotpepperAPIFetcher *areafetcher = [HotpepperAPIFetcher new];
    [areafetcher serviceAreaRequest];

    
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

@end
