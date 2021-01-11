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
#import <Photos/Photos.h>
#import "BDHImagePickerHelper.h"
#import "BDHImageFetchOperation.h"
#import "BDHAlbum.h"
#import "BDHAsset.h"

NSString * const BDHImagePickerPhotoLibraryChangedNotification = @"BDHImagePickerPhotoLibraryChangedNotification";
//static NSString* const kBDHImagePickerStoredGroupKey = @"com.dennis.kBDHImagePickerStoredGroup";

static dispatch_queue_t imageFetchQueue() {
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.awesomedennis.dnimageFetchQueue", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

@interface BDHImagePickerHelper () <PHPhotoLibraryChangeObserver>
@property (nonatomic, strong) NSOperationQueue *imageFetchQueue;
@property (nonatomic, strong) NSMutableDictionary<NSString *, BDHImageFetchOperation*> *fetchImageOperationDics;
@end

@implementation BDHImagePickerHelper

+ (instancetype)sharedHelper {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _imageFetchQueue = [NSOperationQueue new];
        _imageFetchQueue.maxConcurrentOperationCount = 8;
        _imageFetchQueue.name = @"com.awesomedennis.dnnimagefetchOperationQueue";
        _fetchImageOperationDics = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -
#pragma mark - PHPhotoLibraryChangeObserver
- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:BDHImagePickerPhotoLibraryChangedNotification object:nil];
    });
}

#pragma mark -
#pragma mark - public

+ (BDHAlbumAuthorizationStatus)authorizationStatus {
    return (BDHAlbumAuthorizationStatus)[PHPhotoLibrary authorizationStatus];
}

+ (void)requestAlbumListWithCompleteHandler:(void (^)(NSArray<BDHAlbum *> *))completeHandelr {
    dispatch_block_t block = ^{
        NSMutableArray *albums = [NSMutableArray arrayWithArray:[self fetchAlbumsResults]];
        if (!albums) {
            completeHandelr(nil);
            return;
        }
        
        PHFetchOptions *userAlbumsOptions = [[PHFetchOptions alloc] init];
        userAlbumsOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %@",@(PHAssetMediaTypeImage)];
        userAlbumsOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        
        NSMutableArray *list = [NSMutableArray array];
        for (PHFetchResult *result in albums) {
            [result enumerateObjectsUsingBlock:^(PHAssetCollection *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                PHFetchResult *assetResults = [PHAsset fetchAssetsInAssetCollection:obj options:userAlbumsOptions];
                NSInteger count = 0;
                switch (obj.assetCollectionType) {
                    case PHAssetCollectionTypeAlbum:
                    case PHAssetCollectionTypeSmartAlbum:
                        count = assetResults.count;
                        break;
                    default:
                        count = 0;
                        break;
                }
                
                if (count > 0) {
                    @autoreleasepool {
                        BDHAlbum *album = [BDHAlbum albumWithAssetCollection:obj results:assetResults];
                        [list addObject:album];
                    }
                }
            }];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeHandelr) {
                completeHandelr([list copy]);
            }
        });
    };
    dispatch_async(imageFetchQueue(), block);
}

+ (void)requestCurrentAblumWithCompleteHandler:(void (^)(BDHAlbum *))completeHandler {
    void(^callBack)(BDHAlbum *) = ^(BDHAlbum * album){
        dispatch_async(dispatch_get_main_queue(), ^{
            completeHandler(album);
        });
    };
    
    dispatch_async(imageFetchQueue(), ^{
        BDHAlbum *album = [[BDHAlbum alloc] init];
        NSString *identifier = [BDHImagePickerHelper albumIdentifier];
        if (!identifier || identifier.length <= 0) {
            callBack(album);
            return;
        }
        
        PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[identifier] options:nil];
        
        if (result.count <= 0) {
            callBack(album);
            return;
        }
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %@",@(PHAssetMediaTypeImage)];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        PHAssetCollection *collection = result.firstObject;
        
        PHFetchResult *requestReslut = [PHAsset fetchAssetsInAssetCollection:collection options:options];
        album.albumTitle = collection.localizedTitle;
        album.results = requestReslut;
        album.count = requestReslut.count;
        album.identifier = collection.localIdentifier;
        callBack(album);
    });
}

+ (void)fetchImageAssetsInAlbum:(BDHAlbum *)album completeHandler:(void (^)(NSArray<BDHAsset *> *))completeHandler {
    dispatch_async(imageFetchQueue(), ^{
        NSArray<BDHAsset *> *array = [self fetchImageAssetsViaCollectionResults:album.results];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeHandler) {
                completeHandler(array);
            }
        });
    });
}

