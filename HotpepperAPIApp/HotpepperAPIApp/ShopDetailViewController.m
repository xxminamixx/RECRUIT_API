//
//  ShopDetailViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/27.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "FavoriteShopManager.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShopDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shopname;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UITextView *detail;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *open;
@property (weak, nonatomic) IBOutlet UILabel *genre;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property UIImage* loadImage;
- (IBAction)favoriteAction:(id)sender;
@end

@implementation ShopDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _shopEntity.name;
    self.loadImage = [UIImage imageNamed:@"loadImage.png"];
    
    _shopname.text = _shopEntity.name;
    _detail.text = _shopEntity.detail;
    _address.text = _shopEntity.address;
    _open.text = _shopEntity.open;
    _genre.text = _shopEntity.genre;
    
    FavoriteShopManager *favoriteShopManager = [FavoriteShopManager new];
    self.favoriteButton.alpha = 0.2;
    
    if ([favoriteShopManager addedShopToFavorite:_shopEntity.name]) {
        self.favoriteButton.alpha = 1;
    }
    
    NSURL *url = [NSURL URLWithString:self.shopEntity.largeLogo];

    [self sd_setImageWithURL:url
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           [self.detailView setNeedsLayout];
                           [self.detailView layoutIfNeeded];
                       }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)favoriteAction:(id)sender
{
    // マネージャーに投げて既にお気に入りに登録されているかチェックする
    FavoriteShopManager *favoriteManager = [FavoriteShopManager new];
    if ([favoriteManager isAlreadyFavorite:self.shopEntity]) {
        // お気に入り登録処理
        // 詳細表示しているお店のEntityをManagerに渡す
        [favoriteManager getFavoriteShop:self.shopEntity];
       
        //お気に入りボタン透明度変更処理
        self.favoriteButton.alpha = 1;
    } else {
        //お気に入りボタン透明度変更処理
        self.favoriteButton.alpha = 0.2;
    }
}
 
- (void)setShopLogo:(NSString*)url
{
    [self.logo sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:self.loadImage];
    [self.detailView setNeedsDisplay];
}

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock
{
    [self.logo sd_setImageWithURL:url placeholderImage:self.loadImage options:0 progress:nil completed:completedBlock];
}


@end
