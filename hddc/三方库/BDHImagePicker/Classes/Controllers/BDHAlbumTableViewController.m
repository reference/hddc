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
#import "BDHAlbumTableViewController.h"
#import "BDHImagePickerController.h"
#import "BDHImageFlowViewController.h"
#import "BDHAlbumCell.h"
#import "UIViewController+BDHImagePicker.h"
#import "BDHUnAuthorizedTipsView.h"
#import "BDHImagePickerHelper.h"
#import "BDHAlbum.h"

static NSString* const BDHAlbumTableViewCellReuseIdentifier = @"BDHAlbumTableViewCellReuseIdentifier";

@interface BDHAlbumTableViewController ()
@property (nonatomic, strong) NSArray *albumArray;
@end

@implementation BDHAlbumTableViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self reloadTableView];
}

#pragma mark - public

- (void)reloadTableView {
    [BDHImagePickerHelper requestAlbumListWithCompleteHandler:^(NSArray<BDHAlbum *> * _Nonnull anblumList) {
        if (anblumList) {
            self.albumArray = [anblumList copy];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - mark setup Data and View
- (void)setupView {
    self.title = NSLocalizedStringFromTable(@"albumTitle", @"BDHImagePicker", @"photos");
    [self createBarButtonItemAtPosition:BDHImagePickerNavigationBarPositionRight
                                   text:NSLocalizedStringFromTable(@"cancel", @"BDHImagePicker", @"取消")
                                 action:@selector(cancelAction:)];
    
    [self.tableView registerClass:[BDHAlbumCell class] forCellReuseIdentifier:BDHAlbumTableViewCellReuseIdentifier];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = view;
}


#pragma mark - ui actions
- (void)cancelAction:(id)sender {
    BDHImagePickerController *navController = [self BDHImagePickerController];
    if (navController && [navController.imagePickerDelegate respondsToSelector:@selector(BDHImagePickerControllerDidCancel:)]) {
        [navController.imagePickerDelegate BDHImagePickerControllerDidCancel:navController];
    }
    if (navController.pickImagesCancel) {
        navController.pickImagesCancel(navController);
    }
}

#pragma mark - getter/setter

- (BDHImagePickerController *)BDHImagePickerController {
    if (!self.navigationController
        ||
        ![self.navigationController isKindOfClass:[BDHImagePickerController class]])
    {
        NSAssert(false, @"check the navigation controller");
    }
    return (BDHImagePickerController *)self.navigationController;
}

- (void)showUnAuthorizedTipsView {
    BDHUnAuthorizedTipsView *view  = [[BDHUnAuthorizedTipsView alloc] initWithFrame:self.tableView.frame];
    self.tableView.backgroundView = view;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDHAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:BDHAlbumTableViewCellReuseIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    BDHAlbum *album = self.albumArray[indexPath.row];
    cell.titleLabel.attributedText = album.albumAttributedString;
    [album fetchPostImageWithSize:CGSizeMake(60, 60) imageResutHandler:^(UIImage * _Nullable postImage) {
        if (postImage) {
            cell.postImageView.image = postImage;
        } else {
            cell.postImageView.image = [UIImage imageNamed:@"assets_placeholder_picture"];
        }
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BDHAlbum *album = self.albumArray[indexPath.row];
    BDHImageFlowViewController *imageFlowViewController = [[BDHImageFlowViewController alloc] initWithAblum:album];
    [self.navigationController pushViewController:imageFlowViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
