//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHNavigationControllerBlocksSuper.h"

@interface SHNavigationControllerBlocksCallbacks : SHNavigationControllerBlocksSuper
@property(nonatomic,assign) NSInteger isAsserted;
@end




@implementation SHNavigationControllerBlocksCallbacks


-(void)testSH_setWillShowViewControllerBlock; {
  __block BOOL didAssert = NO;

  self.block        = ^void(UINavigationController * theNavigationController,
                            UIViewController       * theViewController,
                            BOOL                      isAnimated) {
    
    XCTAssertEqualObjects(self.navCon, theNavigationController);
    XCTAssertEqualObjects(self.navCon.viewControllers.firstObject, theViewController);
    XCTAssertTrue(isAnimated);
    didAssert = YES;
    
  };

  [self.navCon SH_setWillShowViewControllerBlock:self.block];
  self.navCon.SH_blockWillShowViewController(self.navCon, self.navCon.viewControllers.firstObject, YES);
  XCTAssertTrue(didAssert);

}

-(void)testSH_setDidShowViewControllerBlock; {
  __block BOOL didAssert = NO;

  self.block        = ^void(UINavigationController * theNavigationController,
                            UIViewController       * theViewController,
                            BOOL                      isAnimated) {
    XCTAssertEqualObjects(self.navCon, theNavigationController);
    XCTAssertEqualObjects(self.navCon.viewControllers.firstObject, theViewController);
    XCTAssertTrue(isAnimated);
    didAssert = YES;
    
  };
  
  [self.navCon SH_setDidShowViewControllerBlock:self.block];
  self.navCon.SH_blockDidShowViewController(self.navCon, self.navCon.viewControllers.firstObject, YES);
  XCTAssertTrue(didAssert);
}

#pragma mark -
#pragma mark Getters

-(void)testSH_blockWillShowViewController; {
  XCTAssertNil(self.navCon.SH_blockWillShowViewController);
  [self.navCon SH_setWillShowViewControllerBlock:self.block];
  XCTAssertEqualObjects(self.navCon.SH_blockWillShowViewController, self.block);
  
}
-(void)testSH_blockDidShowViewController; {
  XCTAssertNil(self.navCon.SH_blockWillShowViewController);
  [self.navCon SH_setWillShowViewControllerBlock:self.block];
  XCTAssertEqualObjects(self.navCon.SH_blockWillShowViewController, self.block);
  
}


@end
