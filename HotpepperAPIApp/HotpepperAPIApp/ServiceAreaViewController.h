//
//  ServiceAreaViewController.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tapCellDelegate <NSObject>

- (void)getIndexPathRow:(NSInteger)index;

@end

@interface ServiceAreaViewController : UIViewController
@property (weak, nonatomic) id<tapCellDelegate> tapdelegate;

@end
