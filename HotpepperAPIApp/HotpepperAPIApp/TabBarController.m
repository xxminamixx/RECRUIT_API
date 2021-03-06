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

NSString * const kHomeImageStr = @"home.png";
NSString * const kHomeImageFilledStr = @"homeFilled.png";
NSString * const kFavoImageStr = @"star.png";
NSString * const kFavoImageFilledStr = @"starFilled.png";
NSString * const kConfigImageStr = @"config.png";
NSString * const kConfigImageFilledStr = @"configFilled.png";
NSString * const kListImageStr = @"List.png";
NSString * const kListFailledImageStr = @"ListFilled.png";


@interface TabBarController ()
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"タブバーが呼ばれました。");
    self.delegate = self;
    
    UIColor *tabBarColor = [UIColor colorWithRed:60/255.0 green:179/255.0 blue:113/255.0 alpha:1.0];
    [[UITabBar appearance] setBarTintColor: tabBarColor];
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f];
    NSDictionary *selectedAttributes = @{NSFontAttributeName : font,
                                         NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [[UITabBarItem appearance] setTitleTextAttributes:selectedAttributes
                                             forState:UIControlStateSelected];
    
    UITabBarItem *homeItem = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *favoItem = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *configItem = [self.tabBar.items objectAtIndex:2];
    
    homeItem.title = @"home";
    favoItem.title = @"favorite";
    configItem.title = @"config";
    
    homeItem.image = [[UIImage imageNamed:kHomeImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeItem.selectedImage = [[UIImage imageNamed:kHomeImageFilledStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    favoItem.image = [[UIImage imageNamed:kFavoImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    favoItem.selectedImage = [[UIImage imageNamed:kFavoImageFilledStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    configItem.image = [[UIImage imageNamed:kConfigImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    configItem.selectedImage = [[UIImage imageNamed:kConfigImageFilledStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController
{
    NSLog(@"タブバーが押されました。");
}

@end
