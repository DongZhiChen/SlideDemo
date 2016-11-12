//
//  VC_MuiscList.h
//  SlideDome
//
//  Created by ceing on 16/11/8.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VC_MuiscInfo.h"

@interface VC_MuiscList : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *TB_MuiscList;
- (IBAction)BTN_Close:(id)sender;
- (IBAction)BTN_Sure:(id)sender;

@end
