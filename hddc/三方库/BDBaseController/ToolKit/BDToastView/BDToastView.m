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
#import "BDToastView.h"

@implementation BDToastView

+ (void)showActivity:(NSString *)text inView:(UIView *)view {
    ZXToastView *toastView = [[ZXToastView alloc] initWithActivity:text];
    toastView.duration = 1.5;
    toastView.effectStyle = UIBlurEffectStyleDark;
    toastView.textLabel.textColor = [UIColor whiteColor];
    toastView.activityView.color = [UIColor whiteColor];
    [toastView showInView:view];
}

+ (void)showText:(NSString *)text inView:(UIView *)view {
    ZXToastView *toastView = [[ZXToastView alloc] initWithText:text];
    toastView.duration = 1.5;
    toastView.effectStyle = UIBlurEffectStyleDark;
    toastView.textLabel.textColor = [UIColor whiteColor];
    [toastView showInView:view];
}

+ (void)showActivity:(NSString *)text {
    [self showActivity:text inView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showText:(NSString *)text {
    [self showText:text inView:[UIApplication sharedApplication].keyWindow];
}

+ (void)dismiss {
    [ZXToastView hideAllToast];
}

@end
