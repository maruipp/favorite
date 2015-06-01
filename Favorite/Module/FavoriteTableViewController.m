//
//  FavoriteTableViewController.m
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/29.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "FEFavoriteManager.h"
#import "FEItem.h"
#import "SearchTableViewCell.h"
#import <StoreKit/StoreKit.h>
#import <SVProgressHUD.h>
@interface FavoriteTableViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,copy) FEItem *activeItem;

@end

@implementation FavoriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [FEFavoriteManager sharedManager].items;
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// UITableViewDataSource
// Placeholders for required UITableViewDataSource delegate methods
//
// Platform: iOS
// Language: Objective-C
// Completion Scope: Class Implementation

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEItem *item = [_dataArray objectAtIndex:indexPath.row];
    SearchTableViewCell *searchCell = (SearchTableViewCell *)cell;
    searchCell.nameLabel.text = item.trackName;
    __weak typeof(searchCell)weakCell = searchCell;
    __block BOOL isFavorite = [[FEFavoriteManager sharedManager].items containsObject:item];
    searchCell.favoriteBlock = ^(void){
        if (weakCell.isFavorite) {
            [[FEFavoriteManager sharedManager] pop:item];
            
        }else{
            [[FEFavoriteManager sharedManager] push:item];
        }
        isFavorite = !isFavorite;
        
        weakCell.isFavorite = isFavorite;
    };
    searchCell.isFavorite = isFavorite;
    [searchCell.appButton sd_setBackgroundImageWithURL:[NSURL URLWithString:item.artworkUrl60] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"image_default"] options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone)
        {
            searchCell.appButton.alpha = 0.0;
            [UIView animateWithDuration:1.0
                             animations:^{
                                 searchCell.appButton.alpha = 1.0;
                             }];
        }
    }];
    searchCell.versionLabel.text = item.version;

}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.activeItem = [_dataArray objectAtIndex:indexPath.row];
    
    if (iOS8) {
        NSString *tip = [NSString stringWithFormat:NSLocalizedString(@"go to app store question", nil),_activeItem.trackName];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        [self openAppWithIdentifier:_activeItem.trackId];
    }
}

#pragma mark - alert to app store
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            if (_activeItem.trackViewUrl) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_activeItem.trackViewUrl]];
            }
            break;
        default:
            break;
    }
}

#pragma mark - 滑动删除
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        FEItem *item = [_dataArray objectAtIndex:indexPath.row];
        [[FEFavoriteManager sharedManager] pop:item];
        [_dataArray removeObject:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (NSString*)tableView:(UITableView*)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"取消收藏";
}

#pragma mark - open detail store
- (void)openAppWithIdentifier:(NSNumber *)appId {
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    [SVProgressHUD showWithStatus:@"请稍候.." maskType:SVProgressHUDMaskTypeClear];
    
    NSDictionary *dict = @{SKStoreProductParameterITunesItemIdentifier:appId};
    
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
        if (result) {
            [self presentViewController:storeProductVC animated:YES completion:nil];
        }
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
