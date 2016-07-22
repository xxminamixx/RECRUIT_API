//
//  ShopTableViewCell.h
//  HotpepperAPIApp
//
//  Created by 南　京兵 on 2016/06/26.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>

@protocol shopCellFavoriteDelegate <NSObject>

- (void) favoriteDidPush:(ShopEntity *)shopEntity;

@end

@protocol couponDelegate <NSObject>

- (void) couponDidPush:(NSString *)couponStr;

@end

@interface ShopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *couponHeight;
@property (weak, nonatomic) IBOutlet UIButton *couponButton;

@property (weak, nonatomic) id<shopCellFavoriteDelegate> favoriteDelegate;
@property (weak, nonatomic) id<couponDelegate> couponDeleate;

@property (weak, nonatomic) NSString *logo;
@property (weak, nonatomic) NSString *largeLogo;
@property (weak, nonatomic) NSString *address;
@property (weak, nonatomic) NSString *genre;
@property (weak, nonatomic) NSString *open;
@property (weak, nonatomic) NSString *coupon;

//headファイルではなく実装ファイルへ
@property UIImage *loadImage;

// favoriteButtonTappedなど
- (IBAction)favoriteAction:(id)sender;
- (IBAction)couponAction:(id)sender;

- (void)setMyPropertyWithEntity:(ShopEntity *)shopEntity;
- (void)setShopLogoWithURL:(NSString*)url;
- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock;
- (void)imageRefresh:(NSURL *)url;
- (NSInteger)couponHeightChanger;

@end

