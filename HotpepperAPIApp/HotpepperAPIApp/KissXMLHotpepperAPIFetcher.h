//
//  KissXMLHotpepperAPIFetcher.h
//  
//
//  Created by Minami Kyohei on 2016/07/08.
//
//

#import <Foundation/Foundation.h>
#import "DDXMLDocument.h"
#import "ServiceAreaViewController.h"
#import "ShopListViewController.h"
#import "ShopGenreViewController.h"

@protocol serviceAreaDelegate <NSObject>
//- (void)getServiceArea:(NSMutableArray *)servicearea; // コントローラーに配列を渡す
@end

@protocol shopDelegate <NSObject>
//- (void)getShop:(NSMutableArray *)shop;
@end

@protocol shopGenreDelegate <NSObject>
- (void)getGenre:(NSMutableArray *)genreList;
@end


@interface KissXMLHotpepperAPIFetcher : NSObject
@property (nonatomic, weak) id<serviceAreaDelegate> serviceAreaDelegate;
@property (nonatomic, weak) id<shopDelegate> shopDelegate;
@property (nonatomic, weak) id<shopGenreDelegate> genreDelegate;
- (void)serviceAreaRequest:(getServiceArea)serviceAreaList;
- (void)shopRequestWithAreacode:(NSString *)areaCode: (getShopList)shopList;
- (void)shopRequestWithGenrecode:(NSString *)genreCode: (getShopList)shopList;
- (void)shopRequestWithShopName:(NSString *)name;
- (void)genreRequest:(getShopListOfGenre)shopList;
@end
