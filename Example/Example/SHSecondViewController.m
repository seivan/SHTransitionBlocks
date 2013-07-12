//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/28/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"



@interface SHSecondViewController ()
-(void)showMessage;
@end

@implementation SHSecondViewController

-(void)viewDidAppear:(BOOL)animated; {
  self.view.backgroundColor = [UIColor blackColor];
  [self showMessage];
}

-(void)showMessage; {
  
}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

@end
