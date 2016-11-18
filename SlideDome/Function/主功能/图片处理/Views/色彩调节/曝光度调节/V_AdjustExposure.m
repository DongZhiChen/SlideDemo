//
//  V_AdjustExposure.m
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "V_AdjustExposure.h"

@implementation V_AdjustExposure{

    CGFloat exposureValue;
    
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        self = [[NSBundle mainBundle] loadNibNamed:@"V_AdjustExposure" owner:nil options:nil][0];
        self.frame = frame;
        
        [self initData];
        [self initView];
        
        
    }
    
    return  self;
    
}

-(void)initView{

    [self.SL_Exposure addTarget:self action:@selector(adjustExposure:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)initData{

    exposureValue = 0.0;

}

-(void)adjustExposure:(UISlider *)sender{

    if(exposureValue != sender.value){
    
        exposureValue = sender.value;
        
        [self.delegate adjustExposure:exposureValue];
        
    }
}

@end
