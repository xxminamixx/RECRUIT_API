//
//  HotpepperAPIFetcher.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "HotpepperAPIFetcher.h"

const NSString *APIKey = @"4554e737d0d5ce93";

@implementation HotpepperAPIFetcher

- (void)serviceAreaRequest
{
    NSURL *areaurl = [NSURL URLWithString:@"https://webservice.recruit.co.jp/hotpepper/service_area/v1/?key=4554e737d0d5ce93"];
    
    //URLからレスポンスを作成
   // NSURLRequest *arearequest = [NSURLRequest requestWithURL:areaurl];
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* areatask =
    [session dataTaskWithURL:areaurl
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
              
               NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
               parser.delegate = self;
               [parser parse];
               
               /*
               NSArray *array = [NSArray arrayWithObject:data];
               
               for(NSArray *d in array){
                   NSLog(@"%@",d);
               }
               */
           }];
    
    [areatask resume];
}

//デリゲートメソッド(解析開始時)
-(void) parserDidStartDocument:(NSXMLParser *)parser{
    
    NSLog(@"解析開始");
}

//デリゲートメソッド(要素の開始タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
     attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"要素の開始タグを読み込んだ:%@",elementName);
    
    // 解析中の要素名の保持
    NSMutableString *_nowElm = [NSMutableString stringWithString:elementName];

    if ([elementName isEqualToString:@"service_area"]) {
        if([elementName isEqualToString:@"name"])
            NSLog(@"サービスエリア：%@", elementName);
    }
    
}

//デリゲートメソッド(タグ以外のテキストを読み込んだ時)
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    NSLog(@"タグ以外のテキストを読み込んだ:%@", string);
    
}

//デリゲートメソッド(要素の終了タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser
  didEndElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName{
    
    NSLog(@"要素の終了タグを読み込んだ:%@",elementName);
}

//デリゲートメソッド(解析終了時)
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    
    NSLog(@"解析終了");
}






@end
