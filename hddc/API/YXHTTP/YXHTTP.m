//
//  ABHTTP.m
//  ActBers
//
//  Created by https://github.com/reference on 2019/6/18.
//  Copyright © 2019 com.kubo. All rights reserved.
//

#import "YXHTTP.h"

@implementation YXHTTP
+ (void)requestWithURL:(NSString *)url
                params:(NSDictionary *)params
                  body:(id)body
         responseClass:(Class)responseClass
     responseDataClass:(NSDictionary *)responseDataClass
            completion:(void(^)(id responseObject, NSError *error))completion {
    [YXHTTP requestWithURL:url params:params body:body completion:^(id responseObject, NSError *error) {
        id response = responseObject;
        if (response && responseClass && ![response isKindOfClass:UIImage.class]) {
            if ([response isKindOfClass:[NSArray class]]) {
                response = [NSArray yy_modelArrayWithClass:responseClass json:responseObject];
            } else {
                response = [responseClass yy_modelWithJSON:responseObject];
            }
            if (response) {
                NSArray *keys = [responseDataClass allKeys];
                for (NSString *key in keys) {
                    if ([response respondsToSelector:NSSelectorFromString(key)]) {
                        id data = [response valueForKey:key];
                        Class dataClass = [responseDataClass objectForKey:key];
                        if (data && dataClass) {
                            if ([data isKindOfClass:[NSArray class]]) {
                                data = [NSArray yy_modelArrayWithClass:dataClass json:data];
                            } else {
                                data = [dataClass yy_modelWithJSON:data];
                            }
                            if (data) {
                                [response setValue:data forKey:key];
                            }
                        }
                    }
                }
            }
        }
        if (completion) {
            completion(response, error);
        }
    }];
}

+ (void)putWithURL:(NSString *)url
                params:(NSDictionary *)params
                  body:(id)body
         responseClass:(Class)responseClass
     responseDataClass:(NSDictionary *)responseDataClass
            completion:(void(^)(id responseObject, NSError *error))completion {
    [YXHTTP putWithURL:url params:params body:body completion:^(id responseObject, NSError *error) {
        id response = responseObject;
        if (response && responseClass && ![response isKindOfClass:UIImage.class]) {
            if ([response isKindOfClass:[NSArray class]]) {
                response = [NSArray yy_modelArrayWithClass:responseClass json:responseObject];
            } else {
                response = [responseClass yy_modelWithJSON:responseObject];
            }
            if (response) {
                NSArray *keys = [responseDataClass allKeys];
                for (NSString *key in keys) {
                    if ([response respondsToSelector:NSSelectorFromString(key)]) {
                        id data = [response valueForKey:key];
                        Class dataClass = [responseDataClass objectForKey:key];
                        if (data && dataClass) {
                            if ([data isKindOfClass:[NSArray class]]) {
                                data = [NSArray yy_modelArrayWithClass:dataClass json:data];
                            } else {
                                data = [dataClass yy_modelWithJSON:data];
                            }
                            if (data) {
                                [response setValue:data forKey:key];
                            }
                        }
                    }
                }
            }
        }
        if (completion) {
            completion(response, error);
        }
    }];
}

