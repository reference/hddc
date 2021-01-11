//
//  YXAppInfomationModel.m
//  BDGuPiao
//
//  Created by admin on 2020/12/12.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXAppInfomationModel.h"

@implementation YXAppInfomationModel

+ (void)requestInfomationWithUserId:(NSString *)uid taskId:(NSString *)tid projectId:(NSString *)pid type:(NSInteger)type completion:(void(^)(NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/hddc/hddcAppForminfo", YX_HOST];
    [YXHTTP requestWithURL:url
                    params:@{@"userId":uid,@"taskId":tid,@"projectId":pid,@"type":@(type)}
                      body:nil
             responseClass:StandardHTTPResponse.class
         responseDataClass:@{@"data":self.class}
           completion:^(id responseObject, NSError *error) {
                if (completion) {
                    completion(error);
                }
           }];

}
@end
