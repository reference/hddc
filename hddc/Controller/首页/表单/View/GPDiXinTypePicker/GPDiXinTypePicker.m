//
//  GPDiXinTypePicker.m
//  BDGuPiao
//
//  Created by admin on 2020/12/12.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPDiXinTypePicker.h"

@interface GPDiXinTypePicker()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) IBOutlet UIPickerView *leftPicker;
@property (nonatomic, strong) IBOutlet UIPickerView *rightPicker;

@property (nonatomic, strong) NSArray *leftDataArray;
@property (nonatomic, strong) NSArray *rightDataArray;
@property (nonatomic, assign) NSInteger leftPickerSelectedIndex;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSDictionary *jsonDic;
@end

@implementation GPDiXinTypePicker

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.leftPickerSelectedIndex = 0;
    self.type = @"1";
    
    //==Json数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dixingType" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    self.jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingAllowFragments
                                                      error:nil];
    self.leftDataArray = [self.jsonDic allKeys];
    //
    self.rightDataArray = self.jsonDic[self.leftDataArray.firstObject];
    //
    self.leftPicker.delegate = self;
    self.leftPicker.dataSource = self;
    self.rightPicker.delegate = self;
    self.rightPicker.dataSource = self;
    
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
            self.onDone(self.type);
        }
    }
}

+ (id)popUpInController:(BDBaseViewController *)vc
{
    [vc.view endEditing:YES];
    BDTimePickerView *selector = [UINib viewForNib:NSStringFromClass(GPDiXinTypePicker.class)];
    selector.width = vc.view.width;
    [vc popView:selector position:Position_Bottom];
    return selector;
}

#pragma mark - delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.leftPicker) {
        return self.leftDataArray.count;
    }else{
        return self.rightDataArray.count;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.leftPicker) {
        return self.leftDataArray[row];
    }else{
        NSDictionary *dic = self.rightDataArray[row];
        return dic[@"name"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.leftPicker) {
        self.leftPickerSelectedIndex = row;
        self.rightDataArray = self.jsonDic[self.leftDataArray[row]];
        self.type = self.rightDataArray[0][@"id"];
        [self.rightPicker reloadAllComponents];
    }else{
        self.type = self.rightDataArray[row][@"id"];
    }
}
@end