+ (void)requestWithURL:(NSString *)url
                params:(NSDictionary *)params
                  body:(id)body
            completion:(void(^)(id responseObject, NSError *error))completion {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"application/json"];
        [contentTypes addObject:@"charset=UTF-8"];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = contentTypes;
    });
    NSString *query = AFQueryStringFromParameters(params);
    if ([query isNotEmpty] && ![url containsString:@"?"]) {
        url = [url stringByAppendingFormat:@"?%@", query];
    }
    
    if (body == nil) {
        //适配一个变态的返回请求 获取验证码 返回二进制图片文件
        if ([params.allKeys containsObject:@"contentType"]) {
            if ([params[@"contentType"] isEqualToString:@"image/*"]) {
                //
                //
                NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
                [contentTypes addObject:@"application/json"];
                [contentTypes addObject:@"charset=UTF-8"];
                [contentTypes addObject:@"text/html"];
                [contentTypes addObject:@"text/plain"];
                manager.responseSerializer.acceptableContentTypes = contentTypes;
//                manager.responseSerializer = [AFImageResponseSerializer serializer];
//                NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
//                [contentTypes addObject:@"image/jpeg"];
//                manager.responseSerializer.acceptableContentTypes = contentTypes;
            }
        }else{
            //reset very important
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            //
            NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
            [contentTypes addObject:@"application/json"];
            [contentTypes addObject:@"charset=UTF-8"];
            [contentTypes addObject:@"text/html"];
            [contentTypes addObject:@"text/plain"];
            manager.responseSerializer.acceptableContentTypes = contentTypes;
        }
        
        //header
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"ios"];
        
        [manager GET:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLogD(@"GET %@\nParams:%@\nResponse:%@", url, [params yy_modelToJSONObject], [responseObject yy_modelToJSONObject]);
            if ([responseObject isKindOfClass:UIImage.class]) {
                if (completion) {
                    completion(responseObject, nil);
                }
            }
            else if ([responseObject[@"code"] integerValue] != 200) {
                if (completion) {
                    NSString *msg = responseObject[@"msg"];
                    NSError *err = [NSError errorWithDomain:@"HTTP" code:[responseObject[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey:msg?msg:@""}];
                    completion(nil, err);
                }
            }
            else{
                if (completion) {
                    completion(responseObject, nil);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLogA(@"GET %@\n%@", url, error.localizedDescription);
            if (completion) {
                completion(task.response, error);
            }
        }];
    } else {
        //reset very important
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"application/json"];
        [contentTypes addObject:@"charset=UTF-8"];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = contentTypes;
        
        // JSON
        if ([JSONObject isValidJSONObject:body]) {
            //header
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"ios"];
            
            params = body;
        } else { // params in body
            //header
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"ios"];

            if ([body isKindOfClass:NSData.class]) {
                params = [JSONObject JSONObjectWithData:body];
            } else if ([body isKindOfClass:NSString.class]) {
                params = [JSONObject JSONObjectWithString:body];
            }
            if (params == nil) {
                params = body;
            }
        }
        //
        [manager POST:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLogD(@"POST %@\nPARAMS:%@\nRESPONSE:%@", url, [params yy_modelToJSONObject], [responseObject yy_modelToJSONObject]);
            if ([responseObject[@"code"] integerValue] != 200) {
                if (completion) {
                    NSError *err = [NSError errorWithDomain:@"HTTP" code:[responseObject[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey:responseObject[@"message"]}];
                    completion(nil, err);
                }
            }
            else{
                if (completion) {
                    completion(responseObject, nil);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLogA(@"POST %@\n%@", url, error.localizedDescription);
            if (completion) {
                completion(task.response, error);
            }
        }];
    }
}

