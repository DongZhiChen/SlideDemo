//
//  V_AdjustFilterEmboss.m
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "V_AdjustFilterEmboss.h"

@implementation V_AdjustFilterEmboss{

    CGFloat embossValue;
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        self = [[NSBundle mainBundle] loadNibNamed:@"V_AdjustFilterEmboss" owner:nil options:nil][0];
        self.frame = frame;
        
        [self initData];
        [self initView];
        
    }
    
    return self;
    
}


-(void)initView{

    [self.SL_Emboss addTarget:self action:@selector(adjustFilterEmboss:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)initData{

    embossValue = 0.0;
    
}

-(void)adjustFilterEmboss:(UISlider *)sender{

    if(embossValue != sender.value){
    
        embossValue = sender.value;
        [self.delegate adjustFilterEmboss:embossValue];
        
    }
}



@end
