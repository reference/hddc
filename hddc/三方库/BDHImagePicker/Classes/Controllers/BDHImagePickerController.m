/**
 MIT License
 
 Copyright (c) 2018 Scott Ban (https://github.com/reference/BDToolKit)
 
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
#import "BDHImagePickerController.h"
#import "BDHAlbumTableViewController.h"
#import "BDHImageFlowViewController.h"
#import "BDHImagePickerHelper.h"

NSString *kBDHImagePickerStoredGroupKey = @"com.dennis.kBDHImagePickerStoredGroup";


@interface BDHImagePickerController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id<UINavigationControllerDelegate> navDelegate;
@property (nonatomic, assign) BOOL isDuringPushAnimation;

@end

@implementation BDHImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.delegate) {
        self.delegate = self;
    }
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    NSString *propwetyID = [[NSUserDefaults standardUserDefaults] objectForKey:kBDHImagePickerStoredGroupKey];

    if (propwetyID.length <= 0) {
        [self showAlbumList];
    } else {
        [self showImageFlow];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - priviate methods
- (void)showAlbumList {
    BDHAlbumTableViewController *albumTableViewController = [[BDHAlbumTableViewController alloc] init];
    [self setViewControllers:@[albumTableViewController]];
}

- (void)showImageFlow {
    NSString *albumIdentifier = [BDHImagePickerHelper albumIdentifier];
    BDHAlbumTableViewController *albumTableViewController = [[BDHAlbumTableViewController alloc] init];
    BDHImageFlowViewController *imageFlowController = [[BDHImageFlowViewController alloc] initWithAlbumIdentifier:albumIdentifier];
    [self setViewControllers:@[albumTableViewController,imageFlowController]];
}

- (void)chargeAuthorizationStatus:(BDHAlbumAuthorizationStatus)status {
    if (!self.viewControllers.firstObject) {
        [self showAlbumList];
    }

    BDHAlbumTableViewController *albumTableViewController = self.viewControllers.firstObject;

    switch (status) {
        case BDHAlbumAuthorizationStatusAuthorized:
            // TODO:Authorized
            break;
        case BDHAlbumAuthorizationStatusDenied:
        case BDHAlbumAuthorizationStatusRestricted:
            [albumTableViewController showUnAuthorizedTipsView];
            break;
        case BDHAlbumAuthorizationStatusNotDetermined:
            // TODO: requestAuthorization
            break;
            
        default:
            break;
    }
}

#pragma mark - UINavigationController

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    [super setDelegate:delegate ? self : nil];
    self.navDelegate = delegate != self ? delegate : nil;
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated __attribute__((objc_requires_super))
{
    self.isDuringPushAnimation = YES;
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    self.isDuringPushAnimation = NO;
    if ([self.navDelegate respondsToSelector:_cmd]) {
        [self.navDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return [self.viewControllers count] > 1 && !self.isDuringPushAnimation;
    } else {
        return YES;
    }
}

#pragma mark - Delegate Forwarder

- (BOOL)respondsToSelector:(SEL)s {
    return [super respondsToSelector:s] || [self.navDelegate respondsToSelector:s];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)s {
    return [super methodSignatureForSelector:s] ?: [(id)self.navDelegate methodSignatureForSelector:s];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    id delegate = self.navDelegate;
    if ([delegate respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:delegate];
    }
}

@end
