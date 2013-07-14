//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/28/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHNavigationControllerBlocks.h"
#import "MFMessageComposeViewController+SHMessageUIBlocks.h"

@interface SHSecondViewController ()
-(void)showMessage;
@end

@implementation SHSecondViewController

-(void)viewDidLoad; {
  [super viewDidLoad];
  double delayInSeconds = 1.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self showMessage];
  });
}

-(void)showMessage; {
  
  __block BOOL composerCompleteTest = NO;
  __block BOOL willShowTest         = NO;
  __block BOOL didShowTest          = NO;
  
  
  
  MFMessageComposeViewController * vc = [MFMessageComposeViewController SH_messageComposeViewController];

  
  
  dispatch_semaphore_t semaphoreComposerComplete =  dispatch_semaphore_create(0);
  dispatch_semaphore_t semaphoreWillShow         =  dispatch_semaphore_create(0);
  dispatch_semaphore_t semaphoreDidShow        =  dispatch_semaphore_create(0);
  
  
  [vc SH_setComposerCompletionBlock:^(MFMessageComposeViewController *theController, MessageComposeResult theResults) {
    
    SHBlockAssert(theController, @"theController exists");
    SHBlockAssert(theController.isViewLoaded, @"theController should have its view loaded");
    
    __weak typeof(theController) weakController = theController;
    [theController dismissViewControllerAnimated:YES completion:^{
      SHBlockAssert(weakController == nil, @"theController should be gone");
    }];
    
    composerCompleteTest = YES;
    dispatch_semaphore_signal(semaphoreComposerComplete);
  }];
  
  
  
  [vc SH_setWillShowViewControllerBlock:^(UINavigationController *theNavigationController, UIViewController *theViewController, BOOL isAnimated) {
    willShowTest = YES;
    dispatch_semaphore_signal(semaphoreWillShow);
  }];
  
  
  
  [vc SH_setDidShowViewControllerBlock:^(UINavigationController *theNavigationController, UIViewController *theViewController, BOOL isAnimated) {
    didShowTest = YES;
    dispatch_semaphore_signal(semaphoreDidShow);
  }];
  
  [self presentViewController:vc animated:YES completion:nil];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    dispatch_semaphore_wait(semaphoreComposerComplete, DISPATCH_TIME_FOREVER);
    SHBlockAssert(composerCompleteTest, @"Should call composerCompletionBlock");
    
    dispatch_semaphore_wait(semaphoreWillShow, DISPATCH_TIME_FOREVER);
    SHBlockAssert(willShowTest, @"Should call willShowViewControllerBLock");
    
    dispatch_semaphore_wait(semaphoreDidShow, DISPATCH_TIME_FOREVER);
    SHBlockAssert(didShowTest, @"Should call didShowViewControllerBLock");
    
  });
  
  
  
  
}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

@end
