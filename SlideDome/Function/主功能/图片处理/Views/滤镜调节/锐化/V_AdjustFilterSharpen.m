//
//  V_AdjustFilterSharpen.m
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "V_AdjustFilterSharpen.h"

@implementation V_AdjustFilterSharpen{

    CGFloat sharpenValue;
    
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        self = [[NSBundle mainBundle] loadNibNamed:@"V_AdjustFilterSharpen" owner:self options:nil][0];
        self.frame = frame;
    
        [self initData];
        [self initView];
        
    }
    
    return self;
    
}


-(void)initData{

    sharpenValue = 0.0;
    
}


-(void)initView{

    [self.SL_Sharpness addTarget:self action:@selector(adjustFilterSharpen:) forControlEvents:UIControlEventValueChanged];
    
}



-(void)adjustFilterSharpen:(UISlider *)sender{


    if(sharpenValue != sender.value){
    
        sharpenValue = sender.value;
        
        [self.delegate adjustFilterSharpen:sharpenValue];
        
    }
}



@end
