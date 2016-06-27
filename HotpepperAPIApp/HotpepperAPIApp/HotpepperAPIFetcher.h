//
//  HotpepperAPIFetcher.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol serviceAreaDelegate <NSObject>
<<<<<<< HEAD

- (void)getServiceArea:(NSMutableArray *)servicearea ; // コントローラーに配列を渡す

=======
- (void)getServiceArea:(NSMutableArray *)servicearea; // コントローラーに配列を渡す
@end

@protocol shopDelegate <NSObject>
- (void)getShop:(NSMutableArray *)shop;
>>>>>>> homework
@end

@interface HotpepperAPIFetcher : NSObject <NSXMLParserDelegate>
- (void)serviceAreaRequest;
<<<<<<< HEAD

@property (weak, nonatomic) id<serviceAreaDelegate> delegate;
@property NSMutableArray *servicearea;
@property BOOL is_large_servicearea;
@property BOOL is_servicearea_code;
@property BOOL is_servicearea_name;
=======
- (void)shopRequest:(NSString *)areacode;
@property (weak, nonatomic) id<serviceAreaDelegate> areadelegate;
@property (weak, nonatomic) id<shopDelegate> shopdelegate;
@property NSMutableArray *servicearea;
@property NSMutableArray *shop;
>>>>>>> homework

@end
