//
//  FavoriteShopManager.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/27.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ShopEntity.h"
#import "FavoriteShopEntity.h"

typedef void(^getFavoriteShopList)(NSMutableArray *array);

@protocol FavoriteDelegate <NSObject>

- (void)getFavorite:(NSMutableArray *)favoriteShop;

@end

@interface FavoriteShopManager : NSObject

@property ShopEntity *shopEntity;

- (void)getFavoriteShop:(ShopEntity *)shopEntity; // お気に入りのEntityを受け取るメソッド
- (void)allDeleteFavorite;
- (void)setFavorite:(getFavoriteShopList)shopList;
- (BOOL)isAlreadyFavorite:(ShopEntity *)shopEnitty;
- (NSMutableArray *)fetchEntityList;
- (BOOL)addedShopToFavorite:(NSString *)shopName;

@property (nonatomic, weak) id<FavoriteDelegate> favoriteDelegate;
@property (nonatomic, strong) NSEntityDescription *entityDescModel;
@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSMutableDictionary *currentRecord;
@property (nonatomic, strong) NSMutableString *currentString;

@end
