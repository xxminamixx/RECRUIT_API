//
//  HotpepperAPIFetcher.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "HotpepperAPIFetcher.h"
#import "ServiceAreaEntity.h"
#import "ServiceAreaViewController.h"

//const NSString *APIKey = @"4554e737d0d5ce93";
NSMutableArray *areaname;
ServiceAreaViewController *servicearea_viewcontroller;

@implementation HotpepperAPIFetcher

- (void)serviceAreaRequest
{
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

//デリゲートメソッド(解析開始時)
-(void) parserDidStartDocument:(NSXMLParser *)parser{
    
    NSLog(@"解析開始");
    //サービスエリア保存用のメモリ確保
    areaname = [NSMutableArray new];
    servicearea_viewcontroller = [ServiceAreaViewController new];
    
    //配列のポインタをServiceViewControllerへ渡す
    servicearea_viewcontroller.areanameholder = areaname;
}

//デリゲートメソッド(要素の開始タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
     attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"要素の開始タグを読み込んだ:%@",elementName);

    //サービスエリアのタグを発見したらis_servicearea のフラグを立てる
    if ([elementName isEqualToString:@"service_area"]) {
        _is_servicearea = YES;
    }
    
    if ([elementName isEqualToString:@"name"]) {
        _is_servicearea_name = YES;
    }
}

//デリゲートメソッド(タグ以外のテキストを読み込んだ時)
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    NSLog(@"タグ以外のテキストを読み込んだ:%@", string);
    
    if (_is_servicearea_name && _is_servicearea) {
        //サービスエリアの名前を配列にセット
        [areaname addObject:string];
    }
}

//デリゲートメソッド(要素の終了タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser
  didEndElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName{
    
    NSLog(@"要素の終了タグを読み込んだ:%@",elementName);
    
    //nameの終了タグを見つけたらis_serviceareaのフラグを下す
    if([elementName isEqualToString:@"name"]) {
        _is_servicearea_name = NO;
        _is_servicearea = NO;
    }
    
    if ([elementName isEqualToString:@"results"]) {
        ServiceAreaEntity *areaentity;
        [areaentity setAreaname:areaname];
    }
}

//デリゲートメソッド(解析終了時)
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    
    NSLog(@"解析終了");
    
    // デバッグ用
    
    for (NSString *d in areaname) {
        NSLog(@"%@", d);
    }
    
}

@end
