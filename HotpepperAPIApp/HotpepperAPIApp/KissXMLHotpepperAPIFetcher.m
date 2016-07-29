//
//  KissXMLHotpepperAPIFetcher.m
//  
//
//  Created by Minami Kyohei on 2016/07/08.
//
//

#import "KissXMLHotpepperAPIFetcher.h"
#import "DDXMLElement+Dictionary.h"
#import "ShopEntity.h"
#import "ServiceAreaEntity.h"
#import "ShopGenreEntity.h"
#import "ServiceAreaViewController.h"
#import "SearchNumberViewController.h"

NSString * const kShopId = @"id";
NSString * const kShopName = @"name";
NSString * const kDetail = @"shop_detail_memo";
NSString * const kLogo = @"logo_image";
NSString * const kOpening = @"open";
NSString * const kAddress = @"address";

NSString * const kShopPath = @"results.shop";
NSString * const kGenrePath = @"results.genre";
NSString * const kGenreNamePath = @"genre.name";
NSString * const kCouponPCPath = @"coupon_urls.pc";
NSString * const kLargeLogoPath = @"photo.mobile.l";
NSString * const kServiceAreaPath = @"results.service_area";

NSString * const kGenreCode = @"code";
NSString * const kGenreName = @"name";

NSString * const kHotpepperURL = @"https://webservice.recruit.co.jp/hotpepper/";
NSString * const kAPIKey = @"?key=4554e737d0d5ce93";
NSString * const kGourmetSearchParameter = @"gourmet/v1/";
NSString * const kGenreSearchParameter = @"genre/v1/";
NSString * const kServiceAreaSearchParameter = @"service_area/v1/";

@interface KissXMLHotpepperAPIFetcher()

@property NSData *data;

@end

@implementation KissXMLHotpepperAPIFetcher

