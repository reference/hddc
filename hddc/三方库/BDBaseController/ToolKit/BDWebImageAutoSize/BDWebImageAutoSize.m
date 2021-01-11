/**
MIT License

Copyright (c) 2018 Scott Ban (https://github.com/reference/BDBaseController)

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
#import "BDWebImageAutoSize.h"

static CGFloat const estimateDefaultHeight = 100;

@implementation BDWebImageAutoSize

+(CGFloat)imageHeightForURL:(NSURL *)url layoutWidth:(CGFloat)layoutWidth estimateHeight:(CGFloat )estimateHeight{
    
    CGFloat showHeight = estimateDefaultHeight;
    if(estimateHeight) showHeight = estimateHeight;
    if(!url || !layoutWidth) return showHeight;
    CGSize size = [self imageSizeFromCacheForURL:url];
    CGFloat imgWidth = size.width;
    CGFloat imgHeight = size.height;
    if(imgWidth>0 && imgHeight >0)
    {
        showHeight = layoutWidth/imgWidth*imgHeight;
    }
    return showHeight;
}
+(void)storeImageSize:(UIImage *)image forURL:(NSURL *)url completed:(BDWebImageAutoSizeCacheCompletionBlock)completedBlock{
    
    [[BDWebImageAutoSizeCache shardCache] storeImageSize:image forKey:[self cacheKeyForURL:url] completed:completedBlock];
    
}
+(void)storeReloadState:(BOOL)state forURL:(NSURL *)url completed:(BDWebImageAutoSizeCacheCompletionBlock)completedBlock{

    [[BDWebImageAutoSizeCache shardCache] storeReloadState:state forKey:[self cacheKeyForURL:url] completed:completedBlock];
     
}
+(CGSize )imageSizeFromCacheForURL:(NSURL *)url{

    return [[BDWebImageAutoSizeCache shardCache] imageSizeFromCacheForKey:[self cacheKeyForURL:url]];
    
}

+(BOOL)reloadStateFromCacheForURL:(NSURL *)url{

  return [[BDWebImageAutoSizeCache shardCache] reloadStateFromCacheForKey:[self cacheKeyForURL:url]];
    
}
#pragma mark - BDWebImageAutoSize (private)

+(NSString *)cacheKeyForURL:(NSURL *)url{
    
    return [url absoluteString];
}

@end
