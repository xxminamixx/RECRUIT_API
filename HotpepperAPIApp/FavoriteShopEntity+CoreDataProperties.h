//
//  FavoriteShopEntity+CoreDataProperties.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/28.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FavoriteShopEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteShopEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *detail;
@property (nullable, nonatomic, retain) NSString *genre;
@property (nullable, nonatomic, retain) NSString *logo;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *open;

@end

NS_ASSUME_NONNULL_END