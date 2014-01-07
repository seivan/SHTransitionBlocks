//
//  SHNavigationControllerTransitionBlocksTests.m
//  Sample
//
//  Created by Seivan Heidari on 2014-01-02.
//  Copyright (c) 2014 Seivan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHTransitionBlocksTestsSuper.h"

@interface SHNavigationControllerTransitionBlocksTests : SHTransitionBlocksTestsSuper
<UINavigationControllerDelegate>
@end

@implementation SHNavigationControllerTransitionBlocksTests

-(void)beforeEach; {
  [super beforeEach];
  [UIApplication sharedApplication].keyWindow.rootViewController = self.navCon;
  [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];

}


-(id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC; {
  
  
  id<SHViewControllerAnimatedTransitioning> transition = [navigationController SH_animatedTransition];
  transition.reversed = NO;
  return transition;
  
}


#pragma mark - <UINavigationControllerDelegate>
-(void)testSHIntegrationWithPreparedAnimation; {
  
  

  __block BOOL isAnimatedAsserted = NO;
  
  self.navCon.delegate = self;
  
  NSTimeInterval timeInterval = 3.f;
  __weak typeof(self) weakSelf = self;
  

  
  __block void (^removeFirstVC)(void) = nil;
  [self.navCon SH_setAnimationDuration:timeInterval withPreparedTransitionBlock:^(UIView *containerView, UIViewController *fromVC, UIViewController *toVC, NSTimeInterval duration, id<SHViewControllerAnimatedTransitioning> transitionObject, SHTransitionAnimationCompletionBlock animationDidComplete) {
    isAnimatedAsserted = YES;
    XCTAssert(containerView);
    XCTAssertEqualObjects(weakSelf.navCon.viewControllers.firstObject, fromVC);
    XCTAssertEqualObjects(weakSelf.vc, toVC);
    XCTAssertEqual(timeInterval, duration);
    XCTAssertEqual(NO, transitionObject.isReversed);
    XCTAssert(transitionObject);
    XCTAssert(animationDidComplete);
    removeFirstVC = ^void(void) {
      [fromVC.view removeFromSuperview];
      animationDidComplete();
    };

    
  }];

  [self SH_waitForTimeInterval:1];
  [self.navCon pushViewController:self.vc animated:YES];

  [tester waitForViewWithAccessibilityLabel:@"first"];
  [tester waitForViewWithAccessibilityLabel:@"second"];
  removeFirstVC();
  [tester waitForAbsenceOfViewWithAccessibilityLabel:@"first"];

  XCTAssert(isAnimatedAsserted);

}


-(void)testSH_setAnimatedTransitionBlockIntegration; {
  __block BOOL isDurationAsserted = NO;
  __block BOOL isAnimatedAsserted = NO;
  
  self.navCon.delegate = self;
  
  NSTimeInterval timeInterval = 3.f;
  __weak typeof(self) weakSelf = self;
  [self.navCon SH_setDurationTransitionBlock:^NSTimeInterval(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    XCTAssert(transitionObject);
    XCTAssert(transitionObject.transitionContext);
    isDurationAsserted = YES;
    return timeInterval;
  }];
  
  
  
  __block void (^removeFirstVC)(void) = nil;
  [self.navCon SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    UIViewController * fromVC = [transitionObject.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionObject.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [weakSelf.navCon SH_blockDurationTransition](transitionObject);
    UIView  * containerView = [transitionObject.transitionContext containerView];
    isAnimatedAsserted = YES;
    XCTAssert(containerView);
    XCTAssertEqualObjects(weakSelf.navCon.viewControllers.firstObject, fromVC);
    XCTAssertEqualObjects(weakSelf.vc, toVC);
    XCTAssertEqual(timeInterval, duration);
    XCTAssertEqual(NO, self.navCon.SH_animatedTransition.isReversed);
    
    [containerView addSubview:toVC.view];
    
    removeFirstVC = ^void(void) {
      [fromVC.view removeFromSuperview];
      [transitionObject.transitionContext completeTransition:YES];
    };
    
    
  }];
  
  [self SH_waitForTimeInterval:1];
  [self.navCon pushViewController:self.vc animated:YES];
  
  [tester waitForViewWithAccessibilityLabel:@"first"];
  [tester waitForViewWithAccessibilityLabel:@"second"];
  removeFirstVC();
  [tester waitForAbsenceOfViewWithAccessibilityLabel:@"first"];
  
  XCTAssert(isDurationAsserted);
  XCTAssert(isAnimatedAsserted);

}


-(void)testSH_animatedTransition; {
  id<UIViewControllerAnimatedTransitioning> transition = nil;
  XCTAssertThrows([self.navCon SH_animatedTransition]);
  [self.navCon SH_setDurationTransitionBlock:^NSTimeInterval(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    return 5.f;
  }];
  XCTAssertThrows([self.navCon SH_animatedTransition]);
  
  [self.navCon SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    
  }];
  transition = [self.navCon SH_animatedTransition];
  XCTAssert(transition);
  XCTAssert([transition conformsToProtocol:@protocol(UIViewControllerAnimatedTransitioning)]);
  XCTAssert([transition conformsToProtocol:@protocol(SHViewControllerAnimatedTransitioning)]);
  XCTAssert([transition respondsToSelector:@selector(transitionDuration:)]);
  XCTAssert([transition respondsToSelector:@selector(animateTransition:)]);
  XCTAssert([transition respondsToSelector:@selector(setReversed:)]);
  XCTAssert([transition respondsToSelector:@selector(isReversed)]);
  
}

-(void)testSH_setAnimatedPreparedTransitionBlock; {
  __block BOOL isAsserted =NO;
  
  __weak typeof(self) weakSelf = self;
  [self.navCon SH_setAnimationDuration:0.5 withPreparedTransitionBlock:^(UIView *containerView, UIViewController *fromVC, UIViewController *toVC, NSTimeInterval duration, id<SHViewControllerAnimatedTransitioning> transitionObject, SHTransitionAnimationCompletionBlock animationDidComplete) {
    isAsserted = YES;
    XCTAssertNotNil(containerView);
    XCTAssertEqualObjects(fromVC, weakSelf.navCon.viewControllers.firstObject);
    XCTAssertEqualObjects(toVC, weakSelf.vc);
    XCTAssertEqual(0.5, duration);
    XCTAssertNil(transitionObject);
  }];
  [self.navCon SH_blockAnimationDurationWithPreparedTransition](UIView.new, self.navCon.viewControllers.firstObject, self.vc, 0.5, nil, nil);
  
  XCTAssert(isAsserted);
  
}

-(void)testSH_setAnimatedTransitionBlock; {
  __block BOOL isAsserted =NO;
  

  [self.navCon SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    isAsserted = YES;
    XCTAssertNil(transitionObject);
    XCTAssertNil(transitionObject.transitionContext);
  }];
  [self.navCon SH_blockAnimatedTransition](nil);
  
  XCTAssert(isAsserted);
  
}

-(void)testSH_setDurationTransitionBlock; {
  __block BOOL isAsserted =NO;
  

  [self.navCon SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    isAsserted = YES;
    XCTAssertNil(transitionObject);
    XCTAssertNil(transitionObject.transitionContext);
  }];
  [self.navCon SH_blockAnimatedTransition](nil);
  
  XCTAssert(isAsserted);
  
}


@end
