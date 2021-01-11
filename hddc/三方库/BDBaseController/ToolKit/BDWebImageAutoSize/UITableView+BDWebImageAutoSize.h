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
#import <UIKit/UIKit.h>
#import "BDWebImageAutoSizeConst.h"

@interface UITableView (BDWebImageAutoSize)

/**
 Reload tableView

 @param url imageURL
 */
-(void)bd_reloadDataForURL:(NSURL *)url;

#pragma mark - 过期
/**
 *  Reload row
 *
 *  @param indexPath indexPath
 *  @param url        imageURL
 */
-(void)bd_reloadRowAtIndexPath:(NSIndexPath *)indexPath forURL:(NSURL *)url BDWebImageAutoSizeDeprecated("请使用bd_reloadDataForURL:");

/**
 *  Reload row withRowAnimation
 *
 *  @param indexPath indexPath
 *  @param animation UITableViewRowAnimation
 *  @param url       imageURL
 */
-(void)bd_reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation forURL:(NSURL *)url BDWebImageAutoSizeDeprecated("请使用bd_reloadDataForURL:");

/**
 *  Reload rows
 *
 *  @param indexPaths indexPaths
 *  @param url        imageURL
 */
-(void)bd_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths forURL:(NSURL *)url BDWebImageAutoSizeDeprecated("请使用bd_reloadDataForURL:");
;

@end