+ (void)putWithURL:(NSString *)url
                params:(NSDictionary *)params
                  body:(id)body
            completion:(void(^)(id responseObject, NSError *error))completion
{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"application/json"];
        [contentTypes addObject:@"charset=UTF-8"];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = contentTypes;
    });
    NSString *query = AFQueryStringFromParameters(params);
    if ([query isNotEmpty] && ![url containsString:@"?"]) {
        url = [url stringByAppendingFormat:@"?%@", query];
    }
    
    if (body == nil) {
        //适配一个变态的返回请求 获取验证码 返回二进制图片文件
        if ([params.allKeys containsObject:@"contentType"]) {
            if ([params[@"contentType"] isEqualToString:@"image/*"]) {
                //
                //
                NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
                [contentTypes addObject:@"application/json"];
                [contentTypes addObject:@"charset=UTF-8"];
                [contentTypes addObject:@"text/html"];
                [contentTypes addObject:@"text/plain"];
                manager.responseSerializer.acceptableContentTypes = contentTypes;
//                manager.responseSerializer = [AFImageResponseSerializer serializer];
//                NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
//                [contentTypes addObject:@"image/jpeg"];
//                manager.responseSerializer.acceptableContentTypes = contentTypes;
            }
        }else{
            //reset very important
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            //
            NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
            [contentTypes addObject:@"application/json"];
            [contentTypes addObject:@"charset=UTF-8"];
            [contentTypes addObject:@"text/html"];
            [contentTypes addObject:@"text/plain"];
            manager.responseSerializer.acceptableContentTypes = contentTypes;
        }
        
        //header
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"ios"];
        
        [manager GET:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLogD(@"GET %@\nParams:%@\nResponse:%@", url, [params yy_modelToJSONObject], [responseObject yy_modelToJSONObject]);
            if ([responseObject isKindOfClass:UIImage.class]) {
                if (completion) {
                    completion(responseObject, nil);
                }
            }
            else if ([responseObject[@"code"] integerValue] != 200) {
                if (completion) {
                    NSString *msg = responseObject[@"msg"];
                    NSError *err = [NSError errorWithDomain:@"HTTP" code:[responseObject[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey:msg?msg:@""}];
                    completion(nil, err);
                }
            }
            else{
                if (completion) {
                    completion(responseObject, nil);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLogA(@"GET %@\n%@", url, error.localizedDescription);
            if (completion) {
                completion(task.response, error);
            }
        }];
    } else {
        //reset very important
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"application/json"];
        [contentTypes addObject:@"charset=UTF-8"];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = contentTypes;
        
        // JSON
        if ([JSONObject isValidJSONObject:body]) {
            //header
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"ios"];
            
            params = body;
        } else { // params in body
            //header
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"ios"];

            if ([body isKindOfClass:NSData.class]) {
                params = [JSONObject JSONObjectWithData:body];
            } else if ([body isKindOfClass:NSString.class]) {
                params = [JSONObject JSONObjectWithString:body];
            }
            if (params == nil) {
                params = body;
            }
        }
        //
        [manager PUT:url parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLogD(@"POST %@\nPARAMS:%@\nRESPONSE:%@", url, [params yy_modelToJSONObject], [responseObject yy_modelToJSONObject]);
            if ([responseObject[@"code"] integerValue] != 200) {
                if (completion) {
                    NSError *err = [NSError errorWithDomain:@"HTTP" code:[responseObject[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey:responseObject[@"message"]}];
                    completion(nil, err);
                }
            }
            else{
                if (completion) {
                    completion(responseObject, nil);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLogA(@"POST %@\n%@", url, error.localizedDescription);
            if (completion) {
                completion(task.response, error);
            }
        }];
    }
}

+ (void)uploadWithURL:(NSString *)url params:(NSDictionary *)params data:(NSArray<ZXHTTPFormData *> *)data responseClass:(Class)responseClass completion:(void (^)(id, NSError *))completion {
    [ZXHTTPClient POST:url params:params formData:data requestHandler:^(NSMutableURLRequest *request) {
        //
//        [request setValue:vAuthorization forHTTPHeaderField:@"Authorization"];
//        [request setValue:vTenantId forHTTPHeaderField:@"tenantId"];

//        if ([YXUserModel isLogin]) {
//            [request setValue:[@"bearer " stringByAppendingString:YXUserModel.currentUser.access_token] forHTTPHeaderField:@"Blade-Auth"];
//        }
        
    } completionHandler:^(NSURLSessionDataTask *task, NSData *data, NSError *error) {
        id response = task.response;
        if (data && responseClass) {
            if ([response isKindOfClass:[NSArray class]]) {
                response = [NSArray yy_modelArrayWithClass:responseClass json:data];
            } else {
                response = [responseClass yy_modelWithJSON:data];
            }
        }
        if (completion) {
            completion(response, error);
        }
    }];
}

