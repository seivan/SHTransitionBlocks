//
//  SHActionSheetBlocksCallbacksScenarion.m
//  Example
//
//  Created by Seivan Heidari on 7/31/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHNavigationControllerBlocksSuper.h"


@interface SHNavigationControllerBlocksCallbacksIntegration : SHNavigationControllerBlocksSuper

@end

@implementation SHNavigationControllerBlocksCallbacksIntegration

-(void)testSH_setWillShowViewControllerBlock; {
  __block BOOL didAssert = NO;
  
  __weak typeof(self) weakSelf = self;
  self.block        = ^void(UINavigationController * theNavigationController,
                            UIViewController       * theViewController,
                            BOOL                      isAnimated) {
    
    XCTAssertEqualObjects(weakSelf.navCon, theNavigationController);
    if(theViewController == weakSelf.vc) {
      XCTAssertEqualObjects(weakSelf.vc, theViewController);
    }
    else {
      XCTAssertEqualObjects(weakSelf.navCon.viewControllers.firstObject, theViewController);
      XCTAssertFalse(isAnimated);
    }
    
    didAssert = YES;

    
  };
  
  [self.navCon SH_setWillShowViewControllerBlock:self.block];
  [self.navCon pushViewController:self.vc animated:YES];
  [tester waitForTimeInterval:1];
  [tester waitForViewWithAccessibilityLabel:@"second"];
  XCTAssertTrue(didAssert);
  
  didAssert = NO;
  
  [self.navCon popToRootViewControllerAnimated:NO];
  [tester waitForViewWithAccessibilityLabel:@"first"];
  XCTAssertTrue(didAssert);
  
  
}

-(void)testSH_setDidShowViewControllerBlock; {
  __block BOOL didAssert = NO;

  __weak typeof(self) weakSelf = self;
  
  self.block        = ^void(UINavigationController * theNavigationController,
                            UIViewController       * theViewController,
                            BOOL                      isAnimated) {
    
    XCTAssertEqualObjects(weakSelf.navCon, theNavigationController);
    if(theViewController == weakSelf.vc) {
      XCTAssertEqualObjects(weakSelf.vc, theViewController);
    }
    else {
      XCTAssertEqualObjects(weakSelf.navCon.viewControllers.firstObject, theViewController);
      XCTAssertFalse(isAnimated);
    }
    
    didAssert = YES;
    
    
  };
  
  [self.navCon SH_setDidShowViewControllerBlock:self.block];
  [self.navCon pushViewController:self.vc animated:YES];
  [tester waitForTimeInterval:1];
  [tester waitForViewWithAccessibilityLabel:@"second"];
  XCTAssertTrue(didAssert);
  
  didAssert = NO;
  
  [self.navCon popToRootViewControllerAnimated:NO];
  [tester waitForViewWithAccessibilityLabel:@"first"];
  XCTAssertTrue(didAssert);
  
  
}
@end
