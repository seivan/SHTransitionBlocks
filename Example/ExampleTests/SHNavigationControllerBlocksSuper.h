//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "KIF.h"
#import "SHTestCaseAdditions.h"
#import "SHNavigationControllerBlocks.h"




@interface SHNavigationControllerBlocksSuper : KIFTestCase

@property(nonatomic,strong) UIViewController           * vc;
@property(nonatomic,strong) UINavigationController     * navCon;
@property(nonatomic,copy)   SHNavigationControllerBlock block;
@end

