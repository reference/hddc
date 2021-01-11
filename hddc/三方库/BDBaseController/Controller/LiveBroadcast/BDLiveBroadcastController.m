/**
MIT License

Copyright (c) 2018 Scott Ban (https://github.com/reference/BDBaseController)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
#import "BDLiveBroadcastController.h"
#import "BDLiveBroadcastPrepareView.h"

@interface BDLiveBroadcastController ()
@property (nonatomic, strong) IBOutlet UIView *prepareViewHolder;
@end

@implementation BDLiveBroadcastController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    self.window.touchedBackgroundBlock = ^{
        @strongify(self)
        [self.window dismissViewAnimated:YES completion:nil];
    };
    
    BDLiveBroadcastPrepareView *prepareView = [UINib viewForNib:NSStringFromClass(BDLiveBroadcastPrepareView.class)];
    prepareView.frame = self.prepareViewHolder.bounds;
    [self.prepareViewHolder addSubview:prepareView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - 腾讯IM

- (void)setupTXIM
{
    //登录TXIM
}


@end
