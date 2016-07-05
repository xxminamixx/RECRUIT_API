//
//  SearchNumberViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/05.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "SearchNumberViewController.h"

@interface SearchNumberViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *searchNumberPicker;

@end

@implementation SearchNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchNumberPicker.delegate = self;
    self.searchNumberPicker.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld", (row + 1) * 10];
}


@end
