//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//



#import "SHNavigationControllerBlocksSuper.h"



@implementation SHNavigationControllerBlocksSuper

-(void)setUp; {
  UIViewController * vc = UIViewController.new;
  UINavigationController * navCon = [[UINavigationController alloc] initWithRootViewController:vc];
  self.navCon = navCon;
  [UIApplication sharedApplication].keyWindow.rootViewController = vc;

  self.block        = ^void(UINavigationController * theNavigationController,
                            UIViewController       * theViewController,
                            BOOL                      isAnimated) {
    
  };
  

}
@end

