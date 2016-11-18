//
//  VC_locationPhoto.h
//  Com.message
//
//  Created by lee on 24/3/2015.
//  Copyright (c) 2015年 sanchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellLocationPhoto.h"

#import <Photos/PHAsset.h>
#import <Photos/PHCollection.h>
#import <Photos/PHImageManager.h>

@interface VC_locationPhoto : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

  
}
- (IBAction)BTN_OK:(id)sender;

@property (nonatomic,retain) PHAssetCollection *imageGroup;


@property (weak, nonatomic) IBOutlet UICollectionView *CV_photoList;

@end
