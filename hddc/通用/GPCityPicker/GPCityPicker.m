//
//  GPCityPicker.m
//  BDGuPiao
//
//  Created by admin on 2020/11/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPCityPicker.h"

@interface GPCityPicker()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) IBOutlet UIPickerView *leftPicker;
@property (nonatomic, strong) NSString *rootId;

@property (nonatomic, strong) NSMutableArray <GPAdministrativeDivisionsModel *> *leftDataArray;
@property (nonatomic, assign) NSInteger leftPickerSelectedIndex;

@end

@implementation GPCityPicker

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.leftDataArray = [NSMutableArray array];
    self.leftPickerSelectedIndex = 0;
}

- (IBAction)onButtons:(UIButton *)b
{
    if (b.tag == 0) {
        if (self.onCancel) {
            self.onCancel();
        }
    }
    else{
        if (self.onDone) {
            GPAdministrativeDivisionsModel *m = self.leftDataArray[self.leftPickerSelectedIndex];
            self.onDone(m);
        }
    }
}

- (void)setRootId:(NSString *)rootId
{
    _rootId = rootId;
    [self api_requestData];
}

+ (id)popUpInController:(BDBaseViewController *)vc rootId:(NSString *)rootId
{
    [vc.view endEditing:YES];
    GPCityPicker *selector = [UINib viewForNib:NSStringFromClass(GPCityPicker.class)];
    selector.width = vc.view.width;
    selector.rootId = rootId;
    [vc popView:selector position:Position_Bottom];
    return selector;
}

#pragma mark - api

- (void)api_requestData
{
    //检查缓存是否有该文件 没有就加载
    [GPAdministrativeDivisionsModel requestADWithId:_rootId completion:^(NSArray<GPAdministrativeDivisionsModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [self.leftDataArray setArray:ms];
            [self.leftPicker reloadAllComponents];
        }
    }];
}

#pragma mark - delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.leftDataArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    GPAdministrativeDivisionsModel *m = self.leftDataArray[row];
    return m.divisionName;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.leftPickerSelectedIndex = row;
}
@end
