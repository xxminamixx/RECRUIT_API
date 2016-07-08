//
//  KissXMLHotpepperAPIFetcher.h
//  
//
//  Created by Minami Kyohei on 2016/07/08.
//
//

#import <Foundation/Foundation.h>
#import "DDXMLDocument.h"

@protocol serviceAreaDelegate <NSObject>
- (void)getServiceArea:(NSMutableArray *)servicearea; // コントローラーに配列を渡す
@end


@interface KissXMLHotpepperAPIFetcher : NSObject
@property (nonatomic,weak) id<serviceAreaDelegate> serviceAreaDelegate;
- (void)serviceAreaRequest;
- (void)shopRequest:(NSString *)areacode;
@end
