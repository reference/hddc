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
#import <UIKit/UIKit.h>

@class BDHImageFlowViewController;
@class BDHPhotoBrowser;
@class BDHAsset;
@protocol BDHPhotoBrowserDelegate <NSObject>

@required
- (void)sendImagesFromPhotobrowser:(BDHPhotoBrowser *)photoBrowse currentAsset:(BDHAsset *)asset;
- (NSUInteger)seletedPhotosNumberInPhotoBrowser:(BDHPhotoBrowser *)photoBrowser;
- (BOOL)photoBrowser:(BDHPhotoBrowser *)photoBrowser currentPhotoAssetIsSeleted:(BDHAsset *)asset;
- (BOOL)photoBrowser:(BDHPhotoBrowser *)photoBrowser seletedAsset:(BDHAsset *)asset;
- (void)photoBrowser:(BDHPhotoBrowser *)photoBrowser deseletedAsset:(BDHAsset *)asset;
- (void)photoBrowser:(BDHPhotoBrowser *)photoBrowser seleteFullImage:(BOOL)fullImage;
@end

@interface BDHPhotoBrowser : UIViewController

@property (nonatomic, weak) id<BDHPhotoBrowserDelegate> delegate;

- (instancetype)initWithPhotos:(NSArray *)photosArray
                  currentIndex:(NSInteger)index
                     fullImage:(BOOL)isFullImage;

- (void)hideControls;
- (void)toggleControls;
@end
