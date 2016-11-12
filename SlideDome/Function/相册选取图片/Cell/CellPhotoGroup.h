//
//  CellPhotoGroup.h
//  SlideDome
//
//  Created by ceing on 16/11/4.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellPhotoGroup : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *IV_StartImage;
@property (weak, nonatomic) IBOutlet UILabel *LB_GroupName;
@property (weak, nonatomic) IBOutlet UILabel *LB_Count;

@end
