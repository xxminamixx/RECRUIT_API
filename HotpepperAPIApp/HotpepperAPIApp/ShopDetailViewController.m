//
//  ShopDetailViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/27.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ShopDetailViewController.h"

@interface ShopDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shopname;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UITextView *detail;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *open;
@property (weak, nonatomic) IBOutlet UILabel *genre;
@end

@implementation ShopDetailViewController

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

@end
