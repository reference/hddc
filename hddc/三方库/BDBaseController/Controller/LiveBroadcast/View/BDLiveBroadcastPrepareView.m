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
#import "BDLiveBroadcastPrepareView.h"

@interface BDLiveBroadcastPrepareView()
@property (nonatomic, strong) IBOutlet UITextField *titleTextField;
@property (nonatomic, strong) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) IBOutlet UIButton *coverButton;
@property (nonatomic, strong) IBOutlet BDStackView *screenOrientationStackView;
@property (nonatomic, strong) IBOutlet UIButton *skuManageButton;
@property (nonatomic, strong) IBOutlet BDStackView *appointmentSwitcherStackView;
@property (nonatomic, strong) IBOutlet UIButton *appointmentTimerButton;
@property (nonatomic, strong) IBOutlet UIButton *startLiveBroadcastButton;
@property (nonatomic, strong) IBOutlet UIButton *protocolButton;
@property (nonatomic, strong) IBOutlet UILabel *skusLabel;
@end

@implementation BDLiveBroadcastPrepareView

- (void)awakeFromNib
{
    [super awakeFromNib];
    //适配X系列
    if (IS_PhoneXAll) {
        self.backBtn.topLayoutConstraint.constant = 60;
    }else{
        self.backBtn.topLayoutConstraint.constant = 20;
    }
}
@end
