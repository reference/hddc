//
//  GPForumType.h
//  BDGuPiao
//
//  Created by admin on 2020/12/14.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  表单类型

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface GPForumType : NSObject

+ (NSString *)nameOfType:(NSInteger)type;
//英文
+ (NSString *)enNameOfType:(NSInteger)type;
+ (NSInteger)typeOfName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
