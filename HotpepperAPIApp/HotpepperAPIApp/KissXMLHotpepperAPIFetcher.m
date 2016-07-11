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

@interface KissXMLHotpepperAPIFetcher()
//@property NSMutableString *nameStr;
@end

@implementation KissXMLHotpepperAPIFetcher

//　店舗名検索
- (void)shopRequestWithName:(NSString *)name
{
    NSMutableString *nameStr = [NSMutableString string];
    [nameStr setString:@"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=4554e737d0d5ce93&name="];
    [nameStr appendString:name];
    [nameStr appendString:@"&count="];
    [nameStr appendString: self.searchNumberCast];
    NSURL *nameURL = [NSURL URLWithString:[nameStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self.shopDelegate getShop:[self getShopEntity:nameURL]];
}


// 都道府県のリクエストURL作成
- (void)serviceAreaRequest
{
    //サービスエリアのURL
    NSURL *areaURL = [NSURL URLWithString:@"https://webservice.recruit.co.jp/hotpepper/service_area/v1/?key=4554e737d0d5ce93"];
    
    // delegateメソッドに配列を渡す
    [self.serviceAreaDelegate getServiceArea:[self getServiceArea:areaURL]];
}

//　都道府県選択画面からお店のリクエストURL作成
- (void)shopRequest:(NSString *)areacode
{
    NSMutableString *url = [NSMutableString string];
    
    //　shop検索の雛形
    [url setString:@"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=4554e737d0d5ce93&service_area="];
    
    //　タップされたエリアコードを追加
    [url appendString:areacode];
    [url appendString:@"&count="];
    [url appendString: self.searchNumberCast];
    
    //　NSURLにセット
    NSURL *shopurl = [NSURL URLWithString:url];
    [self.shopDelegate getShop:[self getShopEntity:shopurl]];
    
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
    NSDictionary *shopDict = [xml valueForKeyPath:@"results.shop"];
    
    for (NSDictionary *elements in shopDict) {
        ShopEntity *shopEntity = [ShopEntity new];
        [shopEntity setShopId: [elements objectForKey:@"id"]];
        [shopEntity setName: [elements objectForKey:@"name"]];
        [shopEntity setDetail: [elements objectForKey:@"shop_detail_memo"]];
        [shopEntity setLogo: [elements objectForKey:@"logo_image"]];
        [shopEntity setOpen: [elements objectForKey:@"open"]];
        [shopEntity setAddress: [elements objectForKey:@"address"]];
        [shopEntity setGenre: [elements valueForKeyPath:@"genre.name"]];
        // mobile未対応の店が多いためpcサイトを取得
        [shopEntity setCoupon: [elements valueForKeyPath:@"coupon_urls.pc"]];
        [shopEntity setLargeLogo: [elements valueForKeyPath:@"photo.mobile.l"]];
        
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
    NSDictionary *serviceAreaDict = [xml valueForKeyPath:@"results.service_area"];
    
    for (NSDictionary *dic in serviceAreaDict) {
        ServiceAreaEntity *serviceAreaEntity = [ServiceAreaEntity new];
        [serviceAreaEntity setName: [dic valueForKey:@"name"]];
        [serviceAreaEntity setCode: [dic valueForKey:@"code"]];
        [serviceAreaList addObject: serviceAreaEntity];
    }
    return serviceAreaList;
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
@end
