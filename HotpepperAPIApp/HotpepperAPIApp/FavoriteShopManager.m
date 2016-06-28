//
//  FavoriteShopManager.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/27.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "FavoriteShopManager.h"
#import "Entity.h"
#import "AppDelegate.h"

@implementation FavoriteShopManager

- (instancetype)init
{
    self = [super init];
    if (self) {
    
    }
    return self;
}

- (void)getFavoriteShop:(ShopEntity *)shopEntity
{
    // コントローラーからお気に入りのお店Entity受け取り処理
    _shopEntity = shopEntity;
    
    //保存したプロパティを保存処理に引き渡す
    [self saveEntity: _shopEntity];
}

- (void)saveEntity:(ShopEntity *)shopEntity
{
    //　データベース格納処理
    // Eventエンティティの新規インスタンスを作成して設定する
     Entity *favoriteEntity = (Entity *)[NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:_managedObjectContext];
    
    // データベース格納処理
    [favoriteEntity setName:_shopEntity.name];
    [favoriteEntity setLogo:_shopEntity.logo];
    [favoriteEntity setDetail:_shopEntity.detail];
    [favoriteEntity setAddress:_shopEntity.address];
    [favoriteEntity setOpen:_shopEntity.open];
    [favoriteEntity setGenre:_shopEntity.genre];
}


@end
