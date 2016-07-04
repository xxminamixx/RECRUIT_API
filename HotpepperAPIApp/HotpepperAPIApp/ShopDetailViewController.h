//
//  ShopDetailViewController.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/27.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShopDetailViewController : UIViewController
@property ShopEntity *shopEntity;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock;
- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock;
@end
