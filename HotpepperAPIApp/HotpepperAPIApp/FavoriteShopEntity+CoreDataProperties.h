//
//  FavoriteShopEntity+CoreDataProperties.h
//  
//
//  Created by Minami Kyohei on 2016/07/11.
//
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
@property (nullable, nonatomic, retain) NSString *largeLogo;
@property (nullable, nonatomic, retain) NSString *logo;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *open;
@property (nullable, nonatomic, retain) NSString *shopId;
@property (nullable, nonatomic, retain) NSString *coupon;
@property (nullable, nonatomic, retain) NSString *parking;

@end

NS_ASSUME_NONNULL_END
