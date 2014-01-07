//
//  SHNavigationControllerTransitionBlocksTests.m
//  Sample
//
//  Created by Seivan Heidari on 2014-01-02.
//  Copyright (c) 2014 Seivan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHTransitionBlocksTestsSuper.h"

@interface SHInteractiveTransitionBlocksTests : SHTransitionBlocksTestsSuper
<UINavigationControllerDelegate>
@end

@implementation SHInteractiveTransitionBlocksTests

-(void)beforeEach; {
  [super beforeEach];
  
  [UIApplication sharedApplication].keyWindow.rootViewController = self.navCon;
  [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
  self.navCon.delegate = self;

}


-(id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC; {
  
  
  id<SHViewControllerAnimatedTransitioning> transition = [navigationController SH_animatedTransition];
  transition.reversed = NO;
  return transition;
  
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController; {
  return self.navCon.SH_interactiveTransition;
}


#pragma mark - <UINavigationControllerDelegate>
-(void)testCreateInteractionTransition; {
  
  __weak typeof(self) weakSelf = self;

  NSTimeInterval timeInterval = 3.f;

  
  __block BOOL isInteractedAsserted = NO;
  [self.navCon SH_setInteractiveTransitionWithGestureBlock:^UIGestureRecognizer *(UIScreenEdgePanGestureRecognizer *edgeRecognizer) {
    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc] init];
    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    return recognizer;
  } onGestureCallbackBlock:^void(UIViewController * controller, UIGestureRecognizer *recognizer, UIGestureRecognizerState state, CGPoint location) {
    isInteractedAsserted = YES;
    weakSelf.navCon.SH_interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    [weakSelf.navCon popViewControllerAnimated:YES];

  }];
  
  [self.navCon SH_setAnimationDuration:timeInterval withPreparedTransitionBlock:^(UIView *containerView, UIViewController *fromVC, UIViewController *toVC, NSTimeInterval duration, id<SHViewControllerAnimatedTransitioning> transitionObject, SHViewControllerAnimationCompletionBlock animationDidComplete) {
    [UIView animateWithDuration:duration animations:^{
      
    } completion:^(BOOL finished) {
      animationDidComplete();
    }];
  }];

  [self SH_waitForTimeInterval:1];
  [self.navCon pushViewController:self.vc animated:YES];
  [tester waitForViewWithAccessibilityLabel:@"first"];
  [tester waitForViewWithAccessibilityLabel:@"second"];
  [self SH_waitForTimeInterval:3];
  [tester swipeViewWithAccessibilityLabel:@"second" inDirection:KIFSwipeDirectionLeft];
  [self SH_waitForTimeInterval:5];
  XCTAssert(isInteractedAsserted);
  XCTAssert(self.navCon.SH_interactiveTransition);
  self.navCon.SH_interactiveTransition = nil;
  XCTAssertNil(self.navCon.SH_interactiveTransition);
}



@end
