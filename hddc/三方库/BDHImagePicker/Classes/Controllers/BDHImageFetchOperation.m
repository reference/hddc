/**
 MIT License
 
 Copyright (c) 2018 Scott Ban (https://github.com/reference/BDToolKit)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */
#import "BDHImageFetchOperation.h"
#import <Photos/PHAsset.h>
#import <Photos/PHImageManager.h>

typedef void(^DNImageResultHandler)(UIImage *image);

@interface BDHImageFetchOperation ()
@property (nonatomic, assign) PHImageRequestID requestID;
@property (nonatomic, assign) CGSize targetSize;
@property (nonatomic, assign) BOOL isHighQuality;
@property (nonatomic, copy) DNImageResultHandler resultHandler;
@end

@implementation BDHImageFetchOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)initWithAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        _asset = asset;
        _executing = NO;
        _finished = NO;
    }
    return self;
}

- (void)fetchImageWithTargetSize:(CGSize)size
                 needHighQuality:(BOOL)isHighQuality
               imageResutHandler:(void (^)(UIImage * _Nonnull))handler {
    self.targetSize = size;
    self.isHighQuality = isHighQuality;
    self.resultHandler = handler;
}

- (void)start {
    @synchronized (self) {
        if (self.isCancelled) {
            self.finished = YES;
            [self reset];
            return;
        }
        if (!self.asset) {
            self.finished = YES;
            [self reset];
            return;
        }
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        if (self.isHighQuality) {
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        } else {
            options.resizeMode = PHImageRequestOptionsResizeModeExact;
        }
        [[PHImageManager defaultManager] requestImageForAsset:self.asset targetSize:self.targetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.resultHandler) {
                    self.resultHandler(result);
                }
                [self done];
            });
        }];
        self.executing = YES;
    }
}

- (void)cancel {
    @synchronized (self) {
        if (self.isFinished) return;
        [super cancel];
        
        if (self.asset && self.requestID != PHInvalidImageRequestID) {
            [[PHCachingImageManager defaultManager] cancelImageRequest:self.requestID];
            if (self.isExecuting) self.executing = NO;
            if (!self.isFinished) self.finished = YES;
        }
        [self reset];
    }
}

- (void)done {
    self.finished = YES;
    self.executing = NO;
    [self reset];
}

- (void)reset {
    self.asset = nil;
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isConcurrent {
    return YES;
}


@end
