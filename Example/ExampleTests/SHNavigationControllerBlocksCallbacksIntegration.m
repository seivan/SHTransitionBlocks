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
  
  self.block        = ^void(UINavigationController * theNavigationController,
                            UIViewController       * theViewController,
                            BOOL                      isAnimated) {
    
    STAssertEqualObjects(self.navCon, theNavigationController, nil);
    if(theViewController == self.vc) {
      STAssertEqualObjects(self.vc, theViewController, nil);
    }
    else {
      STAssertEqualObjects(self.navCon.viewControllers.SH_firstObject, theViewController, nil);
      STAssertFalse(isAnimated, nil);
    }
    
    didAssert = YES;

    
  };
  
  [self.navCon SH_setWillShowViewControllerBlock:self.block];
  [self.navCon pushViewController:self.vc animated:YES];
  [tester waitForTimeInterval:1];
  [tester waitForViewWithAccessibilityLabel:@"second"];
  STAssertTrue(didAssert, nil);
  
  didAssert = NO;
  
  [self.navCon popToRootViewControllerAnimated:NO];
  [tester waitForViewWithAccessibilityLabel:@"first"];
  STAssertTrue(didAssert, nil);
  
  
}

-(void)testSH_setDidShowViewControllerBlock; {
  __block BOOL didAssert = NO;
  
  self.block        = ^void(UINavigationController * theNavigationController,
                            UIViewController       * theViewController,
                            BOOL                      isAnimated) {
    
    STAssertEqualObjects(self.navCon, theNavigationController, nil);
    if(theViewController == self.vc) {
      STAssertEqualObjects(self.vc, theViewController, nil);
    }
    else {
      STAssertEqualObjects(self.navCon.viewControllers.SH_firstObject, theViewController, nil);
      STAssertFalse(isAnimated, nil);
    }
    
    didAssert = YES;
    
    
  };
  
  [self.navCon SH_setDidShowViewControllerBlock:self.block];
  [self.navCon pushViewController:self.vc animated:YES];
  [tester waitForTimeInterval:1];
  [tester waitForViewWithAccessibilityLabel:@"second"];
  STAssertTrue(didAssert, nil);
  
  didAssert = NO;
  
  [self.navCon popToRootViewControllerAnimated:NO];
  [tester waitForViewWithAccessibilityLabel:@"first"];
  STAssertTrue(didAssert, nil);
  
  
}@end
