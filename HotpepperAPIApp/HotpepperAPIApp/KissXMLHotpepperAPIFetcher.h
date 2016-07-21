//
//  KissXMLHotpepperAPIFetcher.h
//  
//
//  Created by Minami Kyohei on 2016/07/08.
//
//

#import <Foundation/Foundation.h>
#import "DDXMLDocument.h"

typedef void(^getServiceArea)(NSMutableArray *serviceAreaList);
typedef void(^getShopList)(NSMutableArray *array);
typedef void(^getShopListOfGenre)(NSMutableArray *array);

@interface KissXMLHotpepperAPIFetcher : NSObject

- (void)serviceAreaRequest:(getServiceArea)serviceAreaList;
- (void)shopRequestWithAreacode:(NSString *)areaCode getShopList:(getShopList)shopList loadNextCount:(NSInteger)loadNextCount;
- (void)shopRequestWithGenrecode:(NSString *)genreCode getShopList:(getShopList)shopList;
- (void)shopRequestWithShopName:(NSString *)name getShopList:(getShopList)shopList;
- (void)genreRequest:(getShopListOfGenre)shopList;

@end
