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
#import "BDBaseCollectionViewController.h"

@interface BDBaseCollectionViewController()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation BDBaseCollectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.window = [[ZXPopoverWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.presentedBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    //
    for (UITextField *t in self.textFields) {
        t.delegate = self;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //返回按钮
    if (self.navigationController && self != self.navigationController.viewControllers.firstObject)
    {
        UIImage *image = [self.backButtonImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(onBack:)]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - setter & getter

- (void)setDisplayNoDataView:(BOOL)displayNoDataView
{
    _displayNoDataView = displayNoDataView;
    if (_displayNoDataView) {
        //
        self.collectionView.emptyDataSetSource = self;
        self.collectionView.emptyDataSetDelegate = self;
    }
}

- (void)warning:(NSString *)text
{
    [FFToast showToastWithTitle:NSLocalizedString(@"温馨提示",nil) message:text iconImage:nil duration:2 toastType:FFToastTypeWarning];
}
- (void)error:(id)err
{
    if ([err isKindOfClass:NSError.class]) {
        NSError *e = err;
        [FFToast showToastWithTitle:NSLocalizedString(@"错误警告",nil) message:e.localizedDescription iconImage:nil duration:2 toastType:FFToastTypeError];
    }
    else {
        [FFToast showToastWithTitle:NSLocalizedString(@"错误警告",nil) message:err iconImage:nil duration:2 toastType:FFToastTypeError];
    }
}
- (void)info:(NSString *)text
{
    [FFToast showToastWithTitle:NSLocalizedString(@"信息内容",nil) message:text iconImage:nil duration:2 toastType:FFToastTypeInfo];
    
}
- (void)success:(NSString *)text
{
    [FFToast showToastWithTitle:NSLocalizedString(@"成功提示",nil) message:text iconImage:nil duration:2 toastType:FFToastTypeSuccess];
    
}

- (FFToast *)showActiveWithText:(NSString *)text
{
    FFToast *t = [[FFToast alloc] initToastWithTitle:text message:nil iconImage:nil];
    t.toastPosition = FFToastPositionCentreWithFillet;
    t.toastType = FFToastTypeDefault;
    [t show];
    return t;
}

- (void)dismissActiveToast:(FFToast *)t
{
    [t dismissCentreToast];
}

- (void)alertText:(NSString *)text
{
    if ([text isNotEmpty]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"确定", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil]];
        [self presentViewController:alert animated:YES completion:^{}];
    }
}

- (void)alertText:(NSString *)text sureTitle:(NSString *)sure sureAction:(void (^)(void))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:text preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil)
                                                        style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler();
        }
    }]];
    [self presentViewController:alert animated:YES completion:^{}];
}

- (void)alertText:(NSString *)text cancelTitle:(NSString *)cancel sureTitle:(NSString *)sure cancelAction:(void (^)(void))cancelHandle sureAction:(void (^)(void))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:text preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:sure.length?sure:@"确定"
                                                        style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler();
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:cancel.length?cancel:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelHandle) {
            cancelHandle();
        }
    }]];
    [self presentViewController:alert animated:YES completion:^{}];
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

- (void)pickImageFromAlbumWithCanEditImage:(BOOL)editable block:(BDAlbumPickBlock)block
{
    //初始化UIImagePickerController类
    UIImagePickerController * vc = [[UIImagePickerController alloc] init];
    vc.delegate = self;
    vc.allowsEditing = editable;
    
    //
    self.albumPickBlock = block;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"拍照", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        vc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:vc animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"相册", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        vc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:vc animated:YES completion:nil];
    }]];
    [self presentViewController:alert animated:YES completion:^{}];
}

//选择完成回调函数
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取图片
    if (self.albumPickBlock) {
        self.albumPickBlock(picker.allowsEditing ? info[UIImagePickerControllerEditedImage] : info[UIImagePickerControllerOriginalImage]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//用户取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyDone || textField.returnKeyType == UIReturnKeyGo || textField.returnKeyType == UIReturnKeySend) {
        [textField resignFirstResponder];
    }
    if (textField.returnKeyType == UIReturnKeyNext) {
        if ([self.textFields textFieldForTag:textField.tag+1]) {
            [[self.textFields textFieldForTag:textField.tag+1] becomeFirstResponder];
        }
    }
    return YES;
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.noDataImage;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.noDataText ? self.noDataText : NSLocalizedString(@"暂无数据", nil);
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

//judge
- (BOOL)passJudgeOfUITextField:(UITextField *)textField failureText:(NSString *)text
{
    if ([textField.text isEmpty]) {
        [textField shake];
        [self warning:text?[text localizedString]:[@"输入框不能为空" localizedString]];
        return NO;
    }
    return YES;
}

- (BOOL)passJudgeOfUITextView:(UITextView *)textView failureText:(NSString *)text
{
    if ([textView.text isEmpty]) {
        [self warning:text?[text localizedString]:[@"输入框不能为空" localizedString]];
        return NO;
    }
    return YES;
}

- (BOOL)passJudgeOfUILabel:(UILabel *)label failureText:(NSString *)text
{
    if ([label.text isEmpty]) {
        [self warning:text?[text localizedString]:[@"输入框不能为空" localizedString]];
        return NO;
    }
    return YES;
}

- (BOOL)passJudgeOfNSError:(NSError *)error
{
    if (error) {
        [self error:error];
        return NO;
    }return YES;
}
@end
