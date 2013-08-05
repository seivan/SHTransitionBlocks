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
    
    STAssertEqualObjects(self.navCon, theNavigationController, nil);
    STAssertEqualObjects(self.navCon.viewControllers.SH_firstObject, theViewController, nil);
    STAssertTrue(isAnimated, nil);
    didAssert = YES;
    
  };

  [self.navCon SH_setWillShowViewControllerBlock:self.block];
  self.navCon.SH_blockWillShowViewController(self.navCon, self.navCon.viewControllers.SH_firstObject, YES);
  STAssertTrue(didAssert, nil);

}

-(void)testSH_setDidShowViewControllerBlock; {
  __block BOOL didAssert = NO;

  self.block        = ^void(UINavigationController * theNavigationController,
                            UIViewController       * theViewController,
                            BOOL                      isAnimated) {
    STAssertEqualObjects(self.navCon, theNavigationController, nil);
    STAssertEqualObjects(self.navCon.viewControllers.SH_firstObject, theViewController, nil);
    STAssertTrue(isAnimated, nil);
    didAssert = YES;
    
  };
  
  [self.navCon SH_setDidShowViewControllerBlock:self.block];
  self.navCon.SH_blockDidShowViewController(self.navCon, self.navCon.viewControllers.SH_firstObject, YES);
  STAssertTrue(didAssert, nil);
}

#pragma mark -
#pragma mark Getters

-(void)testSH_blockWillShowViewController; {
  STAssertNil(self.navCon.SH_blockWillShowViewController, nil);
  [self.navCon SH_setWillShowViewControllerBlock:self.block];
  STAssertEqualObjects(self.navCon.SH_blockWillShowViewController, self.block, nil);
  
}
-(void)testSH_blockDidShowViewController; {
  STAssertNil(self.navCon.SH_blockWillShowViewController, nil);
  [self.navCon SH_setWillShowViewControllerBlock:self.block];
  STAssertEqualObjects(self.navCon.SH_blockWillShowViewController, self.block, nil);
  
}


@end
