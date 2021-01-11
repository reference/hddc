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
#import "BDHAsset.h"
#import <Photos/Photos.h>
@interface BDHAsset ()
@property (nonatomic, strong, nullable) PHAsset *asset;
@end


@implementation BDHAsset

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarningInAssets) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}


+ (BDHAsset *)assetWithPHAsset:(PHAsset *)asset {
    BDHAsset *a = [[BDHAsset alloc] init];
    if (!asset) {
        return a;
    }
    a.asset = asset;
    a.assetIdentifier = asset.localIdentifier;
    return a;
}

- (void)didReceiveMemoryWarningInAssets {
    _cacheImage = nil;
}


@end
