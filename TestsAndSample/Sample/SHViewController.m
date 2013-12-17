//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//



#import "SHViewController.h"
#import "MFMailComposeViewController+SHMessageUIBlocks.h"
#import "SHNavigationControllerBlocks.h"

@interface SHViewController ()
-(void)showEmail;
@end

@implementation SHViewController

-(void)viewDidLoad; {
  [super viewDidLoad];
  double delayInSeconds = 1.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self showEmail];
  });
  
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  
  
}
-(void)showEmail; {
  
  __weak typeof(self) weakSelf = self;
  __block BOOL composerCompleteTest = NO;
  __block BOOL willShowTest         = NO;
  __block BOOL didShowTest          = NO;
  
  MFMailComposeViewController * vc = [MFMailComposeViewController SH_mailComposeViewController];

  
  
  dispatch_group_t group = dispatch_group_create();
  
  dispatch_group_enter(group);
  
  [vc SH_setComposerCompletionBlock:^(MFMailComposeViewController *theController, MFMailComposeResult theResults, NSError *theError) {
    
    SHBlockAssert(theController, @"theController exists");
    SHBlockAssert(theController.isViewLoaded, @"theController should have its view loaded");
    
    __weak typeof(theController) weakController = theController;
    [theController dismissViewControllerAnimated:YES completion:^{
      SHBlockAssert(weakController == nil, @"theController should be gone");
      [weakSelf performSegueWithIdentifier:@"second" sender:nil];
    }];
    
    composerCompleteTest = YES;
    
    
    
    dispatch_group_leave(group);
  }];
  
  
  dispatch_group_enter(group);
  [vc SH_setWillShowViewControllerBlock:^(UINavigationController *theNavigationController, UIViewController *theViewController, BOOL isAnimated) {
    willShowTest = YES;
    dispatch_group_leave(group);
  }];
  
  
  dispatch_group_enter(group);
  [vc SH_setDidShowViewControllerBlock:^(UINavigationController *theNavigationController, UIViewController *theViewController, BOOL isAnimated) {
    didShowTest = YES;
    dispatch_group_leave(group);
  }];
  
  dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    SHBlockAssert(composerCompleteTest, @"Should call composerCompletionBlock");
    SHBlockAssert(willShowTest, @"Should call willShowViewControllerBLock");
    SHBlockAssert(didShowTest, @"Should call didShowViewControllerBLock");
    
  });
  
  [self presentViewController:vc animated:YES completion:nil];
  
  
}
@end
