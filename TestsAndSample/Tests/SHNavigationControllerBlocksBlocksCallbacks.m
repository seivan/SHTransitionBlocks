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

  __weak typeof(self) weakSelf = self;
  self.block        = ^void(UINavigationController * theNavigationController,
                            UIViewController       * theViewController,
                            BOOL                      isAnimated) {
    
    XCTAssertEqualObjects(weakSelf.navCon, theNavigationController);
    XCTAssertEqualObjects(weakSelf.navCon.viewControllers.firstObject, theViewController);
    XCTAssertTrue(isAnimated);
    didAssert = YES;
    
  };

  [self.navCon SH_setWillShowViewControllerBlock:self.block];
  self.navCon.SH_blockWillShowViewController(self.navCon, self.navCon.viewControllers.firstObject, YES);
  XCTAssertTrue(didAssert);

}

-(void)testSH_setDidShowViewControllerBlock; {
  __block BOOL didAssert = NO;
  __weak typeof(self) weakSelf = self;
  self.block        = ^void(UINavigationController * theNavigationController,
                            UIViewController       * theViewController,
                            BOOL                      isAnimated) {
    XCTAssertEqualObjects(weakSelf.navCon, theNavigationController);
    XCTAssertEqualObjects(weakSelf.navCon.viewControllers.firstObject, theViewController);
    XCTAssertTrue(isAnimated);
    didAssert = YES;
    
  };
  
  [self.navCon SH_setDidShowViewControllerBlock:self.block];
  self.navCon.SH_blockDidShowViewController(self.navCon, self.navCon.viewControllers.firstObject, YES);
  XCTAssertTrue(didAssert);
}

-(void)testSH_setPreferredInterfaceOrientationForPresentatationBlock; {
  __block BOOL didAssert = NO;
  
  __weak typeof(self) weakSelf = self;
  [self.navCon SH_setPreferredInterfaceOrientationForPresentatationBlock:^UIInterfaceOrientation(UINavigationController *navigationController) {
    didAssert = YES;
    XCTAssertEqualObjects(navigationController, weakSelf.navCon);
    return UIInterfaceOrientationPortrait;
  }];
  UIInterfaceOrientation orientation = self.navCon.SH_blockInterfaceOrientationForPresentation(self.navCon);
  XCTAssertEqual(UIInterfaceOrientationPortrait, orientation);
  XCTAssertTrue(didAssert);
  
}
-(void)testSH_setInteractiveTransitioningBlock; {
  __block BOOL didAssert = NO;
  
  __weak typeof(self) weakSelf = self;
  [self.navCon SH_setInteractiveTransitioningBlock:^id<UIViewControllerInteractiveTransitioning>(UINavigationController *navigationController, id<UIViewControllerAnimatedTransitioning> animationController) {
    XCTAssertEqualObjects(weakSelf.navCon, navigationController);
    didAssert = YES;
    return UIPercentDrivenInteractiveTransition.new;

  }];
  UIPercentDrivenInteractiveTransition * percentTrans = self.navCon.SH_blockInteractiveTransitioning(self.navCon, nil);
  XCTAssert(percentTrans);
  XCTAssertEqualObjects([percentTrans class], [UIPercentDrivenInteractiveTransition class]);
  XCTAssertTrue(didAssert);
}

-(void)testSH_setAnimatedTransitioningBlock; {
  __block BOOL didAssert = NO;
  
  __weak typeof(self) weakSelf = self;
  SHTestedAnimationController  * animation = SHTestedAnimationController.new;
  [self.navCon SH_setAnimatedTransitioningBlock:^id<UIViewControllerAnimatedTransitioning>(UINavigationController *navigationController, UINavigationControllerOperation operation, UIViewController *fromVC, UIViewController *toVC) {

    XCTAssertEqualObjects(weakSelf.navCon, navigationController);
    XCTAssertEqual(UINavigationControllerOperationPush, operation);
    XCTAssertEqualObjects(weakSelf.navCon.viewControllers.firstObject, fromVC);
    XCTAssertEqualObjects(weakSelf.vc, toVC);
    didAssert = YES;
    return animation;
  }];
  id<UIViewControllerAnimatedTransitioning> animatedTrans = self.navCon.SH_blockAnimatedTransitioning(self.navCon, UINavigationControllerOperationPush, self.navCon.viewControllers.firstObject, self.vc);
  XCTAssert(animatedTrans);
  XCTAssertEqualObjects(animation, animatedTrans);
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
