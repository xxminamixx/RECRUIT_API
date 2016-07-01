//
//  ShopTableViewCell.h
//  HotpepperAPIApp
//
//  Created by 南　京兵 on 2016/06/26.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol shopCellFavoriteDelegate <NSObject>

- (void) favoriteCall;

@end

@interface ShopTableViewCell : UITableViewCell
@property (weak, nonatomic) id<shopCellFavoriteDelegate> favoriteDelegate;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UITextView *shopDescription;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
- (IBAction)favoriteAction:(id)sender;

- (void)setShopLogoWithURL:(NSString*)url;

@end

