//
//  FavoriteViewController.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/29.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end
