//
//  FavoriteShopManager.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/27.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "FavoriteShopManager.h"
#import "FavoriteShopEntity.h"
#import "AppDelegate.h"
#import "ShopEntity.h"

NSString * const favoriteEntity = @"FavoriteShopEntity";

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
    NSError *error = nil;
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource: @"Model" withExtension:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath: [modelPath path]];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL: modelURL];
    NSPersistentStoreCoordinator *pStoreCondinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: model];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *storeURL = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    storeURL = [storeURL URLByAppendingPathComponent:@"Model.sqlite"];
    NSPersistentStore *pStore = [pStoreCondinator addPersistentStoreWithType:NSSQLiteStoreType
                                                               configuration:nil
                                                                         URL:storeURL
                                                                     options:nil
                                                                       error:&error];
    
    if (pStore == nil) {
        NSLog(@"Error Description: %@", [error userInfo]);
    }
    
    self.managedObjectContext =[[NSManagedObjectContext alloc] init];
    [self.managedObjectContext setPersistentStoreCoordinator: pStoreCondinator];
    self.entityDescModel = [NSEntityDescription entityForName:favoriteEntity inManagedObjectContext:self.managedObjectContext];
    
    
    // Eventエンティティの新規インスタンスを作成して設定する
     FavoriteShopEntity *favoriteEntity = [[FavoriteShopEntity alloc] initWithEntity: self.entityDescModel
                                                      insertIntoManagedObjectContext:self.managedObjectContext];
   
    // データベース格納処理
    [favoriteEntity setName:_shopEntity.name];
    [favoriteEntity setLogo:_shopEntity.logo];
    [favoriteEntity setDetail:_shopEntity.detail];
    [favoriteEntity setAddress:_shopEntity.address];
    [favoriteEntity setOpen:_shopEntity.open];
    [favoriteEntity setGenre:_shopEntity.genre];
    
    // デバッグ用
    NSLog(@"%@", favoriteEntity.name);
    NSLog(@"%@", favoriteEntity.logo);
    NSLog(@"%@", favoriteEntity.detail);
    NSLog(@"%@", favoriteEntity.address);
    NSLog(@"%@", favoriteEntity.open);
    NSLog(@"%@", favoriteEntity.genre);
     

}

// デリゲートメソッドに配列を引き渡す
- (void)setFavorite:(NSManagedObjectContext *)favoriteObjectContext
{
    /*
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:favoriteEntity];
    NSError *error= nil;
    NSMutableArray *favoriteShop = [favoriteObjectContext executeRequest:request error:&error];
    [self.favoriteDelegate getFavoriteContext: favoriteShop];
     */
}




@end
