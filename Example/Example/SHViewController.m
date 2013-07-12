//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHSegueBlocks.h"
#import "SHViewController.h"
#import "SHAlertViewBlocks.h"
#import "SHBarButtonItemBlocks.h"


@interface SHViewController ()
-(void)popUpActionSheet;
@end

@implementation SHViewController

-(void)viewDidLoad; {
  [super viewDidLoad];
  self.navigationItem.rightBarButtonItem = [UIBarButtonItem SH_barButtonItemWithBarButtonSystemItem:UIBarButtonSystemItemPlay withBlock:^(UIBarButtonItem *sender) {
    [self performSegueWithIdentifier:@"second" sender:nil];
  }];

}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  [self popUpActionSheet];

}
-(void)popUpActionSheet; {
  __weak typeof(self) weakSelf = self;
  NSString * title = @"Sample";
  NSString * message = @"Sample message";
  __block NSUInteger selectedIndex = 0;
  UIAlertView * alert = [UIAlertView SH_alertViewWithTitle:title withMessage:message];
  SHBlockAssert(alert, @"Instance of a sheet");
  SHBlockAssert([alert.title isEqualToString:title], @"Title should be set");
  SHBlockAssert([alert.message isEqualToString:message], @"Message should be set");
  
  for (NSUInteger i = 0; i != 3; i++) {
    NSString * title = [NSString stringWithFormat:@"Button %d", i];
    [alert SH_addButtonWithTitle:title withBlock:^(NSUInteger theButtonIndex) {
      NSString * buttonTitle = [alert buttonTitleAtIndex:theButtonIndex];
      SHBlockAssert([title isEqualToString:buttonTitle], @"Button title is set");
      selectedIndex = theButtonIndex;
      double delayInSeconds = 0.2;
      dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
      dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf popUpActionSheet];
      });
      
    }];
  }
  
  
  NSUInteger cancelIndex      = 3;
  
  [alert SH_addButtonCancelWithTitle:@"Cancel" withBlock:^(NSUInteger theButtonIndex) {
    NSLog(@"Cancel");
    SHBlockAssert(theButtonIndex == cancelIndex ,
                  @"Cancel button index is 3");
    selectedIndex = theButtonIndex;
    
  }];
  
  SHBlockAssert(alert.cancelButtonIndex == cancelIndex ,
                @"Cancel button index is 3");
  
  
  SHBlockAssert(alert.SH_blockWillShow == nil, @"No SH_blockWillShow block");
  SHBlockAssert(alert.SH_blockDidShow == nil, @"No SH_blockDidShow block");
  SHBlockAssert(alert.SH_blockWillDismiss == nil, @"No SH_blockWillDismiss block");
  SHBlockAssert(alert.SH_blockDidDismiss == nil, @"No SH_blockDidDismiss block");
  

  [alert SH_setWillShowBlock:^(UIAlertView * theAlertView) {
    SHBlockAssert(theAlertView, @"Must pass the theAlertView for willShow");
  }];
  
  [alert SH_setDidShowBlock:^(UIAlertView * theAlertView) {
    SHBlockAssert(theAlertView, @"Must pass the theAlertView for didShow");
  }];
  
  [alert SH_setWillDismissBlock:^(UIAlertView * theAlertView, NSUInteger theButtonIndex) {
    SHBlockAssert(theAlertView, @"Must pass the theAlertView");
    SHBlockAssert(selectedIndex == theButtonIndex, @"Must pass selected index for willDismiss");
  }];
  
  [alert SH_setDidDismissBlock:^(UIAlertView * theAlertView, NSUInteger theButtonIndex) {
    SHBlockAssert(theAlertView, @"Must pass the theAlertView");
    SHBlockAssert(selectedIndex == theButtonIndex, @"Must pass selected index fordidDismiss");
  }];
  
  
  
  SHBlockAssert(alert.SH_blockWillShow, @"Must set SH_blockWillShow block");
  SHBlockAssert(alert.SH_blockDidShow, @"Must set SH_blockDidShow block");
  SHBlockAssert(alert.SH_blockWillDismiss, @"Must set SH_blockWillDismiss block");
  SHBlockAssert(alert.SH_blockDidDismiss, @"Must set SH_blockDidDismiss block");
  
  
  [alert show];
  
}
@end
