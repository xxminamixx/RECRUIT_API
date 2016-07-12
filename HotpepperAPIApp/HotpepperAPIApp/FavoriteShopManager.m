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
#import "FavoriteViewController.h"

NSString * const kFavoriteEntity = @"FavoriteShopEntity";

@implementation FavoriteShopManager

- (instancetype)init
{
    self = [super init];
    if (self) {
    
    }
    return self;
}

// 
- (BOOL)addedShopToFavorite:(NSString *)shopName
{
    NSMutableArray *mutableFetchResults = [self fetchEntityList];
    
    for (int i = 0; i < mutableFetchResults.count; i++) {
        ShopEntity *fetchShopEntity = mutableFetchResults[i];
        
        // フェッチしたEntityと表示しているセルのEntityの名前が同じならお気に入りボタンステータス変更
        if ([fetchShopEntity.name isEqualToString: shopName]) {
            return YES; //　一致
        }
    }
    return NO;
}

- (void)preparetionEnitty
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
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] init];
    [self.managedObjectContext setPersistentStoreCoordinator: pStoreCondinator];
    self.entityDescModel = [NSEntityDescription entityForName:kFavoriteEntity inManagedObjectContext:self.managedObjectContext];
    
}


- (NSMutableArray *)fetchEntityList
{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    //イベントのフェッチ
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FavoriteShopEntity"
                                              inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext
                                            executeFetchRequest:request error:&error] mutableCopy];
    return mutableFetchResults;

}


// お気に入り全削除メソッド
- (void)allDeleteFavorite
{
    NSMutableArray *mutableFetchResults = [self fetchEntityList];
    NSInteger fetchResultsLength = mutableFetchResults.count;
    for (int i = 0; i < fetchResultsLength; i++) {
        NSManagedObject *eventToDelete = [mutableFetchResults objectAtIndex:0];
        [self.managedObjectContext deleteObject:eventToDelete];
       
        [mutableFetchResults removeObjectAtIndex:0];
       
        // 変更をコミットする。
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            // エラーを処理する。
        }
    }
}

- (BOOL)isAlreadyFavorite:(ShopEntity *)shopEntity
{
    NSMutableArray *mutableFetchResult = [self fetchEntityList];
    NSInteger fetchResultsLength = mutableFetchResult.count;
    // フェッチした配列に同じものがあるか確認
    for (int i = 0; i < fetchResultsLength; i++) {
        ShopEntity *favoriteShopEntity = mutableFetchResult[i];
        if ([favoriteShopEntity.name isEqualToString:shopEntity.name]) {

            NSManagedObject *eventToDelete = [mutableFetchResult objectAtIndex:i];
            [self.managedObjectContext deleteObject:eventToDelete];
            
            [mutableFetchResult removeObjectAtIndex:i];
            
            // 変更をコミットする。
            NSError *error = nil;
            if (![self.managedObjectContext save:&error]) {
                // エラーを処理する。
            }
            return NO; // 同じ名前がある
        }
    }
    
    return YES; //同じ名前がない
}

- (void)getFavoriteShop:(ShopEntity *)shopEntity
{
    
    // コントローラーからお気に入りのお店Entity受け取り処理
    _shopEntity = shopEntity;
    
    //保存したプロパティを保存処理に引き渡す
    [self saveEntity: self.shopEntity];
     
}

- (void)saveEntity:(ShopEntity *)shopEntity
{
   [self preparetionEnitty];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    // Eventエンティティの新規インスタンスを作成して設定する
    FavoriteShopEntity *favoriteEntity = (FavoriteShopEntity *)[NSEntityDescription insertNewObjectForEntityForName:kFavoriteEntity
                                                                                inManagedObjectContext:self.managedObjectContext];
   
    // データベース格納処理
    [favoriteEntity setName: self.shopEntity.name];
    [favoriteEntity setLogo: self.shopEntity.logo];
    [favoriteEntity setDetail: self.shopEntity.detail];
    [favoriteEntity setAddress: self.shopEntity.address];
    [favoriteEntity setOpen: self.shopEntity.open];
    [favoriteEntity setGenre: self.shopEntity.genre];
    [favoriteEntity setCoupon: self.shopEntity.coupon];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // エラーを処理する。
    }
    
}

// デリゲートメソッドに配列を引き渡す
- (void)setFavorite:(getFavoriteShopList)shopList
{
    [self preparetionEnitty];
    
    //fetch設定を生成
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kFavoriteEntity];
    
    //sort条件を設定
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    //fetch設定を元に、managedObjectContextからデータを取得
    NSMutableArray *favoriteList = (NSMutableArray *)[self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    [self.favoriteDelegate getFavorite: favoriteList];
    
    shopList(favoriteList);
}




@end
