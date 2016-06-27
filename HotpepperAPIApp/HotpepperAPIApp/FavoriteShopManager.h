//
//  FavoriteShopManager.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/27.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopEntity.h"

@interface FavoriteShopManager : NSObject

@property ShopEntity *shopEntity;
@property (nonatomic, strong) NSEntityDescription *entityDescFavoShop;
@property (nonatomic, strong) NSManagedObjectContext *moContest;

@end
