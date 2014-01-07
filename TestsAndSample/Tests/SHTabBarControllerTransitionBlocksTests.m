//
//  SHNavigationControllerTransitionBlocksTests.m
//  Sample
//
//  Created by Seivan Heidari on 2014-01-02.
//  Copyright (c) 2014 Seivan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHTransitionBlocksTestsSuper.h"

@interface SHTabBarControllerTransitionBlocksTests : SHTransitionBlocksTestsSuper
<UITabBarControllerDelegate>
@end

@implementation SHTabBarControllerTransitionBlocksTests

-(void)beforeEach; {
  [super beforeEach];
  self.tabCon.viewControllers = @[self.navCon,self.vc];
  self.tabCon.delegate = self;
  [UIApplication sharedApplication].keyWindow.rootViewController = self.tabCon;
  [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];

}

-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC; {
  id<SHViewControllerAnimatedTransitioning> transition = [tabBarController SH_animatedTransition];
  transition.reversed = NO;
  return transition;
  
}

-(void)testSHIntegrationWithPreparedAnimation; {
  __block BOOL isAnimatedAsserted = NO;
  NSTimeInterval timeInterval = 5.f;
  __weak typeof(self) weakSelf = self;

  __block void (^removeFirstVC)(void) = nil;
  [self.tabCon SH_setAnimationDuration:timeInterval withPreparedTransitionBlock:^(UIView *containerView, UIViewController *fromVC, UIViewController *toVC, NSTimeInterval duration, id<SHViewControllerAnimatedTransitioning> transitionObject, SHViewControllerAnimationCompletionBlock animationDidComplete) {

    isAnimatedAsserted = YES;
    XCTAssert(containerView);
    XCTAssertEqualObjects(weakSelf.tabCon.viewControllers.firstObject, fromVC);
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
  self.tabCon.selectedIndex = 1;
  [self SH_waitForTimeInterval:1];
  removeFirstVC();
  [tester waitForAbsenceOfViewWithAccessibilityLabel:@"first"];

  XCTAssert(isAnimatedAsserted);

}


-(void)testSH_setAnimatedTransitionBlockIntegration; {
  __block BOOL isDurationAsserted = NO;
  __block BOOL isAnimatedAsserted = NO;
  

  
  NSTimeInterval timeInterval = 5.f;
  __weak typeof(self) weakSelf = self;
  [self.tabCon SH_setDurationTransitionBlock:^NSTimeInterval(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    XCTAssert(transitionObject);
    XCTAssert(transitionObject.transitionContext);
    isDurationAsserted = YES;
    return timeInterval;
  }];
  
  
  
  __block void (^removeFirstVC)(void) = nil;
  [self.tabCon SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    UIViewController * fromVC = [transitionObject.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionObject.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [weakSelf.tabCon SH_blockDurationTransition](transitionObject);
    UIView  * containerView = [transitionObject.transitionContext containerView];
    isAnimatedAsserted = YES;
    XCTAssert(containerView);
    XCTAssertEqualObjects(weakSelf.tabCon.viewControllers.firstObject, fromVC);
    XCTAssertEqualObjects(weakSelf.vc, toVC);
    XCTAssertEqual(timeInterval, duration);
    XCTAssertEqual(NO, self.tabCon.SH_animatedTransition.isReversed);
    
    [containerView addSubview:toVC.view];
    
    removeFirstVC = ^void(void) {
      [fromVC.view removeFromSuperview];
      [transitionObject.transitionContext completeTransition:YES];
    };
    
    
  }];
  
  [self SH_waitForTimeInterval:1];
  self.tabCon.selectedIndex = 1;
  [self SH_waitForTimeInterval:1];
  removeFirstVC();
  [tester waitForAbsenceOfViewWithAccessibilityLabel:@"first"];
  
  XCTAssert(isDurationAsserted);
  XCTAssert(isAnimatedAsserted);

}


-(void)testSH_animatedTransition; {
  id<UIViewControllerAnimatedTransitioning> transition = nil;
  XCTAssertThrows([self.tabCon SH_animatedTransition]);
  [self.tabCon SH_setDurationTransitionBlock:^NSTimeInterval(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    return 5.f;
  }];
  XCTAssertThrows([self.tabCon SH_animatedTransition]);
  
  [self.tabCon SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    
  }];
  transition = [self.tabCon SH_animatedTransition];
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
  [self.tabCon SH_setAnimationDuration:0.5 withPreparedTransitionBlock:^(UIView *containerView, UIViewController *fromVC, UIViewController *toVC, NSTimeInterval duration, id<SHViewControllerAnimatedTransitioning> transitionObject, SHViewControllerAnimationCompletionBlock animationDidComplete) {
    isAsserted = YES;
    XCTAssertNotNil(containerView);
    XCTAssertEqualObjects(fromVC, weakSelf.tabCon.viewControllers.firstObject);
    XCTAssertEqualObjects(toVC, weakSelf.vc);
    XCTAssertEqual(0.5, duration);
    XCTAssertNil(transitionObject);
  }];
  
  
  [self.tabCon SH_blockAnimationDurationWithPreparedTransition](UIView.new, self.tabCon.viewControllers.firstObject, self.vc, 0.5, nil, nil);
  
  XCTAssert(isAsserted);
  
}

-(void)testSH_setAnimatedTransitionBlock; {
  __block BOOL isAsserted =NO;
  

  [self.tabCon SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    isAsserted = YES;
    XCTAssertNil(transitionObject);
    XCTAssertNil(transitionObject.transitionContext);
  }];
  [self.tabCon SH_blockAnimatedTransition](nil);
  
  XCTAssert(isAsserted);
  
}

-(void)testSH_setDurationTransitionBlock; {
  __block BOOL isAsserted =NO;
  

  [self.tabCon SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    isAsserted = YES;
    XCTAssertNil(transitionObject);
    XCTAssertNil(transitionObject.transitionContext);
  }];
  [self.tabCon SH_blockAnimatedTransition](nil);
  
  XCTAssert(isAsserted);
  
}


@end
