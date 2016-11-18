//
//  V_AdjustRGB.m
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "V_AdjustRGB.h"

@implementation V_AdjustRGB{

    CGFloat RValue;
    CGFloat GValue;
    CGFloat BValue;
    
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        self = [[NSBundle mainBundle] loadNibNamed:@"V_AdjustRGB" owner:self options:nil][0];
        self.frame = frame;
        
        [self initData];
        [self initView];
        
    }
    
    return self;
    
}


-(void)initView{

    self.DZSL_R.endColor = [UIColor redColor];
    self.DZSL_R.value = 1.0;
    [self.DZSL_R addTarget:self action:@selector(adjustColor:) forControlEvents:UIControlEventValueChanged];
    
    self.DZSL_G.endColor = [UIColor greenColor];
    self.DZSL_G.value = 1.0;
    [self.DZSL_G addTarget:self action:@selector(adjustColor:) forControlEvents:UIControlEventValueChanged];
    
    self.DZSL_B.endColor = [UIColor blueColor];
    self.DZSL_B.value = 1.0;
    [self.DZSL_B addTarget:self action:@selector(adjustColor:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)initData{

    RValue = 1.0;
    GValue = 1.0;
    BValue = 1.0;
    
}



-(void)adjustColor:(DZSliderChooseColor *)sender{

    if(sender == self.DZSL_R){
    
        if(RValue != sender.value){
        
            RValue = sender.value;
            
            [self.delegate adjustRGBWithR:RValue addG:GValue addB:BValue];
        }
        
    }else if(sender == self.DZSL_G){
    
        if(GValue != sender.value){
            
            GValue = sender.value;
            
            [self.delegate adjustRGBWithR:RValue addG:GValue addB:BValue];
        }
    
    }else{
    
        if(BValue != sender.value){
            
            BValue = sender.value;
            
            [self.delegate adjustRGBWithR:RValue addG:GValue addB:BValue];
            
        }
    
    }
    
}


@end
