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

typedef void(^BDWebImageAutoSizeCacheCompletionBlock)(BOOL result);

@interface BDWebImageAutoSizeCache : NSObject

/**
 * Return global shared cache instance
 *
 * @return BDWebImageAutoSizeCache global instance
 */
+(BDWebImageAutoSizeCache *)shardCache;

/**
 *  Store an imageSize into memory and disk cache at the given key.
 *
 *  @param image The image to store
 *  @param key   The unique imageSize cache key, usually it's image absolute URL
 *
 *  @return result
 */
-(BOOL)storeImageSize:(UIImage *)image forKey:(NSString *)key;

/**
 *  Store an imageSize into memory and disk cache at the given key.
 *
 *  @param image          The image to store
 *  @param key            The unique imageSize cache key, usually it's image absolute URL
 *  @param completedBlock An block that should be executed after the imageSize has been saved (optional)
 */
-(void)storeImageSize:(UIImage *)image forKey:(NSString *)key completed:(BDWebImageAutoSizeCacheCompletionBlock)completedBlock;

/**
 *  Query the disk cache synchronously after checking the memory cache
 *
 *  @param key  The unique key used to store the wanted imageSize
 *
 *  @return imageSize
 */
-(CGSize)imageSizeFromCacheForKey:(NSString *)key;

/**
 *  Store an reloadState into memory and disk cache at the given key.
 *
 *  @param state reloadState
 *  @param key   The unique reloadState cache key, usually it's image absolute URL
 *
 *  @return result
 */
-(BOOL)storeReloadState:(BOOL)state forKey:(NSString *)key;

/**
 *  Store an reloadState into memory and disk cache at the given key
 *
 *  @param state          reloadState
 *  @param key            The unique reloadState cache key, usually it's image absolute URL
 *  @param completedBlock An block that should be executed after the reloadState has been saved (optional)
 */
-(void)storeReloadState:(BOOL)state forKey:(NSString *)key completed:(BDWebImageAutoSizeCacheCompletionBlock)completedBlock;

/**
 *  Query the disk cache synchronously after checking the memory cache
 *
 *  @param key The unique key used to store the wanted reloadState
 *
 *  @return reloadState
 */
-(BOOL)reloadStateFromCacheForKey:(NSString *)key;

@end
