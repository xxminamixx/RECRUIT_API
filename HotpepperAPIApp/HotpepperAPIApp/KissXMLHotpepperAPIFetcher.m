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

// APIkeyと固定のURLを作成

@interface KissXMLHotpepperAPIFetcher()
@end

@implementation KissXMLHotpepperAPIFetcher

//　店舗名検索
- (void)shopRequestWithShopName:(NSString *)name getShopList:(getShopList)shopList
{
    NSMutableString *nameStr = [NSMutableString string];
    [nameStr setString:@"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=4554e737d0d5ce93&name="];
    [nameStr appendString:name];
    [nameStr appendString:@"&count="];
    [nameStr appendString: self.searchNumberCast];
    NSURL *nameURL = [NSURL URLWithString:[nameStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    shopList([self getShopEntity:nameURL]);
}


// 都道府県のリクエストURL作成
// blocksなのでblocksだとわかる変数名/型名
- (void)serviceAreaRequest:(getServiceArea)serviceAreaList
{
    // サービスエリアのURL
    NSURL *areaURL = [NSURL URLWithString:@"https://webservice.recruit.co.jp/hotpepper/service_area/v1/?key=4554e737d0d5ce93"];
    
    //一覧画面に取得したお店の配列を渡す
    serviceAreaList([self getServiceArea:areaURL]);
}

//　都道府県選択画面からお店のリクエストURL作成
- (void)shopRequestWithAreacode:(NSString *)areaCode getShopList:(getShopList)shopList loadNextCount:(NSInteger)loadNextCount
{
    NSMutableString *url = [NSMutableString string];
    
    //　shop検索の雛形
    [url setString:@"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=4554e737d0d5ce93&service_area="];
    
    //　タップされたエリアコードを追加
    [url appendString: [NSString stringWithFormat:@"&service_area=%@", areaCode]];
    [url appendString: [NSString stringWithFormat:@"&count=%@", self.searchNumberCast]];
    
    if (loadNextCount >= 1) {
        [url appendString: [NSString stringWithFormat:@"&start=%@",[self loadStartNumber: loadNextCount]]];
    }
    
    //　NSURLにセット
    NSURL *shopURL = [NSURL URLWithString:url];
    shopList([self getShopEntity:shopURL]);
}

// ジャンルコードからお店のリクエストURLを作成
- (void)shopRequestWithGenrecode:(NSString *)genreCode getShopList:(getShopList)shopList
{
    NSMutableString *url = [NSMutableString string];
    
    //　shop検索の雛形
    [url setString:@"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=4554e737d0d5ce93&genre="];
    
    //　タップされたジャンルコードを追加
    [url appendString:genreCode];
    [url appendString:@"&count="];
    [url appendString: self.searchNumberCast];
    
    //　NSURLにセット
    NSURL *shopURL = [NSURL URLWithString:url];
    shopList([self getShopEntity:shopURL]);
}

// ジャンル取得
- (void)genreRequest:(getShopListOfGenre)shopList
{
    NSURL *genreURL = [NSURL URLWithString:@"https://webservice.recruit.co.jp/hotpepper/genre/v1/?key=4554e737d0d5ce93"];
    //[self.genreDelegate getGenre:[self getShopGenre:genreURL]];
    shopList([self getShopGenre:genreURL]);
    
}

// お店の情報が入った配列を返す
- (NSMutableArray *)getShopEntity:(NSURL *)url
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
        
        [shopEntity setGenre: [elements valueForKeyPath:kGenreNamePath]];
        [shopEntity setLargeLogo: [elements valueForKeyPath: kLargeLogoPath]];
        [shopEntity setCoupon: [elements valueForKeyPath: kCouponPCPath]];

        
        // お店のデータが格納されたEntityを配列に格納
        [shopEntityList addObject: shopEntity];
    }
    
        return shopEntityList;
}


- (NSMutableArray *)getServiceArea:(NSURL *)url
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
    int searchNum = ([[searchNumbserSetting objectForKey:@"SearchNumberSettingKEY"] intValue] + 1) * 10;
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