+ (void)uploadWithURL:(NSString *)url
               params:(NSDictionary *)params
                 data:(NSArray<ZXHTTPFormData *> *)data
        responseClass:(Class)responseClass
    responseDataClass:(NSDictionary *)responseDataClass
             progress:(void(^)(NSProgress *progress))progressCallback
           completion:(void(^)(id responseObject, NSError *error))completion
{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];

        //
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"application/json"];
        [contentTypes addObject:@"charset=UTF-8"];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = contentTypes;
    });
    
    //header
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //post
    [manager POST:url parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"data %@",data);
        [formData appendPartWithFileData:data.lastObject.data name:data.lastObject.name fileName:data.lastObject.fileName mimeType:data.lastObject.mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressCallback) {
            progressCallback(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 返回结果
        NSLogD(@"POST %@\nPARAMS:%@\nRESPONSE:%@", url, [params yy_modelToJSONObject], [responseObject yy_modelToJSONObject]);
        NSDictionary *respObj = responseObject;
        if (![respObj.allKeys containsObject:@"data"]) {
            responseObject = @{@"success":@(YES),@"message":[NSNull null],@"data":responseObject,@"code":@(200)};
        }
        if (![responseObject[@"success"] boolValue]) {
            if ([responseObject[@"code"] integerValue] == 401) {
                //token 过期
                [[NSNotificationCenter defaultCenter] postNotificationName:BDTokenNotificationExpired object:nil];
                
//                [YXUserModel logout];
            }
            if (completion) {
                completion(nil, [NSError errorWithDomain:@"HTTP" code:[responseObject[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey:responseObject[@"message"]}]);
            }
        }
        else{
            id response = responseObject;
            if (response && responseClass) {
                if ([response isKindOfClass:[NSArray class]]) {
                    response = [NSArray yy_modelArrayWithClass:responseClass json:responseObject];
                } else {
                    response = [responseClass yy_modelWithJSON:responseObject];
                }
                if (response) {
                    NSArray *keys = [responseDataClass allKeys];
                    for (NSString *key in keys) {
                        if ([response respondsToSelector:NSSelectorFromString(key)]) {
                            id data = [response valueForKey:key];
                            Class dataClass = [responseDataClass objectForKey:key];
                            if (data && dataClass) {
                                if ([data isKindOfClass:[NSArray class]]) {
                                    data = [NSArray yy_modelArrayWithClass:dataClass json:data];
                                } else {
                                    data = [dataClass yy_modelWithJSON:data];
                                }
                                if (data) {
                                    [response setValue:data forKey:key];
                                }
                            }
                        }
                    }
                }
            }
            if (completion) {
                completion(response, nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLogA(@"POST %@\n%@", url, error.localizedDescription);
        if (completion) {
            completion(task.response, error);
        }
    }];
}

+ (void)uploadWithURL:(NSString *)url
               params:(NSDictionary *)params
        withFilePaths:(NSArray <GPImageEntity *> *)imgArr
        responseClass:(Class)responseClass
    responseDataClass:(NSDictionary *)responseDataClass
             progress:(void(^)(NSProgress *progress))progressCallback
           completion:(void(^)(id responseObject, NSError *error))completion
{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] init];
    });
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (GPImageEntity *imgEntity in imgArr) {
            NSString *filePath = [NSFileManager documentFile:imgEntity.identifier];
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            if (data.length) {
                NSString *fileName = imgEntity.identifier;
                [formData appendPartWithFileData:data name:@"multipartFiles" fileName:fileName mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *json = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",json);
        StandardHTTPResponse *resp = [StandardHTTPResponse yy_modelWithJSON:json];
        if (completion) {
            completion(resp, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (completion) {
            completion(nil, error);
        }
    }];
}

+ (void)uploadWithURL:(NSString *)url
               params:(NSDictionary *)params
           localPaths:(NSArray *)localPaths
             progress:(void(^)(NSProgress *progress))progressCallback
           completion:(void(^)(id responseObject, NSError *error))completion
{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] init];
    });
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString *path in localPaths) {
            NSString *filePath = [NSFileManager documentFile:path];
            NSData *data = [NSData dataWithContentsOfFile:filePath];

            if (data.length) {
                NSString *fileName = path;
                [formData appendPartWithFileData:data name:@"multipartFiles" fileName:fileName mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *json = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",json);
        StandardHTTPResponse *resp = [StandardHTTPResponse yy_modelWithJSON:json];
        if (completion) {
            completion(resp, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (completion) {
            completion(nil, error);
        }
    }];
}


@end
