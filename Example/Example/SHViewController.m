//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHSegueBlocks.h"
#import "SHViewController.h"
#import "SHBarButtonItemBlocks.h"
#import "SHMessageUIBlocks.h"
#import "UINavigationController+SHNavigationControllerBlocks.h"

@interface SHViewController ()
-(void)showEmail;
@end

@implementation SHViewController

-(void)viewDidLoad; {
  [super viewDidLoad];
  self.navigationItem.rightBarButtonItem = [UIBarButtonItem SH_barButtonItemWithBarButtonSystemItem:UIBarButtonSystemItemPlay withBlock:^(UIBarButtonItem *sender) {
    [self performSegueWithIdentifier:@"second" sender:nil];
  }];
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
  MFMailComposeViewController * vc = [MFMailComposeViewController SH_mailComposeViewController];
  [vc SH_setNavigationBlocks];
  [vc SH_setComposerCompletionBlock:^(MFMailComposeViewController *theController, MFMailComposeResult theResults, NSError *theError) {
    [theController dismissViewControllerAnimated:YES completion:nil];
    
  }];
  
  [vc SH_setWillShowViewControllerBlock:^(UINavigationController *theNavigationController, UIViewController *theViewController, BOOL isAnimated) {
    
  }];
  
  [vc SH_setDidShowViewControllerBlock:^(UINavigationController *theNavigationController, UIViewController *theViewController, BOOL isAnimated) {
    
  }];
  
  [self presentViewController:vc animated:YES completion:nil];
}
@end
