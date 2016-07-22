 //
//  ShopTableViewCell.m
//  HotpepperAPIApp
//
//  Created by 南　京兵 on 2016/06/26.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ShopTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"

NSString * const loadImage = @"loadImage.png";

@implementation ShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.loadImage =[UIImage imageNamed: loadImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)favoriteAction:(id)sender {
    NSLog(@"お気に入りボタンがおされました");
    ShopEntity *shopEntity = [ShopEntity new];
    shopEntity.name = self.shopName.text;
    shopEntity.detail = self.detail.text;
    shopEntity.logo = self.logo;
    shopEntity.address = self.address;
    shopEntity.coupon = self.coupon;
    shopEntity.open = self.open;
    shopEntity.genre = self.genre;
    shopEntity.largeLogo = self.largeLogo;
    
    [self.favoriteDelegate favoriteDidPush:shopEntity];
}

- (IBAction)couponAction:(id)sender {
    [self.couponDeleate couponDidPush: self.coupon];
}

- (void)setMyPropertyWithEntity:(ShopEntity *)shopEntity
{
    self.shopName.text = shopEntity.name;
    self.detail.text = shopEntity.detail;
    self.logo = shopEntity.logo;
    self.largeLogo = shopEntity.largeLogo;
    self.address = shopEntity.address;
    self.open = shopEntity.open;
    self.genre = shopEntity.genre;
    self.coupon = shopEntity.coupon;
}

- (NSInteger)couponHeightChanger
{
    // cuoponボタンの高さを変える
    if (self.coupon != nil) {
        self.couponButton.hidden = false;
        self.couponHeight.constant = 30;
        return 50;
    } else {
        self.couponButton.hidden = true;
        self.couponHeight.constant = 0;
        return 0;
    }
}

- (void)setShopLogoWithURL:(NSString*)url {
    [self.shopLogo sd_setImageWithURL:[NSURL URLWithString:url]];
}

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock
{
    [self.shopLogo sd_setImageWithURL:url placeholderImage:self.loadImage options:0 progress:nil completed:completedBlock];
}

- (void)imageRefresh:(NSURL *)url
{
    [self sd_setImageWithURL:url
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           [self setNeedsLayout];
                           [self layoutIfNeeded];
                       }];

}

@end
