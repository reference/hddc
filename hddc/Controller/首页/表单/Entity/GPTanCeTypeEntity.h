//
//  GPTanCeTypeEntity.h
//  BDGuPiao
//
//  Created by admin on 2020/12/12.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPTanCeTypeEntity : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;

- (GPTanCeTypeEntity *)ins;


/// 包括
+ (NSArray *)root;
+ (NSArray *)subType;
@end

NS_ASSUME_NONNULL_END
