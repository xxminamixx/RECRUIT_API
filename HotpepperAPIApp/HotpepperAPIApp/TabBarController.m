//
//  TabBarController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/30.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "TabBarController.h"
#import "FavoriteViewController.h"
#import "ConfigViewController.h"
#import "HomeViewController.h"

NSString * const homeImageStr = @"home.png";
NSString * const homeImageFilledStr = @"homeFilled.png";
NSString * const favoImageStr = @"star.png";
NSString * const favoImageFilledStr = @"starFilled.png";
NSString * const configImageStr = @"config.png";
NSString * const configImageFilledStr = @"configFilled.png";
NSString * const listImageStr = @"List.png";
NSString * const listFailledImageStr = @"ListFilled.png";


@interface TabBarController ()
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"タブバーが呼ばれました。");
    self.delegate = self;
    
    UITabBarItem *homeItem = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *favoItem = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *configItem = [self.tabBar.items objectAtIndex:2];
    
    homeItem.title = @"home";
    favoItem.title = @"favorite";
    configItem.title = @"config";
    
    homeItem.image = [[UIImage imageNamed:homeImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeItem.selectedImage = [[UIImage imageNamed:homeImageFilledStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    favoItem.image = [[UIImage imageNamed:favoImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    favoItem.selectedImage = [[UIImage imageNamed:favoImageFilledStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    configItem.image = [[UIImage imageNamed:configImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    configItem.selectedImage = [[UIImage imageNamed:configImageFilledStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController
{
    NSLog(@"タブバーが押されました。");
}


@end
