//
//  SearchNumberViewController.h
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/05.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchNumberViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *pickerView;

@end
