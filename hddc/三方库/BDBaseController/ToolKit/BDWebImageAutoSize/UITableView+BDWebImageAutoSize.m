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
#import "UITableView+BDWebImageAutoSize.h"
#import "BDWebImageAutoSizeConst.h"
#import "BDWebImageAutoSize.h"

@implementation UITableView (BDWebImageAutoSize)

-(void)bd_reloadDataForURL:(NSURL *)url{
    BOOL reloadState = [BDWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadData];
        [BDWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}

#pragma mark-过期
-(void)bd_reloadRowAtIndexPath:(NSIndexPath *)indexPath forURL:(NSURL *)url{
    [self bd_reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone forURL:url];
}
-(void)bd_reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation forURL:(NSURL *)url{
    BOOL reloadState = [BDWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:animation];
        [BDWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}
-(void)bd_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths forURL:(NSURL *)url{
    [self bd_reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone forURL:url];
}

-(void)bd_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation forURL:(NSURL *)url{
    BOOL reloadState = [BDWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
        [BDWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}
@end
