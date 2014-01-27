//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//



#import "SHTransitionBlocksTestsSuper.h"



@implementation SHTransitionBlocksTestsSuper

-(void)beforeEach; {
  self.vc = UIViewController.new;
  UIViewController * vc = UIViewController.new;
  UINavigationController * navCon = [[UINavigationController alloc]
                                     initWithRootViewController:vc];
  self.navCon = navCon;
  self.tabCon = [[UITabBarController alloc] init];


  UILabel * lblFirst  = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
  UILabel * lblSecond = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
  
  lblFirst.text  = @"first";
  [vc.view addSubview:lblFirst];
  lblSecond.text  = @"second";
  [self.vc.view addSubview:lblSecond];



}


@end

