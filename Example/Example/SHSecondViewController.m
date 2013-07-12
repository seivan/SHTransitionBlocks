//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/28/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHAlertViewBlocks.h"


@interface SHSecondViewController ()
-(void)popUpAlert;
-(void)popUpAlertAgain;
@end

@implementation SHSecondViewController

-(void)viewDidAppear:(BOOL)animated; {
  self.view.backgroundColor = [UIColor blackColor];
  [self popUpAlert];
}

-(void)popUpAlertAgain; {
  UIAlertView * alert = [UIAlertView SH_alertViewWithTitle:@"New Title" andMessage:@"Message" buttonTitles:@[@"First"] cancelTitle:@"Cancel" withBlock:^(NSUInteger theButtonIndex) {
    SHBlockAssert(theButtonIndex >= 0, @"Button Index is more or equal to 0");
  }];
  alert.alertViewStyle = UIAlertViewStylePlainTextInput;
  [alert SH_addButtonWithTitle:@"Second" withBlock:nil];
  SHBlockAssert(alert.numberOfButtons == 3 , @"Must have 3 buttons");
  SHBlockAssert(alert.SH_blockForCancelButton != nil , @"Cancel has a block");
  SHBlockAssert(alert.cancelButtonIndex == 0 , @"Cancel index is 0");
  
  SHBlockAssert(alert.SH_blockFirstButtonEnabled == nil, @"No block for SH_blockFirstButtonEnabled");
  [alert SH_setFirstButtonEnabled:^BOOL(UIAlertView *theAlertView) {
    SHBlockAssert(theAlertView, @"Must pass theAlertView");
    NSUInteger random = arc4random() % 5;
    return random == 1;
  }];
  SHBlockAssert(alert.SH_blockFirstButtonEnabled, @"Must have block for SH_blockFirstButtonEnabled");
  [alert show];
}

-(void)popUpAlert; {
  NSString * title = @"Sample";
  
  __weak typeof(self) weakSelf = self;
  
  UIAlertView * alert = [UIAlertView SH_alertViewWithTitle:title withMessage:nil];
  SHBlockAssert(alert, @"Instance of a sheet");
  SHBlockAssert([alert.title isEqualToString:title], @"Title should be set");
  SHBlockAssert(alert.message == nil, @"Title should be set");
  
  SHAlertViewBlock block = ^(NSUInteger theButtonIndex) {
    SHBlockAssert(theButtonIndex >= 0, @"Must have a buttonIndex");
    [weakSelf popUpAlertAgain];
  };
  
  [alert addButtonWithTitle:@"Button 0"];
  [alert addButtonWithTitle:@"Button 1"];
  [alert addButtonWithTitle:@"Button 2"];
  SHBlockAssert([alert SH_blockForButtonIndex:0] == nil, @"Button Index 0 has no block");
  SHBlockAssert([alert SH_blockForButtonIndex:1] == nil, @"Button Index 1 has no block");
  SHBlockAssert([alert SH_blockForButtonIndex:2] == nil, @"Button Index 1 has no block");
  
  [alert SH_setButtonBlockForIndex:0 withBlock:block];
  [alert SH_setButtonBlockForIndex:1 withBlock:block];
  [alert SH_setButtonBlockForIndex:2 withBlock:block];
  
  [alert SH_addButtonWithTitle:@"Block button" withBlock:block];
  
  SHBlockAssert([alert SH_blockForButtonIndex:2] == block, @"Button Index 4 has a block");
  
  [alert addButtonWithTitle:@"Cancel"];
  
  alert.cancelButtonIndex = 4;
  [alert SH_setButtonCancelBlock:block];

  SHBlockAssert([alert SH_blockForButtonIndex:4] == [alert SH_blockForCancelButton],
                @"Button Index 5 should be equal to SH_blockForCancel");
  
  SHBlockAssert([alert SH_blockForCancelButton] == block,
                @"Button Index 5 should be equal to SH_blockForCancel");
  
  [alert addButtonWithTitle:@"Weird button"];
  
  
  [alert show];
  
}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

@end
