//
//  JGVersion.m
//  BuildingCollectSystem
//
//  Created by admin on 2021/5/28.
//  Copyright © 2021 Johnson. All rights reserved.
//

#import "JGVersion.h"

@implementation JGVersion

+ (void)requestVersion:(void(^)(JGVersion *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app/getVersion", YX_HOST];
    [YXHTTP requestWithURL:url
                    params:@{@"platform":@"ios"}
                      body:nil
             responseClass:StandardHTTPResponse.class
         responseDataClass:@{@"data":self.class}
           completion:^(id responseObject, NSError *error) {
                StandardHTTPResponse *resp = responseObject;
                if (completion) {
                    completion(resp.data,error);
                }
           }];
}
@end