+ (void)fetchImageSizeWithAsset:(BDHAsset *)asset
         imageSizeResultHandler:(void (^)(CGFloat imageSize, NSString * sizeString))handler {
    if (!asset.asset) {
        handler(0,@"0M");
        return;
    }
    [[PHImageManager defaultManager] requestImageDataForAsset:asset.asset
                                                      options:nil
                                                resultHandler:^(NSData *imageData,
                                                                NSString *dataUTI,
                                                                UIImageOrientation orientation,
                                                                NSDictionary *info) {
                                                    NSString *string = @"0M";
                                                    CGFloat imageSize = 0.0;
                                                    if (!imageData) {
                                                        handler(imageSize, string);
                                                        return;
                                                    }
                                                    imageSize = imageData.length;
                                                    if (imageSize > 1024*1024) {
                                                        CGFloat size = imageSize/(1024*2024);
                                                        string = [NSString stringWithFormat:@"%.1fM",size];
                                                    } else {
                                                        CGFloat size = imageSize/1024;
                                                        string = [NSString stringWithFormat:@"%.1fK",size];
                                                    }
                                                    handler(imageSize, string);
                                                }];
}


+ (void)fetchImageWithAsset:(BDHAsset *)asset
                 targetSize:(CGSize)targetSize
          imageResutHandler:(void (^)(UIImage *))handler {
    return  [self fetchImageWithAsset:asset targetSize:targetSize needHighQuality:NO imageResutHandler:handler];
}

+ (void)fetchImageWithAsset:(BDHAsset *)asset
                 targetSize:(CGSize)targetSize
            needHighQuality:(BOOL)isHighQuality
          imageResutHandler:(void (^)(UIImage *image))handler {
    if (!asset) {
        return;
    }
    
    BDHImagePickerHelper *helper = [BDHImagePickerHelper sharedHelper];
    BDHImageFetchOperation *operation = [[BDHImageFetchOperation alloc] initWithAsset:asset.asset];
    __weak typeof(helper) whelper = helper;
    [operation fetchImageWithTargetSize:targetSize needHighQuality:isHighQuality imageResutHandler:^(UIImage * _Nonnull image) {
        __strong typeof(whelper) shelper = whelper;
        [shelper.fetchImageOperationDics removeObjectForKey:asset.assetIdentifier];
        handler(image);
    }];
    [helper.imageFetchQueue addOperation:operation];
    [helper.fetchImageOperationDics setObject:operation forKey:asset.assetIdentifier];
}

+ (void)cancelFetchWithAssets:(BDHAsset *)asset {
    if (!asset) {
        return;
    }
    BDHImagePickerHelper *helper = [BDHImagePickerHelper sharedHelper];
    BDHImageFetchOperation *operation = [helper.fetchImageOperationDics objectForKey:asset.assetIdentifier];
    if (operation) {
        [operation cancel];
    }
    [helper.fetchImageOperationDics removeObjectForKey:asset.assetIdentifier];
}

#pragma mark -
#pragma mark - priviate

/**
 *  fetch `PHAsset` array via CollectionResults
 *
 *  @param results collection fetch results
 *
 *  @return `BDHAsset` array in collection
 */
+ (NSArray *)fetchImageAssetsViaCollectionResults:(PHFetchResult *)results {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:results.count];
    if (!results) {
        return array;
    }
    
    [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        @autoreleasepool {
            BDHAsset *asset = [BDHAsset assetWithPHAsset:obj];
            [array addObject:asset];
        }
    }];
    
    return [array copy];
}

+ (NSArray *)fetchAlbumsResults {
    PHFetchOptions *userAlbumsOptions = [[PHFetchOptions alloc] init];
    userAlbumsOptions.predicate = [NSPredicate predicateWithFormat:@"estimatedAssetCount > 0"];
    userAlbumsOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:YES]];
    
    NSMutableArray *albumsArray = [NSMutableArray array];
    [albumsArray addObject:
     [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                              subtype:PHAssetCollectionSubtypeAlbumRegular
                                              options:nil]];
    [albumsArray addObject:
     [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                              subtype:PHAssetCollectionSubtypeAny
                                              options:userAlbumsOptions]];
    return albumsArray;
}

+ (void)saveAblumIdentifier:(NSString *)identifier {
    if (identifier.length <= 0)  return;
    [[NSUserDefaults standardUserDefaults] setObject:identifier forKey:kBDHImagePickerStoredGroupKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)albumIdentifier {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kBDHImagePickerStoredGroupKey];
}

@end
