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

@interface FavoriteTableViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation FavoriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [FEFavoriteManager sharedManager].items;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    searchCell.favoriteBlock = ^(void){
        BOOL isFavorite = [[FEFavoriteManager sharedManager].items containsObject:item];
        
        if (weakCell.isFavorite) {
            [[FEFavoriteManager sharedManager] pop:item];
            
        }else{
            [[FEFavoriteManager sharedManager] push:item];
        }
        isFavorite = !isFavorite;
        
        weakCell.isFavorite = isFavorite;
    };
    [searchCell.appButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:item.artworkUrl60] placeholderImage:[UIImage imageNamed:@"image_default"]];

}

@end
