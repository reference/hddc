//
//  BDHBrowserCell.h
//  ImagePicker
//
//  Created by DingXiao on 15/2/28.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BDHAsset;
@class BDHPhotoBrowser;

@interface BDHBrowserCell : UICollectionViewCell

@property (nonatomic, weak, nullable) BDHPhotoBrowser *photoBrowser;

@property (nonatomic, strong, nullable) BDHAsset *asset;

@end
