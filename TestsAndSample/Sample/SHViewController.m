//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//



#import "SHViewController.h"
#import "SHSecondViewController.h"
#import <SHTransitionBlocks.h>
#import  <SHNavigationControllerBlocks.h>

@interface SHViewController ()

@end

@implementation SHViewController

-(IBAction)unwinder:(UIStoryboardSegue *)sender; {
  
}
-(void)viewDidLoad; {
  [super viewDidLoad];

  [self.navigationController SH_setAnimationDuration:0.5 withPreparedTransitionBlock:^(UIView *containerView, UIViewController *fromVC, UIViewController *toVC, NSTimeInterval duration, id<SHViewControllerAnimatedTransitioning> transitionObject, SHTransitionAnimationCompletionBlock transitionDidComplete) {
    
    if (transitionObject.isReversed == NO) {
      toVC.view.layer.affineTransform = CGAffineTransformMakeTranslation(CGRectGetWidth(toVC.view.frame), 0);
    }
    else {
      toVC.view.layer.affineTransform = CGAffineTransformMakeTranslation(-CGRectGetWidth(toVC.view.frame), 0);
    }
    
    [UIView animateWithDuration:duration delay:0 options:kNilOptions  animations:^{
      toVC.view.layer.affineTransform = CGAffineTransformIdentity;
      
      if(transitionObject.isReversed) {
        CGAffineTransform t = CGAffineTransformIdentity;
        t = CGAffineTransformMakeTranslation(CGRectGetWidth(fromVC.view.frame), 0);
        //      fromView.layer.affineTransform = CGAffineTransformScale(t, 0.5, 0.5);
        fromVC.view.layer.affineTransform = t;
        
        
      }
      else {
        CGAffineTransform t = CGAffineTransformIdentity;
        t = CGAffineTransformMakeTranslation(-CGRectGetWidth(fromVC.view.frame), 0);
        fromVC.view.layer.affineTransform = t;
        
      }
      
      
    } completion:^(BOOL finished) {
      toVC.view.layer.affineTransform = CGAffineTransformIdentity;
      fromVC.view.layer.affineTransform = CGAffineTransformIdentity;
      transitionDidComplete();
    }];

  }];
  
  [self.navigationController SH_setInteractiveTransitionWithGestureBlock:^UIGestureRecognizer *(UIScreenEdgePanGestureRecognizer *edgeRecognizer) {
    edgeRecognizer.edges = UIRectEdgeLeft;
    return edgeRecognizer;
  } onGestureCallbackBlock:^void(UIViewController * controller, UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
    UIScreenEdgePanGestureRecognizer * recognizer = (UIScreenEdgePanGestureRecognizer*)sender;
    CGFloat progress = [recognizer translationInView:sender.view].x / (recognizer.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (state == UIGestureRecognizerStateBegan) {
      // Create a interactive transition and pop the view controller
      controller.SH_interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
      [(UINavigationController *)controller popViewControllerAnimated:YES];
    }
    else if (state == UIGestureRecognizerStateChanged) {
      // Update the interactive transition's progress
      [controller.SH_interactiveTransition updateInteractiveTransition:progress];
    }
    else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
      // Finish or cancel the interactive transition
      if (progress > 0.5) {
        [controller.SH_interactiveTransition finishInteractiveTransition];
      }
      else {
        [controller.SH_interactiveTransition cancelInteractiveTransition];
      }
      
      controller.SH_interactiveTransition = nil;
    }
  
  }];
  
  [self.navigationController SH_setAnimatedControllerBlock:^id<UIViewControllerAnimatedTransitioning>(UINavigationController *navigationController, UINavigationControllerOperation operation, UIViewController *fromVC, UIViewController *toVC) {
    navigationController.SH_animatedTransition.reversed = operation == UINavigationControllerOperationPop;
    return navigationController.SH_animatedTransition;
  }];
  
  [self.navigationController SH_setInteractiveControllerBlock:^id<UIViewControllerInteractiveTransitioning>(UINavigationController *navigationController, id<UIViewControllerAnimatedTransitioning> animationController) {
    return navigationController.SH_interactiveTransition;
  }];
}


-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  

}


  
  
  

@end
