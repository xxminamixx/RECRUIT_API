//
//  KissXMLHotpepperAPIFetcher.h
//  
//
//  Created by Minami Kyohei on 2016/07/08.
//
//

#import <Foundation/Foundation.h>
#import "DDXMLDocument.h"

@protocol serviceAreaDelegate <NSObject>
- (void)getServiceArea:(NSMutableArray *)servicearea; // コントローラーに配列を渡す
@end

@protocol shopDelegate <NSObject>
- (void)getShop:(NSMutableArray *)shop;
@end

@interface KissXMLHotpepperAPIFetcher : NSObject
@property (nonatomic, weak) id<serviceAreaDelegate> serviceAreaDelegate;
@property (nonatomic, weak) id<shopDelegate> shopDelegate;
- (void)serviceAreaRequest;
- (void)shopRequest:(NSString *)areacode;
- (void)shopRequestWithName:(NSString *)name;
@end
