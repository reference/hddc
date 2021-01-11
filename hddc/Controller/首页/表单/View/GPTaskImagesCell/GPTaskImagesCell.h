//
//  GPTaskImagesCell.h
//  BDGuPiao
//
//  Created by admin on 2020/11/28.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <BDToolKit/BDToolKit.h>
#import "GPImageEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPTaskImagesCell : BDTableViewCell
//是否只是查看 如果只是查看则不要显示加号
@property (nonatomic, assign) InterfaceStatus interfaceStatus;
//
@property (nonatomic, strong) KKBaseViewController *inViewController;
//图片实体类
@property (nonatomic, strong) NSMutableArray <GPImageEntity *> *imageEntities;

/// 选择图片的时候回调
@property (nonatomic, copy) void (^onImageSelected) (void);

/// height
+ (CGFloat)heightForCellWithImageEntities:(NSArray *)imageEntities;

@end

NS_ASSUME_NONNULL_END
