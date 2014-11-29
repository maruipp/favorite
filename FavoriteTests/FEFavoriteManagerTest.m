//
//  FEFavoriteManagerTest.m
//  Favorite
//
//  Created by 马 瑞鹏 on 14/11/29.
//  Copyright (c) 2014年 FourEye Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FEFavoriteManager.h"
#import "FEItem.h"
@interface FEFavoriteManagerTest : XCTestCase
{
    FEFavoriteManager *_favoriteManager;
}
@end

@implementation FEFavoriteManagerTest

- (void)setUp {
    [super setUp];
    _favoriteManager = [FEFavoriteManager sharedManager];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _favoriteManager = nil;
    [super tearDown];
}

- (void)testPush{
    FEItem *item = [[FEItem alloc] init];
    item.trackId = @1;
    [_favoriteManager push:item];
    XCTAssertTrue([_favoriteManager.items containsObject:item], @"push should be success");
}

- (void)testPop{
    FEItem *item = [[FEItem alloc] init];
    item.trackId = @1;
    [_favoriteManager push:item];
    [_favoriteManager pop:item];
    XCTAssertTrue(![_favoriteManager.items containsObject:item], @"pop should not exist in items");
}

- (void)testFilePathNotNil
{
    XCTAssertNotNil(_favoriteManager.filePath, @"favorite file path should not be nil");
}

- (void)testItemsStorage
{
    FEItem *item = [[FEItem alloc] init];
    item.trackId = @1;
    [_favoriteManager push:item];
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillTerminateNotification object:nil];
    NSArray *results = [_favoriteManager itemsInDisk];
    XCTAssertTrue([results containsObject:item], @"storage or initFromDisk not success");

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
