//
//  V_AdjustFilterBlur.m
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "V_AdjustFilterBlur.h"

@implementation V_AdjustFilterBlur{

    CGFloat blurValue;
    
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        self = [[NSBundle mainBundle] loadNibNamed:@"V_AdjustFilterBlur" owner:nil options:nil][0];
        self.frame = frame;
        
        [self initData];
        [self initView];
        
    }
    
    
    return self;
    
}


-(void)initView{

    [self.SL_Blur addTarget:self action:@selector(adjustFilterBlur:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)initData{

    blurValue = 0.0;
    
}


-(void)adjustFilterBlur:(UISlider *)sender{
    
    if(blurValue != sender.value){
    
        blurValue = sender.value;
        
        [self.delegate adjustFilterBlur:blurValue];
        
    }
}

@end
