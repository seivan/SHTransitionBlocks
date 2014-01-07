//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "KIF.h"
#import "SHTestCaseAdditions.h"
#import <UIViewController+SHTransitionBlocks.h>

@interface SHTransitionBlocksTestsSuper : KIFTestCase

@property(nonatomic,strong) UIViewController           * vc;
@property(nonatomic,strong) UINavigationController     * navCon;
@property(nonatomic,strong) UITabBarController         * tabCon;

@end

