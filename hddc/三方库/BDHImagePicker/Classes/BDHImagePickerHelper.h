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
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BDHAlbumAuthorizationStatus) {
    // User has not yet made a choice with regards to this application
    BDHAlbumAuthorizationStatusNotDetermined = 0,
    // This application is not authorized to access photo data.
    // The user cannot change this application’s status, possibly due to active restrictions
    // such as parental controls being in place.
    BDHAlbumAuthorizationStatusRestricted,
    // User has explicitly denied this application access to photos data.
    BDHAlbumAuthorizationStatusDenied,
    // User has authorized this application to access photos data.
    BDHAlbumAuthorizationStatusAuthorized
};

typedef NS_ENUM(NSUInteger, BDHImagePickerFitlerType) {
    BDHImagePickerFitlerTypeUnknown = 0,
    BDHImagePickerFitlerTypeImage   = 1,
    BDHImagePickerFitlerTypeVideo   = 2,
    BDHImagePickerFitlerTypeAudio   = 3,
};


@class BDHAlbum;
@class BDHAsset;

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXTERN NSString * const BDHImagePickerPhotoLibraryChangedNotification;
NS_CLASS_AVAILABLE_IOS(8.0) @interface BDHImagePickerHelper : NSObject

+ (instancetype)sharedHelper;


+ (void)cancelFetchWithAssets:(BDHAsset *)asset;

/**
 *  Returns information about your app’s authorization for accessing the user’s Photos library.
 The current authorization status. See `BDHAlbumAuthorizationStatus`.
 *
 *  @return The current authorization status.
 */
+ (BDHAlbumAuthorizationStatus)authorizationStatus;

/**
 *  Fetch the albumlist
 *
 */
+ (void)requestAlbumListWithCompleteHandler:(void(^)(NSArray<BDHAlbum *>* anblumList))competeHandler;

/**
 *  Fetch the album which is stored by identifier; if not stored, it'll return the album without anything.
 *
 *  @return the stored album
 */
+ (void)requestCurrentAblumWithCompleteHandler:(void(^)(BDHAlbum * album))completeHandler;


/**
 fetch images in the specific ablum
 
 @param album target album
 @param completeHandler callbacks with imageArray
 */
+ (void)fetchImageAssetsInAlbum:(BDHAlbum *)album completeHandler:(void(^)(NSArray<BDHAsset *>* imageArray))completeHandler;


+ (void)fetchImageSizeWithAsset:(BDHAsset *)asset
         imageSizeResultHandler:(void (^)(CGFloat imageSize, NSString * sizeString))handler;


/**
 fetch Image with assets
 
 @param asset target assets
 @param targetSize target size
 @param isHighQuality is need highQuality
 @param handler callback with image
 */
+ (void)fetchImageWithAsset:(BDHAsset *)asset
                 targetSize:(CGSize)targetSize
            needHighQuality:(BOOL)isHighQuality
          imageResutHandler:(void (^)(UIImage * image))handler;
/**
 fetch Image with assets
 same as `fetchImageWithAsset:targetSize:needHighQuality:imageResutHandler:` param `isHighQuality` is NO
 */
+ (void)fetchImageWithAsset:(BDHAsset *)asset
                 targetSize:(CGSize)targetSize
          imageResutHandler:(void (^)(UIImage *))handler;

// storeage
+ (void)saveAblumIdentifier:(NSString *)identifier;

+ (NSString *)albumIdentifier;


@end
NS_ASSUME_NONNULL_END
