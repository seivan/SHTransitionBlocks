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


@interface SHViewController ()
-(void)showEmail;
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
  [self showEmail];

}
-(void)showEmail; {
  MFMailComposeViewController * vc = [MFMailComposeViewController SH_mailComposeViewController];
  [vc SH_setCompletionBlock:^(MFMailComposeViewController *theController, MFMailComposeResult theResults, NSError *theError) {
    
  }];
  [self presentViewController:vc animated:YES completion:nil];
}
@end