//　店舗名検索
- (void)shopRequestWithShopName:(NSString *)name fetchCompleteBlock:(didFetchShopListBloack)fetchCompleteBlock
{
    NSMutableString *nameStr = [NSMutableString string];
    [nameStr setString:kHotpepperURL];
    [nameStr appendString:kGourmetSearchParameter];
    [nameStr appendString:kAPIKey];
    [nameStr appendString:[NSString stringWithFormat:@"&name=%@",name]];
    [nameStr appendString:[NSString stringWithFormat:@"&count=%@", self.searchNumberCast]];
    NSURL *nameURL = [NSURL URLWithString:[nameStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self getShopEntity:nameURL fetchCompleteBlock:fetchCompleteBlock];
}


// 都道府県のリクエストURL作成
- (void)serviceAreaRequest:(didFetchServiceAreaBlock)didFetchServiceAreaBlock
{
    // サービスエリアのURL
    NSMutableString *serviceAreaSearchStr = [NSMutableString string];
    [serviceAreaSearchStr setString:kHotpepperURL];
    [serviceAreaSearchStr appendString:kServiceAreaSearchParameter];
    [serviceAreaSearchStr appendString:kAPIKey];
    NSURL *areaURL = [NSURL URLWithString:[serviceAreaSearchStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //一覧画面に取得したお店の配列を渡す
    didFetchServiceAreaBlock([self getServiceArea:areaURL getShopList:didFetchServiceAreaBlock]);
}

//　都道府県選択画面からお店のリクエストURL作成
- (void)shopRequestWithAreacode:(NSString *)areaCode fetchCompleteBlock:(didFetchShopListBloack)fetchCompleteBlock loadNextCount:(NSInteger)loadNextCount
{
    NSMutableString *shopSearchWithAreaCodeStr = [NSMutableString string];
    
    [shopSearchWithAreaCodeStr setString:kHotpepperURL];
    [shopSearchWithAreaCodeStr appendString:kGourmetSearchParameter];
    [shopSearchWithAreaCodeStr appendString:kAPIKey];
    [shopSearchWithAreaCodeStr appendString: [NSString stringWithFormat:@"&service_area=%@", areaCode]];
    [shopSearchWithAreaCodeStr appendString: [NSString stringWithFormat:@"&count=%@", self.searchNumberCast]];
    
    if (loadNextCount >= 1) {
        [shopSearchWithAreaCodeStr appendString: [NSString stringWithFormat:@"&start=%@",[self loadStartNumber: loadNextCount]]];
    }
    
    //　NSURLにセット
    NSURL *shopURL = [NSURL URLWithString:shopSearchWithAreaCodeStr];
    [self getShopEntity:shopURL fetchCompleteBlock:fetchCompleteBlock];
}

// ジャンルコードからお店のリクエストURLを作成
- (void)shopRequestWithGenrecode:(NSString *)genreCode fetchCompleteBlock:(didFetchShopListBloack)fetchCompleteBlock
{
    NSMutableString *shopSearchWithGenreCodeStr = [NSMutableString string];
    
    //　shop検索の雛形
    [shopSearchWithGenreCodeStr setString:kHotpepperURL];
    [shopSearchWithGenreCodeStr appendString:kGourmetSearchParameter];
    [shopSearchWithGenreCodeStr appendString:kAPIKey];
    [shopSearchWithGenreCodeStr appendString:[NSString stringWithFormat:@"&genre=%@",genreCode]];
    [shopSearchWithGenreCodeStr appendString: [NSString stringWithFormat:@"&count=%@", self.searchNumberCast]];
    
    //　NSURLにセット
    NSURL *shopURL = [NSURL URLWithString:shopSearchWithGenreCodeStr];
    [self getShopEntity:shopURL fetchCompleteBlock:fetchCompleteBlock];
}

// ジャンル取得
- (void)genreRequest:(didGetchShopListOfGenreBlock)didGetchShopListOfGenreBlock
{
    NSMutableString *shopGenreSearchStr = [NSMutableString string];
    [shopGenreSearchStr setString:kHotpepperURL];
    [shopGenreSearchStr appendString:kGenreSearchParameter];
    [shopGenreSearchStr appendString:kAPIKey];
    NSURL *genreURL = [NSURL URLWithString:shopGenreSearchStr];
    didGetchShopListOfGenreBlock([self getShopGenre:genreURL]);
}

// お店の情報が入った配列を返す
- (void)getShopEntity:(NSURL *)url fetchCompleteBlock:(didFetchShopListBloack)fetchCompleteBlock
{

    //xmlファイルの場所の設定
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    //返すデータの配列を作成・初期化
    NSMutableArray *shopEntityList=[NSMutableArray new];
    
    //xmlファイルを取得
    DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:data options:0 error:nil];
    
    //要素を抜き出す時のルートパスの設定
    NSDictionary *xml = [[doc rootElement] convertDictionary];
    
    //お店10件を格納
    NSDictionary *shopDict = [xml valueForKeyPath:kShopPath];
    
    for (NSDictionary *elements in shopDict) {
        ShopEntity *shopEntity = [ShopEntity new];
        shopEntity.shopId = elements[kShopId];
        shopEntity.name = elements[kShopName];
        shopEntity.detail = elements[kDetail];
        shopEntity.logo = elements[kLogo];
        shopEntity.open = elements[kOpening];
        shopEntity.address = elements[kAddress];
        shopEntity.genre = [elements valueForKeyPath:kGenreNamePath];
        shopEntity.largeLogo = [elements valueForKeyPath: kLargeLogoPath];
        shopEntity.coupon = [elements valueForKeyPath: kCouponPCPath];
        shopEntity.parking = [elements valueForKeyPath:@"parking"];
        
        // お店のデータが格納されたEntityを配列に格納
        [shopEntityList addObject: shopEntity];
    }
    fetchCompleteBlock:fetchCompleteBlock(shopEntityList);
}


- (NSMutableArray *)getServiceArea:(NSURL *)url getShopList:(didFetchShopListBloack)shopList
{
    //xmlファイルの場所の設定
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSMutableArray *serviceAreaList = [NSMutableArray array];
    
    //xmlファイルを取得
    DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:data options:0 error:nil];
    
    //要素を抜き出す時のルートパスの設定
    NSDictionary *xml = [[doc rootElement] convertDictionary];
    NSDictionary *serviceAreaDict = [xml valueForKeyPath:kServiceAreaPath];
    
    for (NSDictionary *dic in serviceAreaDict) {
        ServiceAreaEntity *serviceAreaEntity = [ServiceAreaEntity new];
        serviceAreaEntity.name = dic[kGenreName];
        serviceAreaEntity.code = dic[kGenreCode];
        [serviceAreaList addObject: serviceAreaEntity];
    }
    return serviceAreaList;

}

// ジャンルEntityの配列を返す
- (NSMutableArray *)getShopGenre:(NSURL *)url
{
    //xmlファイルの場所の設定
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSMutableArray *shopGenreList = [NSMutableArray array];
    
    //xmlファイルを取得
    DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:data options:0 error:nil];
    
    //要素を抜き出す時のルートパスの設定
    NSDictionary *xml = [[doc rootElement] convertDictionary];
    NSDictionary *shopGenreDict = [xml valueForKeyPath:kGenrePath];
    
    for (NSDictionary *dic in shopGenreDict) {
        ShopGenreEntity *shopGenreEntity = [ShopGenreEntity new];
        shopGenreEntity.name = dic[kGenreName];
        shopGenreEntity.code = dic[kGenreCode];
        [shopGenreList addObject: shopGenreEntity];
    }
    return shopGenreList;
}

// 永続化した表示件数を取得し検索用に変換する
- (NSString *)searchNumberCast
{
    // 表示件数の取得
    NSUserDefaults *searchNumbserSetting = [NSUserDefaults standardUserDefaults];
    int searchNum = ([[searchNumbserSetting objectForKey:searchNumber] intValue] + 1) * 10;
    NSString *sSearchNum = [NSString stringWithFormat:@"%d", searchNum];
    return  sSearchNum;
}

// 検索開始値を永続化した値から確定
- (NSString *)loadStartNumber:(NSInteger)loadNextNumber
{
    NSInteger loadStartNum = [[self searchNumberCast] intValue] + ((loadNextNumber -1) * 10) + 1;
    NSString *loadStartStr = [NSString stringWithFormat:@"%ld",loadStartNum];
    return loadStartStr;
}

@end
