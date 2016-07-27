//
//  KissXMLHotpepperAPIFetcher.h
//  
//
//  Created by Minami Kyohei on 2016/07/08.
//
//

#import <Foundation/Foundation.h>
#import "DDXMLDocument.h"

typedef void(^didFetchServiceAreaBlock)(NSMutableArray *serviceAreaList);
typedef void(^didFetchShopListBloack)(NSMutableArray *array);
typedef void(^didGetchShopListOfGenreBlock)(NSMutableArray *array);

@interface KissXMLHotpepperAPIFetcher : NSObject

- (void)serviceAreaRequest:(didFetchServiceAreaBlock)didFetchServiceAreaBlock;
- (void)shopRequestWithAreacode:(NSString *)areaCode fetchCompleteBlock:(didFetchShopListBloack)fetchCompleteBlock loadNextCount:(NSInteger)loadNextCount;
- (void)shopRequestWithGenrecode:(NSString *)genreCode fetchCompleteBlock:(didFetchShopListBloack)fetchCompleteBlock;
- (void)shopRequestWithShopName:(NSString *)name fetchCompleteBlock:(didFetchShopListBloack)fetchCompleteBlock;
- (void)genreRequest:(didGetchShopListOfGenreBlock)didGetchShopListOfGenreBlock;

@end
