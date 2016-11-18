//
//  V_AdjustContrast.m
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "V_AdjustContrast.h"

@implementation V_AdjustContrast{

    CGFloat contrastValue;
    
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        self = [[NSBundle mainBundle] loadNibNamed:@"V_AdjustContrast" owner:nil options:nil][0];
        self.frame = frame;
        
        [self initData];
        [self initView];
        
    }
    
    
    return self;
}


-(void)initView{

    [self.SL_Contrast addTarget:self action:@selector(adjustContrast:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)initData{

    contrastValue = 1.0;
    
}



-(void)adjustContrast:(UISlider *)sender{

    if( ![[NSString stringWithFormat:@"%.1f",contrastValue] isEqualToString:[NSString stringWithFormat:@"%.1f",sender.value]]){
    
        contrastValue = sender.value;
    
        [self.delegate adjustContrast:contrastValue];
        
    }


}




@end
