//
//  GPMapLayerPicker.h
//  BDGuPiao
//
//  Created by admin on 2020/12/10.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <BDToolKit/BDToolKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPMapLayerPicker : BDView
@property (nonatomic, strong) IBOutlet UIImageView *iconL;
@property (nonatomic, strong) IBOutlet UIImageView *iconR;
@property (nonatomic, strong) IBOutlet UILabel *labelL;
@property (nonatomic, strong) IBOutlet UILabel *labelR;

@property (nonatomic, copy) void (^selectedCallback) (NSInteger index);
@property (nonatomic, assign) NSInteger selectIndex;
@end

NS_ASSUME_NONNULL_END
