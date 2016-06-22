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
    NSURL *areaurl = [NSURL URLWithString:@"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=4554e737d0d5ce93"];
    
    //URLからレスポンスを作成
    NSURLRequest *arearequest = [NSURLRequest requestWithURL:areaurl];
    
}



@end
