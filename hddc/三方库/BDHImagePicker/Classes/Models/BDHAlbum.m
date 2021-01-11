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
#import "BDHAlbum.h"
#import "BDHImagePickerHelper.h"
#import "BDHAsset.h"

@interface BDHAlbum ()
@property (nonatomic, strong) NSAttributedString *albumAttributedString;
@end

@implementation BDHAlbum

- (instancetype)init {
    self = [super init];
    if (self) {
        _albumTitle = @"";
        _identifier = @"";
        _count = 0;
    }
    return self;
}

+ (BDHAlbum *)albumWithAssetCollection:(PHAssetCollection *)collection results:(PHFetchResult *)results{
    BDHAlbum *album = [[BDHAlbum alloc] init];
    if (!collection || !results) {
        return album;
    }
    album.count = results.count;
    album.results = results;
    album.albumTitle = collection.localizedTitle;
    album.identifier = collection.localIdentifier;
    return album;
}

- (void)fetchPostImageWithSize:(CGSize)size
             imageResutHandler:(void (^)(UIImage *))handler {
    [BDHImagePickerHelper fetchImageWithAsset:[BDHAsset assetWithPHAsset:self.results.lastObject]
                                  targetSize:size
                           imageResutHandler:^(UIImage *postImage) {
                               handler(postImage);
                           }];
}

- (NSAttributedString *)albumAttributedString {
    if (!_albumAttributedString) {
        NSString *numberString = [NSString stringWithFormat:@"  (%@)",@(self.count)];
        NSString *cellTitleString = [NSString stringWithFormat:@"%@%@",self.albumTitle,numberString];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cellTitleString];
        [attributedString setAttributes: @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                           NSForegroundColorAttributeName : [UIColor blackColor],
                                           }
                                  range:NSMakeRange(0, self.albumTitle.length)];
        [attributedString setAttributes:@{
                                          NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                          NSForegroundColorAttributeName : [UIColor grayColor],
                                          } range:NSMakeRange(self.albumTitle.length, numberString.length)];
        _albumAttributedString = attributedString;
    }
    return _albumAttributedString;
}

@end
