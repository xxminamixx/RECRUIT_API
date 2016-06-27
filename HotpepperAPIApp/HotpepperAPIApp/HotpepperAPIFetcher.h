//
//  HotpepperAPIFetcher.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol serviceAreaDelegate <NSObject>
- (void)getServiceArea:(NSMutableArray *)servicearea; // コントローラーに配列を渡す
@end

@protocol shopDelegate <NSObject>
- (void)getShop:(NSMutableArray *)shop;
@end

@interface HotpepperAPIFetcher : NSObject <NSXMLParserDelegate>
- (void)serviceAreaRequest;
- (void)shopRequest:(NSString *)areacode;
@property (weak, nonatomic) id<serviceAreaDelegate> areadelegate;
@property (weak, nonatomic) id<shopDelegate> shopdelegate;
@property NSMutableArray *servicearea;
@property NSMutableArray *shop;

@end
