//
//  GPNormalPicker.m
//  BDGuPiao
//
//  Created by admin on 2020/11/30.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPNormalPicker.h"

@interface GPNormalPicker()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) IBOutlet UIPickerView *leftPicker;
@property (nonatomic, assign) NSInteger selctedIndex;
@end

@implementation GPNormalPicker

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selctedIndex = 0;
}

- (IBAction)onButtons:(UIButton *)b
{
    if (b.tag == 0) {
//        if (self.onCancel) {
//            self.onCancel();
//        }
        [self.viewController.window dismissViewAnimated:YES completion:nil];
    }
    else{
        [self.viewController.window dismissViewAnimated:YES completion:^{
            if (self.onDone) {
                self.onDone(self.dataArray[self.selctedIndex]);
            }
        }];
    }
}

+ (id)popUpInController:(BDBaseViewController *)vc dataArray:(NSArray*)dataArray
{
    [vc.view endEditing:YES];
    GPNormalPicker *selector = [UINib viewForNib:NSStringFromClass(GPNormalPicker.class)];
    selector.viewController = vc;
    selector.width = vc.view.width;
    selector.dataArray = dataArray;
    [vc popView:selector position:Position_Bottom];
    return selector;
}

#pragma mark - api

- (void)api_requestData
{
    //检查缓存是否有该文件 没有就加载
}

#pragma mark - delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    id data = self.dataArray[row];
    if ([data isKindOfClass:YXSlectionDictModel.class]) {
        return ((YXSlectionDictModel *)data).dictItemName;
    }else if ([data isKindOfClass:NSDictionary.class]) {
        return ((NSDictionary *)data)[@"name"];
    }else{
        return data;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selctedIndex = row;
}

@end
