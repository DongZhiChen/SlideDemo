//
//  UIViewController+DismissRoot.m
//  SlideDome
//
//  Created by ceing on 16/11/7.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "UIViewController+DismissRoot.h"

@implementation UIViewController (DismissRoot)


-(void)dismissToRootController{

    UIViewController *vc = self;
    
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
    
}


@end
