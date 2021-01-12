//
//  GPFileZhiPaiPicker.h
//  hddc
//
//  Created by admin on 2021/1/11.
//

#import <BDToolKit/BDToolKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPFileZhiPaiPicker : BDView
@property (nonatomic, copy) void (^onCancel) (void);
@property (nonatomic, copy) void (^onSaveLocal) (YXProject *project,YXTaskModel *task);
@property (nonatomic, copy) void (^onSubmit) (YXProject *project,YXTaskModel *task);
@end

NS_ASSUME_NONNULL_END
