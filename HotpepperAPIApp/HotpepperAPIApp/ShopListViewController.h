//
//  ShopListViewController.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/24.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>

// Blocksの定義をフェッチャーに記述
// complete handler is shop list


@interface ShopListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property NSString *areacode;
@property NSString *genreCode;
@property NSString *searchShopName;
@end
