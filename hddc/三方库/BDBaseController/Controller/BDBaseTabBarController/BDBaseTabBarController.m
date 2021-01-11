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
#import "BDBaseTabBarController.h"

@interface BDBaseTabBarController ()

@end

@implementation BDBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - getter

- (ZXPopoverWindow *)window
{
    if (!_window) {
        _window = [[ZXPopoverWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.presentedBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    }
    return _window;
}


- (void)popView:(UIView *)view
{
    if (view) {
        //
        CGRect from = view.frame;
        from.origin.y = -self.window.frame.size.height;
        from.origin.x = (self.window.frame.size.width - from.size.width) / 2;
        CGRect to = from;
        to.origin.y = (self.window.frame.size.height - from.size.height) / 2;
        [self.window presentView:view from:from to:to animated:YES completion:nil];
    }
}

- (void)movePopedView:(UIView *)view toY:(CGFloat)y
{
    if (view) {
        [UIView animateWithDuration:0.5 animations:^{
            view.y = y;
        }];
    }
}

- (void)popView:(UIView *)view position:(Position)position
{
    if (view) {
        CGRect from = view.frame;
        from.origin.x = (self.window.frame.size.width - from.size.width) / 2;

        CGRect to = from;

        switch (position) {
            case Position_Top:
            {
                //
                from.origin.y = -self.window.frame.size.height;
                to.origin.y = 0;
            }
                break;
            case Position_Middle:
            {
                from.origin.y = -self.window.frame.size.height;
                to.origin.y = (self.window.frame.size.height - from.size.height) / 2;
            }
                break;
            case Position_Bottom:
            {
                //
                from.origin.y = self.window.frame.size.height;
                to.origin.y = self.window.frame.size.height - from.size.height;
            }
                break;
            default:
                break;
        }
        [self.window presentView:view from:from to:to animated:YES completion:nil];
    }
}

- (IBAction)onWindowDismiss:(id)sender
{
    [self.window dismissViewAnimated:YES completion:nil];
}

@end
