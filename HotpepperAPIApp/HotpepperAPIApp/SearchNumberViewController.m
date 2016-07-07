//
//  SearchNumberViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/05.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "SearchNumberViewController.h"

NSString * const searchNumber = @"SearchNumberSettingKEY";

@interface SearchNumberViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *searchNumberPicker;

@end

@implementation SearchNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchNumberPicker.delegate = self;
    self.searchNumberPicker.dataSource = self;
    self.navigationItem.title = @"検索件数設定";

    //Pickerの初期値設定
    NSUserDefaults *searchNumbserSetting = [NSUserDefaults standardUserDefaults];
    int searchNumIndex = ([[searchNumbserSetting objectForKey:@"SearchNumberSettingKEY"] intValue] / 10) - 1;
    [self.searchNumberPicker selectRow:searchNumIndex  inComponent:0 animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerView Datasource
// 行の数を設定
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

// 列の数を設定
-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld", (row + 1) * 10];
}


#pragma mark - UIPickerView Delegate
// 選択されたピッカービューを取得
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 0列目の選択している行番号を取得
    NSInteger selectedRow = ([pickerView selectedRowInComponent:0] + 1) * 10;
    NSNumber *castRow = [NSNumber numberWithInteger:selectedRow];
    
    // 選択した件数を永続化
    NSUserDefaults *searchNumbserSetting = [NSUserDefaults standardUserDefaults];
    [searchNumbserSetting setObject:castRow forKey:@"SearchNumberSettingKEY"];
    [searchNumbserSetting synchronize];
    
    NSLog(@"%@", castRow);
}

@end
