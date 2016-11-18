//
//  V_AdjustSaturation.m
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "V_AdjustSaturation.h"

@implementation V_AdjustSaturation{

    CGFloat saturationValue;
    
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        self = [[NSBundle mainBundle] loadNibNamed:@"V_AdjustSaturation" owner:self options:nil][0];
        self.frame = frame;
        
        [self initData];
        [self initView];
        
        
    }
    
    return self;
}


-(void)initView{

    [self.SL_Saturation addTarget:self action:@selector(adjustSaturation:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)initData{

    saturationValue = 1.0;
    
}

-(void)adjustSaturation:(UISlider *)sender{

    if(sender.value *10/10 != saturationValue){
    
        saturationValue = sender.value;
        [self.delegate adjustSaturation:saturationValue];
        
    }
    
}


@end
