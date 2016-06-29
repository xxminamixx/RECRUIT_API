//
//  FavoriteShopManager.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/27.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopEntity.h"
#import <CoreData/CoreData.h>

@interface FavoriteShopManager : NSObject

@property ShopEntity *shopEntity;

- (void)getFavoriteShop:(ShopEntity *)shopEntity; // お気に入りのEntityを受け取るメソッド

@property (nonatomic, strong) NSEntityDescription *entityDescModel;
@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSMutableDictionary *currentRecord;
@property (nonatomic, strong) NSMutableString *currentString;

@end
