//
//  V_AdjustWhiteBalance.m
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "V_AdjustWhiteBalance.h"

@implementation V_AdjustWhiteBalance{

    NSInteger temperatureValue;
    CGFloat tintValue;
    
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        self = [[NSBundle mainBundle] loadNibNamed:@"V_AdjustWhiteBalance" owner:self options:nil][0];
        self.frame = frame;
        
        [self initData];
        [self initView];
    }
    
    
    return self;
}


-(void)initView{
    
    [self.SL_Temperature addTarget:self action:@selector(adjustWhiteBalance:) forControlEvents:UIControlEventValueChanged];
    [self.SL_Tint addTarget:self action:@selector(adjustWhiteBalance:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)initData{
    
    temperatureValue = 0;
    tintValue = 0;
    
}



-(void)adjustWhiteBalance:(UISlider *)sender{
    
    
    if(sender == self.SL_Temperature){
    
        if(temperatureValue != (NSInteger)sender.value){
        
            temperatureValue = sender.value;
            
            [self.delegate adjustWhiteBalanceWithTemperature:temperatureValue*100 addTint:tintValue];
        
        }
        
    }else if(sender == self.SL_Tint){
        
        if(tintValue*10/10 != sender.value*10/10){
        
            tintValue = sender.value;
            
         [self.delegate adjustWhiteBalanceWithTemperature:temperatureValue*100 addTint:tintValue];
        }
    }
}



@end
