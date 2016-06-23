//
//  HotpepperAPIFetcher.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "HotpepperAPIFetcher.h"
#import "ServiceAreaEntity.h"

// NSString * const APIKey = @"4554e737d0d5ce93";
// 警告を出さない書き方
// const NSString *str = @"sample"　とすると警告
NSString * const name = @"name";
NSString * const code = @"code";
NSString * const large_area = @"large_service_area";
NSString *savecode;
NSString *savename;
ServiceAreaEntity *servicearea_entity;
NSMutableArray *servicearea;


@implementation HotpepperAPIFetcher


- (void)serviceAreaRequest
{
    //サービスエリアのURL
    NSURL *areaurl = [NSURL URLWithString:@"https://webservice.recruit.co.jp/hotpepper/service_area/v1/?key=4554e737d0d5ce93"];
    
    //セッションの作成
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    //データの送受信
    NSURLSessionDataTask* areatask =
    [session dataTaskWithURL:areaurl
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
    // サービスエリア保存用のメモリ確保
    servicearea = [NSMutableArray new];
    
    // デフォルトでNOにしておく
    _is_large_servicearea = NO;
    
}


// デリゲートメソッド(要素の開始タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
     attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"要素の開始タグを読み込んだ:%@",elementName);
    
    
    // サービスエリアのタグを発見したらis_large_servicearea のフラグを立てる
    if ([elementName isEqualToString:large_area]) {
        _is_large_servicearea = YES;
        
        //ServiceAreaEntityを生成
        servicearea_entity = [ServiceAreaEntity new];
    }
    
    // ネームタグを見つけたらis_servicearea_code のフラグを立てる
    if ([elementName isEqualToString:code]) {
        _is_servicearea_code = YES;
    }
    
    // コードタグを見つけたらis_sesrvicearea_name のフラグを立てる
    if ([elementName isEqualToString:name]) {
        _is_servicearea_name = YES;
    }
}

// デリゲートメソッド(タグ以外のテキストを読み込んだ時)
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    NSLog(@"タグ以外のテキストを読み込んだ:%@", string);
    
    // サービスエリアの中のコードタグだった場合一時的にsavecodeに格納
    if (!_is_large_servicearea && _is_servicearea_code) {
        savecode = string;
    }
    
    // サービスエリアの中のネームタグだった場合一時的にsavenameに格納
    if (!_is_large_servicearea && _is_servicearea_name) {
        savename = string;
    }
}

// デリゲートメソッド(要素の終了タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    NSLog(@"要素の終了タグを読み込んだ:%@",elementName);
    
    if ([elementName isEqualToString:large_area]) {
        _is_large_servicearea = NO;
        
        [servicearea_entity setCode:savecode];
        [servicearea_entity setName:savename];
        
        //配列にcodeとnameの入ったEntityを格納
        [servicearea addObject: servicearea_entity];
        
        NSLog(@"コードは%@", servicearea_entity.code);
        NSLog(@"ネームは%@", servicearea_entity.name);
    }
    
    if ([elementName isEqualToString:code]) {
        _is_servicearea_code = NO;
    }
    
    // nameの終了タグを見つけたらis_serviceareaのフラグを下す
    if ([elementName isEqualToString:name]) {
        _is_servicearea_name = NO;
    }
}

// デリゲートメソッド(解析終了時)
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    
    NSLog(@"解析終了");
    
    
    }

}

@end
