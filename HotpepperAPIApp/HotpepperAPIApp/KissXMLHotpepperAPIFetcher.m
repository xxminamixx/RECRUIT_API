//
//  KissXMLHotpepperAPIFetcher.m
//  
//
//  Created by Minami Kyohei on 2016/07/08.
//
//

#import "KissXMLHotpepperAPIFetcher.h"
#import "DDXMLElement+Dictionary.h"

@implementation KissXMLHotpepperAPIFetcher
- (void)perseTest
{
    NSMutableArray *mxlList = [self getXml];
   // NSLog(@"%@",[mxlList objectAtIndex:0] objectAtIndex:0);
    
}

- (NSMutableArray *)getXml{
    
    //xmlファイルの場所の設定
    NSURL *urlString=[NSURL URLWithString:@"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=4554e737d0d5ce93&service_area=SA11"];
    NSData *data=[NSData dataWithContentsOfURL:urlString];
    
    //返すデータの配列を作成・初期化
    NSMutableArray *aryRet=[[NSMutableArray alloc]initWithCapacity:0];
    
    //xmlファイルを取得
    DDXMLDocument *doc=
    [[DDXMLDocument alloc]initWithData:data options:0 error:nil];
    
    //要素を抜き出す時のルートパスの設定
    NSDictionary *xml = [[doc rootElement] convertDictionary];
    
    //お店10件を格納
    NSArray *shopList = [xml valueForKeyPath:@"results.shop"];
    
    for (NSArray *elements in shopList) {
        for (NSArray *items in elements ) {
            NSLog(@"%@", items);
        }
    }
    
    /*
    //高速列挙
    for (DDXMLElement *item in items) {
        
        //ルートパス以下の要素名を指定
        NSArray *titleArray=[item nodesForXPath:@"id" error:nil];
        NSArray *linkArray=[item nodesForXPath:@"name" error:nil];
        NSArray *dateArray=[item nodesForXPath:@"detail" error:nil];
        
        
        //バッファ用配列
        NSMutableArray *tmpAry=[[NSMutableArray alloc]initWithCapacity:0];
        
        //ルートパス以下の要素を得る、配列型で来るのでNSString型に変換
        [tmpAry addObject:[[titleArray objectAtIndex:0]stringValue]];
        [tmpAry addObject:[[linkArray objectAtIndex:0]stringValue]];
        [tmpAry addObject:[[dateArray objectAtIndex:0]stringValue]];
        
         
        //戻す配列に格納、バッファ用配列は格納後リリース
        [aryRet addObject:tmpAry];
        //[tmpAry release];
    }
     */
    
    //xmlファイルをリリース
    //[doc release];
    
    //取得データを返す
    return aryRet;
}
@end
