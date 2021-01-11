//
//  GPTempLaunchController.m
//  BDGuPiao
//
//  Created by admin on 2020/12/8.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPTempLaunchController.h"

@interface GPTempLaunchController ()
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *indicatorView;
@end

@implementation GPTempLaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.indicatorView startAnimating];
}

//加载
@end
