//
//  HotpepperAPIFetcher.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "HotpepperAPIFetcher.h"
#import "ServiceAreaEntity.h"
#import "ShopEntity.h"

// NSString * const APIKey = @"4554e737d0d5ce93";

// 警告を出さない書き方
// const NSString *str = @"sample"　とすると警告
NSString * const name = @"name";
NSString * const code = @"code";
NSString * const large_area = @"large_service_area";
NSString * const shop = @"shop";
NSString * const logo = @"logo_image";
NSString * const address = @"address";
NSString * const genre = @"genre";
NSString * const food = @"food";
NSString * const detail = @"shop_detail_memo";

NSString *savecode;
NSString *savename;
NSString *savelogo;
NSString *savedetail;
NSData *logo_image;

BOOL is_large_servicearea = NO;
BOOL is_servicearea_code = NO;
BOOL is_servicearea_name = NO;

BOOL is_shop = NO;
BOOL is_shop_name = NO;
BOOL is_logo = NO;
BOOL is_detail = NO;

BOOL is_area_request = NO;
BOOL is_shop_request = NO;
ServiceAreaEntity *servicearea_entity;

@implementation HotpepperAPIFetcher

//　都道府県選択画面からお店のリクエストURL作成
- (void)shopRequest:(NSString *)areacode
{
    NSMutableString *url = [NSMutableString string];
   
    //　shop検索の雛形
    [url setString:@"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=4554e737d0d5ce93&service_area="];
  
    //　タップされたエリアコードを追加
    [url appendString:areacode];
    
    //　NSURLにセット
    NSURL *shopurl = [NSURL URLWithString:url];
    is_shop_request = YES;
    [self sendRequest:shopurl];
    
}


- (void) imageRequest:(NSString *)url
{
    NSURL *imageurl = [NSURL URLWithString:url];
    [self sendRequest:imageurl];
}


// 都道府県のリクエストURL作成
- (void)serviceAreaRequest
{
    //サービスエリアのURL
    NSURL *areaurl = [NSURL URLWithString:@"https://webservice.recruit.co.jp/hotpepper/service_area/v1/?key=4554e737d0d5ce93"];
    is_area_request = YES;
    [self sendRequest:areaurl];
}


- (void)sendRequest:(NSURL*)requesturl
{
    //セッションの作成
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    //データの送受信
    NSURLSessionDataTask* areatask =
    [session dataTaskWithURL:requesturl
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
              
                   NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
                   parser.delegate = self;
                   [parser parse];
               
           }];
    [areatask resume];

}



// デリゲートメソッド(解析開始時)
-(void) parserDidStartDocument:(NSXMLParser *)parser{
    
    NSLog(@"解析開始");
    if (is_area_request) {
        // サービスエリア保存用のメモリ確保
        _servicearea = [NSMutableArray array];
    }
    
    if (is_shop_request) {
        _shop = [NSMutableArray array];
    }
}


// デリゲートメソッド(要素の開始タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
     attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"要素の開始タグを読み込んだ:%@",elementName);
    
    // 都道府県取得処理
    if (is_area_request) {
        // サービスエリアのタグを発見したらis_large_servicearea のフラグを立てる
        if ([elementName isEqualToString:large_area]) {
            is_large_servicearea = YES;
        }
    
        // ネームタグを見つけたらis_servicearea_code のフラグを立てる
        if ([elementName isEqualToString:code]) {
            is_servicearea_code = YES;
        }
    
        // コードタグを見つけたらis_sesrvicearea_name のフラグを立てる
        if ([elementName isEqualToString:name]) {
            is_servicearea_name = YES;
        }
    }
    
    //　都道府県からお店検索処理
    if (is_shop_request) {
        if ([elementName isEqualToString:shop]) {
            is_shop = YES;
        }
        
        if ([elementName isEqualToString:name]) {
            is_shop_name = YES;
        }
        
        if ([elementName isEqualToString:logo]) {
            is_logo = YES;
        }
        
        if ([elementName isEqualToString:detail]) {
            is_detail = YES;
        }
    }

}

// デリゲートメソッド(タグ以外のテキストを読み込んだ時)
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    NSLog(@"タグ以外のテキストを読み込んだ:%@", string);
    if (is_area_request) {
        // サービスエリアの中のコードタグだった場合一時的にsavecodeに格納
        if (!is_large_servicearea && is_servicearea_code) {
            savecode = string;
        }
        // サービスエリアの中のネームタグだった場合一時的にsavenameに格納
        if (!is_large_servicearea && is_servicearea_name) {
            savename = string;
        }
    }
    
    if (is_shop_request) {
        if (is_shop && is_shop_name) {
            savename = string;
        }
        
        if (is_logo) {
            savelogo = string;
        }
        
        if (is_detail) {
            savedetail = string;
        }
    }
    
}

// デリゲートメソッド(要素の終了タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    NSLog(@"要素の終了タグを読み込んだ:%@",elementName);
    
    if (is_area_request) {
        // large_service_areaの終了タグを見つけたらis_large_serviceareaのフラグを下す
        if ([elementName isEqualToString:large_area]) {
            is_large_servicearea = NO;
        
            // ServiceAreaEntityを生成
            servicearea_entity = [ServiceAreaEntity new];
        
            [servicearea_entity setCode:savecode];
            [servicearea_entity setName:savename];
        
            // 配列にcodeとnameの入ったEntityを格納
            [_servicearea addObject: servicearea_entity];
        
            // デバッグ用
            NSLog(@"コードは%@", servicearea_entity.code);
            NSLog(@"ネームは%@", servicearea_entity.name);
        }
    
        // codeの終了タグを見つけたらis_servicearea_codeのフラグを下す
        if ([elementName isEqualToString:code]) {
            is_servicearea_code = NO;
        }
    
        // nameの終了タグを見つけたらis_servicearea_nameのフラグを下す
        if ([elementName isEqualToString:name]) {
            is_servicearea_name = NO;
        }
    }
    
    if (is_shop_request) {
        if ([elementName isEqualToString:name]) {
            is_shop = NO;
            is_shop_name = NO; //店名以外にもnameタグたあるため
        }
        
        if ([elementName isEqualToString:logo]) {
            is_logo = NO;
        }
        
        if ([elementName isEqualToString:detail]) {
            is_detail = NO;
        }
        
        // shopタグの終わりを見つけた時にエンティティを配列に格納
        if ([elementName isEqualToString:shop]) {
            ShopEntity *shopEntity = [ShopEntity new];
            [shopEntity setName:savename];
            [shopEntity setLogo:savelogo];
            [shopEntity setDetail:savedetail];
            
            [_shop addObject:shopEntity];
        }
    }
}

// デリゲートメソッド(解析終了時)
- (void) parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"解析終了");
    if (is_area_request) {
        // デリゲートメソッドの呼び出し
        [self.areadelegate getServiceArea:_servicearea];
        is_area_request = NO;
    }
    
    if (is_shop_request) {
        [self.shopdelegate getShop:_shop];
        is_shop_request = NO;
    }
}

@end
