//
//  GPMapLayerPicker.m
//  BDGuPiao
//
//  Created by admin on 2020/12/10.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPMapLayerPicker.h"

@implementation GPMapLayerPicker

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    
    self.iconL.image = __IMG(@"icon-layer-unselected");
    self.iconR.image = __IMG(@"icon-layer-unselected");
    if (_selectIndex == 0) {
        self.iconL.image = __IMG(@"icon-layer-selected");
    }else{
        self.iconR.image = __IMG(@"icon-layer-selected");
    }
    
    self.labelL.textColor = [UIColor darkGrayColor];
    self.labelR.textColor = [UIColor darkGrayColor];
    if (_selectIndex == 0) {
        self.labelL.textColor = [UIColor colorNamed:@"color_light_blue"];
    }else{
        self.labelR.textColor = [UIColor colorNamed:@"color_light_blue"];
    }
}

- (IBAction)onButtons:(UIButton *)btn
{
    self.selectIndex = btn.tag;
    if (self.selectedCallback) {
        self.selectedCallback(btn.tag);
    }
}

@end
