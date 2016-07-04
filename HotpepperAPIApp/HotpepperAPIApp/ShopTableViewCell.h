//
//  ShopTableViewCell.h
//  HotpepperAPIApp
//
//  Created by 南　京兵 on 2016/06/26.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopEntity.h"

@protocol shopCellFavoriteDelegate <NSObject>

- (void) favoriteCall:(ShopEntity *)shopEntity;

@end

@interface ShopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) id<shopCellFavoriteDelegate> favoriteDelegate;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) NSString *logo;
@property (weak, nonatomic) NSString *address;
@property (weak, nonatomic) NSString *genre;
@property (weak, nonatomic) NSString *open;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
- (IBAction)favoriteAction:(id)sender;
- (void)setMyPropertyWithEntity:(ShopEntity *)shopEntity;
- (void)setShopLogoWithURL:(NSString*)url;

@end

