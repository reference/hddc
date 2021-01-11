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
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UITableView+BDWebImageAutoSize.h"
#import "UICollectionView+BDWebImageAutoSize.h"
#import "BDWebImageAutoSizeCache.h"

@interface BDWebImageAutoSize : NSObject

/**
 *   Get image height
 *
 *  @param url            imageURL
 *  @param layoutWidth    layoutWidth
 *  @param estimateHeight estimateHeight(default 100)
 *
 *  @return imageHeight
 */
+(CGFloat)imageHeightForURL:(NSURL *)url layoutWidth:(CGFloat)layoutWidth estimateHeight:(CGFloat )estimateHeight;

/**
 *  Get image size from cache,query the disk cache synchronously after checking the memory cache
 *
 *  @param url imageURL
 *
 *  @return imageSize
 */
+(CGSize )imageSizeFromCacheForURL:(NSURL *)url;

/**
 *  Store an imageSize into memory and disk cache
 *
 *  @param image          image
 *  @param url            imageURL
 *  @param completedBlock An block that should be executed after the imageSize has been saved (optional)
 */
+(void)storeImageSize:(UIImage *)image forURL:(NSURL *)url completed:(BDWebImageAutoSizeCacheCompletionBlock)completedBlock;

/**
 *  Get reload state from cache,query the disk cache synchronously after checking the memory cache
 *
 *  @param url imageURL
 *
 *  @return reloadState
 */
+(BOOL)reloadStateFromCacheForURL:(NSURL *)url;

/**
 *  Store an reloadState into memory and disk cache
 *
 *  @param state          reloadState
 *  @param url            imageURL
 *  @param completedBlock An block that should be executed after the reloadState has been saved (optional)
 */
+(void)storeReloadState:(BOOL)state forURL:(NSURL *)url completed:(BDWebImageAutoSizeCacheCompletionBlock)completedBlock;

@end


