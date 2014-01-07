//
//  SHNavigationControllerTransitionBlocksTests.m
//  Sample
//
//  Created by Seivan Heidari on 2014-01-02.
//  Copyright (c) 2014 Seivan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHTransitionBlocksTestsSuper.h"

@interface SHViewControllerTransitionBlocksTests : SHTransitionBlocksTestsSuper
<UIViewControllerTransitioningDelegate>
@end

@implementation SHViewControllerTransitionBlocksTests

-(void)beforeEach; {
  [super beforeEach];
  self.vc.transitioningDelegate = self;
  [UIApplication sharedApplication].keyWindow.rootViewController = self.navCon;
  [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];

}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source; {
  id<SHViewControllerAnimatedTransitioning> transition = [presented SH_animatedTransition];
  transition.reversed = NO;
  return transition;

}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed; {
  id<SHViewControllerAnimatedTransitioning> transition = [dismissed SH_animatedTransition];
  transition.reversed = YES;
  return transition;
  
}

-(void)testSH_IntegrationWithPreparedAnimation; {
  __block BOOL isAnimatedAsserted = NO;
  NSTimeInterval timeInterval = 5.f;
  __weak typeof(self) weakSelf = self;

  __block BOOL isDismissed = NO;
  __block void (^removeFirstVC)(void) = nil;
  [self.vc SH_setAnimationDuration:timeInterval withPreparedTransitionBlock:^(UIView *containerView, UIViewController *fromVC, UIViewController *toVC, NSTimeInterval duration, id<SHViewControllerAnimatedTransitioning> transitionObject, SHTransitionAnimationCompletionBlock animationDidComplete) {

    isAnimatedAsserted = YES;
    if(transitionObject.isReversed){
      XCTAssert(containerView);
      XCTAssertEqualObjects(weakSelf.vc, fromVC);
      XCTAssertEqualObjects(weakSelf.navCon, toVC);
    }
    else {
      XCTAssert(containerView);
      XCTAssertEqualObjects(weakSelf.navCon, fromVC);
      XCTAssertEqualObjects(weakSelf.vc, toVC);
      
    }
    XCTAssertEqual(timeInterval, duration);
    XCTAssertEqual(isDismissed, transitionObject.isReversed);
    XCTAssert(transitionObject);
    XCTAssert(animationDidComplete);
    removeFirstVC = ^void(void) {
      [fromVC.view removeFromSuperview];
      animationDidComplete();
    };

    
  }];
  

  [self SH_waitForTimeInterval:1];
  [self.navCon presentViewController:self.vc animated:YES completion:nil];
  [self SH_waitForTimeInterval:1];
  XCTAssert(removeFirstVC);
  removeFirstVC();
  removeFirstVC = nil;
  [tester waitForAbsenceOfViewWithAccessibilityLabel:@"first"];
  isDismissed = YES;
  [self.vc dismissViewControllerAnimated:YES completion:nil];
  [self SH_waitForTimeInterval:1];
  XCTAssert(removeFirstVC);
  removeFirstVC();
  [tester waitForViewWithAccessibilityLabel:@"first"];
  XCTAssert(isAnimatedAsserted);

}


-(void)testSH_setAnimatedTransitionBlockIntegration; {
  __block BOOL isDurationAsserted = NO;
  __block BOOL isAnimatedAsserted = NO;
  

  
  NSTimeInterval timeInterval = 5.f;
  __weak typeof(self) weakSelf = self;
  [self.vc SH_setDurationTransitionBlock:^NSTimeInterval(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    XCTAssert(transitionObject);
    XCTAssert(transitionObject.transitionContext);
    isDurationAsserted = YES;
    return timeInterval;
  }];
  
  
  
  __block void (^removeFirstVC)(void) = nil;
  [self.vc SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    UIViewController * fromVC = [transitionObject.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionObject.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [weakSelf.vc SH_blockDurationTransition](transitionObject);
    UIView  * containerView = [transitionObject.transitionContext containerView];
    isAnimatedAsserted = YES;
    XCTAssert(containerView);
    XCTAssertEqualObjects(weakSelf.navCon, fromVC);
    XCTAssertEqualObjects(weakSelf.vc, toVC);
    XCTAssertEqual(timeInterval, duration);
    XCTAssertEqual(NO, transitionObject.isReversed);
    
    [containerView addSubview:toVC.view];
    
    removeFirstVC = ^void(void) {
      [fromVC.view removeFromSuperview];
      [transitionObject.transitionContext completeTransition:YES];
    };
    
    
  }];
  
  [self SH_waitForTimeInterval:1];
  [self.navCon presentViewController:self.vc animated:YES completion:nil];
  [self SH_waitForTimeInterval:1];
  removeFirstVC();
  [tester waitForAbsenceOfViewWithAccessibilityLabel:@"first"];
  
  XCTAssert(isDurationAsserted);
  XCTAssert(isAnimatedAsserted);

}


-(void)testSH_animatedTransition; {
  id<UIViewControllerAnimatedTransitioning> transition = nil;
  XCTAssertThrows([self.tabCon SH_animatedTransition]);
  [self.vc SH_setDurationTransitionBlock:^NSTimeInterval(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    return 5.f;
  }];
  XCTAssertThrows([self.tabCon SH_animatedTransition]);
  
  [self.vc SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    
  }];
  transition = [self.vc SH_animatedTransition];
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
  [self.vc SH_setAnimationDuration:0.5 withPreparedTransitionBlock:^(UIView *containerView, UIViewController *fromVC, UIViewController *toVC, NSTimeInterval duration, id<SHViewControllerAnimatedTransitioning> transitionObject, SHTransitionAnimationCompletionBlock animationDidComplete) {
    isAsserted = YES;
    XCTAssertNotNil(containerView);
    XCTAssertEqualObjects(fromVC, weakSelf.tabCon.viewControllers.firstObject);
    XCTAssertEqualObjects(toVC, weakSelf.vc);
    XCTAssertEqual(0.5, duration);
    XCTAssertNil(transitionObject);
  }];
  
  
  [self.vc SH_blockAnimationDurationWithPreparedTransition](UIView.new, self.tabCon.viewControllers.firstObject, self.vc, 0.5, nil, nil);
  
  XCTAssert(isAsserted);
  
}

-(void)testSH_setAnimatedTransitionBlock; {
  __block BOOL isAsserted =NO;
  

  [self.vc SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    isAsserted = YES;
    XCTAssertNil(transitionObject.transitionContext);
    XCTAssertNil(transitionObject);
  }];
  [self.vc SH_blockAnimatedTransition](nil);
  
  XCTAssert(isAsserted);
  
}

-(void)testSH_setDurationTransitionBlock; {
  __block BOOL isAsserted =NO;
  

  [self.vc SH_setAnimatedTransitionBlock:^(id<SHViewControllerAnimatedTransitioning> transitionObject) {
    isAsserted = YES;
    XCTAssertNil(transitionObject.transitionContext);
    XCTAssertNil(transitionObject);
  }];
  [self.vc SH_blockAnimatedTransition](nil);
  
  XCTAssert(isAsserted);
  
}


@end
