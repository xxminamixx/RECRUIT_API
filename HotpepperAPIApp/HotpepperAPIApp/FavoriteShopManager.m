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

NSString * const kFavoriteEntity = @"FavoriteShopEntity";

@implementation FavoriteShopManager

- (instancetype)init
{
    self = [super init];
    if (self) {
    
    }
    return self;
}

- (BOOL)isAlreadyFavorite:(ShopEntity *)shopEntity
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
    
    // フェッチした配列に同じものがあるか確認
    for (int i = 0; i < mutableFetchResults.count; i++) {
        ShopEntity *favoriteShopEntity = mutableFetchResults[i];
        if ([favoriteShopEntity.name isEqualToString:shopEntity.name]) {

            NSManagedObject *eventToDelete = [mutableFetchResults objectAtIndex:i];
            [self.managedObjectContext deleteObject:eventToDelete];
            
            // 配列とTable Viewを更新する。
            [mutableFetchResults removeObjectAtIndex:i];
            
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
    [self saveEntity: _shopEntity];
     
}

- (void)preparetionEnitty
{
    /*
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
    
    self.managedObjectContext =　[[NSManagedObjectContext alloc] init];
    [self.managedObjectContext setPersistentStoreCoordinator: pStoreCondinator];
    self.entityDescModel = [NSEntityDescription entityForName:favoriteEntity inManagedObjectContext:self.managedObjectContext];
     */
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
    [favoriteEntity setName:_shopEntity.name];
    [favoriteEntity setLogo:_shopEntity.logo];
    [favoriteEntity setDetail:_shopEntity.detail];
    [favoriteEntity setAddress:_shopEntity.address];
    [favoriteEntity setOpen:_shopEntity.open];
    [favoriteEntity setGenre:_shopEntity.genre];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // エラーを処理する。
    }
    
}

// デリゲートメソッドに配列を引き渡す
- (void)setFavorite
{
    [self preparetionEnitty];
    
    //fetch設定を生成
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kFavoriteEntity];
    
    //sort条件を設定
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    //fetch設定を元に、managedObjectContextからデータを取得
    NSArray *favoriteList = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for (NSManagedObject *data in favoriteList) {
        NSLog(@"%@", data);
    }
    
    [self.favoriteDelegate getFavorite: favoriteList];
    
}




@end
