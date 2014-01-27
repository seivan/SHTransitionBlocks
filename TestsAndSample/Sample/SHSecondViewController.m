//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/28/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"

@interface SHSecondViewController ()

@end

@implementation SHSecondViewController

-(void)viewDidLoad; {
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self performSegueWithIdentifier:@"push" sender:nil];
  });
  
}

  
  


-(IBAction)didTapButton:(id)sender; {

}

@end
