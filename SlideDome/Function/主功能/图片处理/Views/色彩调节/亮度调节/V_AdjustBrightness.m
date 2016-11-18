//
//  V_AdjustBrightness.m
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "V_AdjustBrightness.h"

@implementation V_AdjustBrightness{

    CGFloat brightnessValue;
    
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        self = [[NSBundle mainBundle] loadNibNamed:@"V_AdjustBrightness" owner:nil options:nil][0];
        
        self.frame = frame;
        
        [self initData];
        [self initView];
        
    }
    
    return self;
}

-(void)initView{

    [self.SL_Brigheness addTarget:self action:@selector(adjustBrigheness:) forControlEvents:UIControlEventValueChanged];
    
}
-(void)initData{


    brightnessValue = 0.0;
    
}
-(void)adjustBrigheness:(UISlider *)sender{

    if((brightnessValue*10/10) != sender.value){
    
        brightnessValue = sender.value;
        
        [self.delegate adjustBrightness:brightnessValue];
        
    }
}

@end
