//
//  GPTanCeTypeEntity.m
//  BDGuPiao
//
//  Created by admin on 2020/12/12.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPTanCeTypeEntity.h"

@implementation GPTanCeTypeEntity

- (GPTanCeTypeEntity *)ins
{
    static dispatch_once_t onceToken;
    static GPTanCeTypeEntity *s = nil;
    dispatch_once(&onceToken, ^{
        s = [GPTanCeTypeEntity new];
    });
    return s;
}

- (NSArray *)root
{
    return @[
                @{
                    @"区域调查":@[
                                    @{
                                        @"id":@"1",
                                        @"name":@"地质调查规划路线-线"
                                    },
                                    @{
                                        @"id":@"2",
                                        @"name":@"地质调查规划点-点"
                                    }
                    ]
                },
                @{},
                @{},
                @{},
            ];
}

@end
