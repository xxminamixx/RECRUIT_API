//
//  ServiceAreaEntity.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/22.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceAreaEntity : NSObject
{
    
}

@property (weak, nonatomic) NSMutableArray *areacode;
@property (weak, nonatomic) NSMutableArray *areaname;

/*
+ (NSArray *)getAreaName;
+ (NSArray *)getAreaCode;
+ (void)setAreaCode:(NSString *)areacodestr;
+ (void)setAreaName:(NSString *)areanamestr;
*/
 
@end
