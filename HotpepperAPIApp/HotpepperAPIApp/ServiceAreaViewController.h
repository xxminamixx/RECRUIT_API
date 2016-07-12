//
//  ServiceAreaViewController.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^getServiceArea)(NSMutableArray *array);
@interface ServiceAreaViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@end
