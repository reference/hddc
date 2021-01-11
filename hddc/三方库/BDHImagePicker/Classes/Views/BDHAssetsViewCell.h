//
//  BDHAssetsViewCell.h
//  ImagePicker
//
//  Created by DingXiao on 15/2/11.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDHAssetsViewCell;
@class BDHAsset;

@protocol BDHAssetsViewCellDelegate <NSObject>
@optional

- (void)didSelectItemAssetsViewCell:(nonnull BDHAssetsViewCell *)assetsCell;
- (void)didDeselectItemAssetsViewCell:(nonnull BDHAssetsViewCell *)assetsCell;
@end

@interface BDHAssetsViewCell : UICollectionViewCell

@property (nonatomic, readonly, nonnull) UIImageView *imageView;
@property (nonatomic, strong, nonnull) BDHAsset *asset;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, weak, nullable) id<BDHAssetsViewCellDelegate> delegate;

- (void)fillWithAsset:(nonnull BDHAsset *)asset isSelected:(BOOL)seleted;

@end
