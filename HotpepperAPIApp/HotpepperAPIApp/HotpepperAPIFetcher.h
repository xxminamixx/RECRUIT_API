//
//  HotpepperAPIFetcher.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotpepperAPIFetcher : NSObject
- (void)serviceAreaRequest;
@property BOOL is_servicearea;
@end
