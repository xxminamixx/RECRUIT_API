//
//  ShopDetailViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/06/27.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "FavoriteShopManager.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface ShopDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shopname;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UITextView *detail;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *open;
@property (weak, nonatomic) IBOutlet UILabel *genre;
@property (strong, nonatomic) IBOutlet UIView *detailView;
- (IBAction)favoriteAction:(id)sender;
@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setShopLogo: self.shopEntity.logo];
    
    _shopname.text = _shopEntity.name;
    _detail.text = _shopEntity.detail;
    _address.text = _shopEntity.address;
    [_address setNumberOfLines:0];
    _address.frame = CGRectMake(0, 0, 200, 0);
    [_address sizeToFit];
    _open.text = _shopEntity.open;
    _genre.text = _shopEntity.genre;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)favoriteAction:(id)sender
{
    /*
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    //イベントのフェッチ
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FavoriteShopEntity"
                                              inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext
                                            executeFetchRequest:request error:&error] mutableCopy];
    */
    // マネージャーに投げて既にお気に入りに登録されているかチェックする
    FavoriteShopManager *favoriteManager = [FavoriteShopManager new];
    //[favoriteManager alreadyFavorite: mutableFetchResults];

    [favoriteManager alreadyFavorite:self.shopEntity];
    
    // 詳細表示しているお店のEntityをManagerに渡す
    [favoriteManager getFavoriteShop:self.shopEntity];
}

- (void)setShopLogo:(NSString*)url {
    [self.logo sd_setImageWithURL:[NSURL URLWithString:url]];
    [self.detailView setNeedsDisplay];
    
}
@end
