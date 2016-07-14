//
//  ShopGenreEntity.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/12.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopGenreEntity : NSObject
// サービスエリアエンティティと統一する
@property (nonatomic, strong) NSString *genreCode;
@property (nonatomic, strong) NSString *genreName;
@end
