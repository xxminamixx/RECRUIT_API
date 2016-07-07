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


@implementation ShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.sampleImage =[UIImage imageNamed:@"sample.png"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)favoriteAction:(id)sender {
    NSLog(@"お気に入りボタンがおされました");
    ShopEntity *shopEntity = [ShopEntity new];
    shopEntity.name = self.shopName.text;
    shopEntity.detail = self.detail.text;
    shopEntity.logo = self.logo;
    shopEntity.address = self.address;
    
    [self.favoriteDelegate favoriteCall:shopEntity];
}

- (void)setMyPropertyWithEntity:(ShopEntity *)shopEntity
{
    self.shopName.text = shopEntity.name;
    self.detail.text = shopEntity.detail;
    self.logo = shopEntity.logo;
    self.address = shopEntity.address;
    self.open = shopEntity.open;
    self.genre = shopEntity.genre;
}

- (void)setShopLogoWithURL:(NSString*)url {
    [self.shopLogo sd_setImageWithURL:[NSURL URLWithString:url]];
}

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock
{
    [self.shopLogo sd_setImageWithURL:url placeholderImage:self.sampleImage options:0 progress:nil completed:completedBlock];
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
