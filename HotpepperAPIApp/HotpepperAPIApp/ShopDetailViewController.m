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
@property UIImage* sampleImage;
- (IBAction)favoriteAction:(id)sender;
@end

@implementation ShopDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _shopEntity.name;
    self.sampleImage = [UIImage imageNamed:@"sample.png"];
    /*
    void(^ImageReload)();
    [self sd_setImageWithURL: self.shopEntity.largeLogo: ImageReload];
    */
    _shopname.text = _shopEntity.name;
    _detail.text = _shopEntity.detail;
    _address.text = _shopEntity.address;
    _open.text = _shopEntity.open;
    _genre.text = _shopEntity.genre;
    
    FavoriteShopManager *favoriteShopManager = [FavoriteShopManager new];
    self.favoriteButton.alpha = 0.2;
    
    /*
    // お気に入り情報をフェッチ
    NSMutableArray *mutableFetchResults = [favoriteShopManager fetchEntityList];
    
    for (int i = 0; i < mutableFetchResults.count; i++) {
        ShopEntity *fetchShopEntity = mutableFetchResults[i];
        
        // フェッチしたEntityと表示しているセルのEntityの名前が同じならお気に入りボタンステータス変更
        if ([fetchShopEntity.name isEqualToString: self.shopEntity.name]) {
            self.favoriteButton.alpha = 1;
        }
    }
     */
    
    if ([favoriteShopManager addedShopToFavorite:_shopEntity.name]) {
        self.favoriteButton.alpha = 1;
    }
    
    NSURL *url = [NSURL URLWithString:self.shopEntity.largeLogo];
    //[self setShopLogo:self.shopEntity.largeLogo];

    
    [self sd_setImageWithURL:url
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           [self.detailView setNeedsLayout];
                           [self.detailView layoutIfNeeded];
                       }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.logo sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:self.sampleImage];
    [self.detailView setNeedsDisplay];
}

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock
{
    [self.logo sd_setImageWithURL:url placeholderImage:self.sampleImage options:0 progress:nil completed:completedBlock];
}


@end
