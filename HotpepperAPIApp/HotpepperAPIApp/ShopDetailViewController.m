//
//  ShopDetailViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/27.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "FavoriteShopManager.h"

@interface ShopDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shopname;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UITextView *detail;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *open;
@property (weak, nonatomic) IBOutlet UILabel *genre;
- (IBAction)favoriteAction:(id)sender;
@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shopname.text = _shopEntity.name;
    _detail.text = _shopEntity.detail;
    _address.text = _shopEntity.address;
    [_address setNumberOfLines:0];
    _address.frame = CGRectMake(0, 0, 200, 0);
    [_address sizeToFit];
    _open.text = _shopEntity.open;
    _genre.text = _shopEntity.genre;
    
    
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

- (IBAction)favoriteAction:(id)sender {
    FavoriteShopManager *favoriteManager = [FavoriteShopManager new];
    favoriteManager.shopEntity = _shopEntity;
    
}
@end
