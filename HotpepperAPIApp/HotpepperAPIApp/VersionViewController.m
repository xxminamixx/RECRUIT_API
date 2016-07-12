//
//  VersionViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/07.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "VersionViewController.h"

@interface VersionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *version;

@end

@implementation VersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.version.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.navigationItem.title = @"バージョン確認";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
