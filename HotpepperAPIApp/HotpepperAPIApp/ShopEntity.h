//
//  ShopEntity.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/24.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopEntity : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *largeLogo;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *genre;
@property (nonatomic, strong) NSString *open;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *coupon;
@property (nonatomic, strong) NSString *parking;

@end
