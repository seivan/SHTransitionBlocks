//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//



#import "SHNavigationControllerBlocksSuper.h"


@implementation SHTestedAnimationController
-(NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext; {
  return 0.3;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
-(void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext; {
  
}
@end

@implementation SHNavigationControllerBlocksSuper

-(void)setUp; {

  UIViewController * vc = UIViewController.new;
  UINavigationController * navCon = [[UINavigationController alloc]
                                     initWithRootViewController:vc];
  self.navCon = navCon;
  [UIApplication sharedApplication].keyWindow.rootViewController = self.navCon;
  [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];

  self.vc = UIViewController.new;
  UILabel * lblFirst  = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
  UILabel * lblSecond = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
  
  lblFirst.text  = @"first";
  [vc.view addSubview:lblFirst];
  lblSecond.text  = @"second";
  [self.vc.view addSubview:lblSecond];
  


  self.block        = ^void(UINavigationController * theNavigationController,
                            UIViewController       * theViewController,
                            BOOL                      isAnimated) {
    
  };
  
  

}
@end

