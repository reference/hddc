//
//  YXOSSModel.m
//  YunXiangAlive
//
//  Created by B-A-N on 2020/7/7.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXOSSModel.h"

@implementation YXOSSModel

+ (void)uploadImage:(UIImage *)img completion:(void(^)(NSString *url,NSError *error))completion
{
    NSString *url = [YX_HOST stringByAppendingString:@"/blade-resource/oss/endpoint/upload"];
    ZXHTTPFormData *data = [[ZXHTTPFormData alloc] initWithData:[img compressToData:1024 * 1024]
                                                           name:@"file"
                                                       fileName:@"avatar.png"
                                                       mimeType:@"image/png"];
    [YXHTTP uploadWithURL:url
                   params:nil
                     data:@[data]
            responseClass:StandardHTTPResponse.class
        responseDataClass:@{@"data":NSString.class}
                 progress:nil
               completion:^(id responseObject, NSError *error) {
                   if (completion) {
                       StandardHTTPResponse *response = responseObject;
                       completion(response.data, error);
                   }
               }];
}
@end
