//
//  ViewController.m
//  CarAnimationDemo
//
//  Created by Sword on 02/12/2016.
//  Copyright © 2016 Baidu. All rights reserved.
//

#import "ViewController.h"
#import "ZHJCarAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGFloat loadingViewHeight = 100;
    CGFloat loadingViewWidth = 150;
    CGFloat marginY = (self.view.frame.size.height - loadingViewHeight) / 2;
    CGFloat marginX = (self.view.frame.size.width - loadingViewWidth) / 2;
    ZHJCarAnimationView *loadingView = [[ZHJCarAnimationView alloc] initWithFrame:CGRectMake(marginX, marginY, loadingViewWidth, loadingViewHeight)];
    [self.view addSubview:loadingView];
    [loadingView startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
