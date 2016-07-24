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

// constは変数名の頭に"k"をつける
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

@property NSData *data;

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
    [self getShopEntity:nameURL getShopList:shopList];
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
- (void)shopRequestWithAreacode:(NSString *)areaCode getShopList:(getShopList)shopList
{
    NSMutableString *url = [NSMutableString string];
    
    //　shop検索の雛形
    [url setString:@"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=4554e737d0d5ce93&service_area="];
    
    //　タップされたエリアコードを追加
    [url appendString:areaCode];
    [url appendString:@"&count="];
    [url appendString: self.searchNumberCast];
    
    //　NSURLにセット
    NSURL *shopURL = [NSURL URLWithString:url];
    [self getShopEntity:shopURL getShopList:shopList];
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
    [self getShopEntity:shopURL getShopList:shopList];}

// ジャンル取得
- (void)genreRequest:(getShopListOfGenre)shopList
{
    NSURL *genreURL = [NSURL URLWithString:@"https://webservice.recruit.co.jp/hotpepper/genre/v1/?key=4554e737d0d5ce93"];
    [self getShopEntity:genreURL getShopList:shopList];
    
}

// お店の情報が入った配列を返す
- (void)getShopEntity:(NSURL *)url getShopList:(getShopList)shopList
{
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main   = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        //xmlファイルの場所の設定
        self.data=[NSData dataWithContentsOfURL:url];
        //xmlファイルを取得
    
        dispatch_async(q_main, ^{
            DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData: self.data options:0 error:nil];
            
            //返すデータの配列を作成・初期化
            NSMutableArray *shopEntityList=[NSMutableArray new];
            
            //要素を抜き出す時のルートパスの設定
            NSDictionary *xml = [[doc rootElement] convertDictionary];
            
            //お店10件を格納
            NSDictionary *shopDict = [xml valueForKeyPath:kShopPath];
            
            for (NSDictionary *elements in shopDict) {
                ShopEntity *shopEntity = [ShopEntity new];
//                [shopEntity setShopId: [elements objectForKey: kShopId]];
                shopEntity.shopId = elements[kShopId];
//                [shopEntity setName: [elements objectForKey: shopName]];
                shopEntity.name = elements[kShopName];
//                [shopEntity setDetail: [elements objectForKey: kDetail]];
                shopEntity.detail = elements[kDetail];
//                [shopEntity setLogo: [elements objectForKey: kLogo]];
                shopEntity.logo = elements[kLogo];
//                [shopEntity setOpen: [elements objectForKey: kOpening]];
                shopEntity.open = elements[kOpening];
//                [shopEntity setAddress: [elements objectForKey: kAddress]];
                shopEntity.address = elements[kAddress];
//                [shopEntity setGenre: [elements valueForKeyPath:kGenreNamePath]];
                shopEntity.genre = elements[kGenreNamePath];
//                [shopEntity setCoupon: [elements valueForKeyPath: kCouponPCPath]];
                shopEntity.coupon = elements[kCouponPCPath];
//                [shopEntity setLargeLogo: [elements valueForKeyPath: kLargeLogoPath]];
                shopEntity.largeLogo = elements[kLargeLogoPath];
                
                // お店のデータが格納されたEntityを配列に格納
                [shopEntityList addObject: shopEntity];
                shopList(shopEntityList);
            }

       });
    });
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
//        [serviceAreaEntity setName: [dic valueForKey:kGenreName]];
//        [serviceAreaEntity setCode: [dic valueForKey:kGenreCode]];
        serviceAreaEntity.code = [dic valueForKey:kGenreCode];
        serviceAreaEntity.name = [dic valueForKey:kGenreName];
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
//        [shopGenreEntity setCode: [dic valueForKey:kGenreCode]];
//        [shopGenreEntity setName: [dic valueForKey:kGenreName]];
        shopGenreEntity.code = [dic valueForKey:kGenreCode];
        shopGenreEntity.name = [dic valueForKey:kGenreName];
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
@end
