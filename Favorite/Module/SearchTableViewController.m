//
//  SearchTableViewController.m
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/24.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import "SearchTableViewController.h"
#import "NSObject+Network.h"
#import "FEItem.h"
#import <SVProgressHUD.h>
#import "SearchTableViewCell.h"

#import "FEFavoriteManager.h"

@interface SearchTableViewController ()<UISearchBarDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSArray *searchHistoryArray;
@property (nonatomic,copy) FEItem *activeItem;
@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchHistoryArray = @[@"item1",@"item2",@"item3",@"item4"];
    _searchBar.delegate = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - network
- (void)requestAppByAppName:(NSString *)appName
{
    [_searchBar resignFirstResponder];
    [SVProgressHUD showWithStatus:@"请稍候.." maskType:SVProgressHUDMaskTypeClear];
    NSString *urlStr = @"https://itunes.apple.com/search";
    NSDictionary *paraDic = @{@"term":appName,@"country":@"CN",@"media":@"software"};
    [self getWithUrl:urlStr para:paraDic success:^(NSDictionary *responseObj) {
        NSArray *items = responseObj[@"results"];
        NSError *error = nil;
        self.dataArray = [MTLJSONAdapter modelsOfClass:FEItem.class fromJSONArray:items error:&error];
        if (!error) {
            [self.tableView reloadData];
            
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        if (-1001 == error.code) {
            [self.view makeToast:@"连接超时，请重试"];
        }
        [SVProgressHUD dismiss];
    }];
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
    if (tableView == self.tableView) {
        return _dataArray.count;
    }
//    else if (tableView == _searchDisplayController.searchResultsTableView){
//        return _searchHistoryArray.count;
//    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell" forIndexPath:indexPath];
        
        [self configureCell:cell forRowAtIndexPath:indexPath];
        
        return cell;
    }
//    else if (tableView == _searchDisplayController.searchResultsTableView){
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchTipsCell"];
//        cell.textLabel.text = _searchHistoryArray[indexPath.row];
//    }
    return nil;
    
}

#pragma mark - config cell
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
//    [searchCell.appButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:item.artworkUrl60] placeholderImage:[UIImage imageNamed:@"image_default"]];
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
// UITableViewDelegate
// Placeholders for required UITableViewDelegate protocol methods
//
// Platform: iOS
// Language: Objective-C
// Completion Scope: Class Implementation

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.activeItem = [_dataArray objectAtIndex:indexPath.row];
    NSString *tip = [NSString stringWithFormat:NSLocalizedString(@"go to app store question", nil),_activeItem.trackName];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTableViewCell *searchCell = (SearchTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [searchCell changeMaskToGray:YES];
    return YES;
}
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *searchCell = (SearchTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [searchCell changeMaskToGray:NO];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UISearchBar Delegate
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self requestAppByAppName:searchBar.text];
}

#pragma mark - touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [FEUtil closeKeyboard];
    
}


@end
