//
//  V_DoodleEditWords.m
//  SlideDome
//
//  Created by ceing on 16/11/21.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "V_DoodleEditWords.h"

@implementation V_DoodleEditWords{

    UITextField *TF_Input;
    CGFloat defaultW;
    CALayer *layerLine;
    
}


-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        frame.size.width = defaultW;
        self.frame = frame;
        
        
        [self initData];
        [self initView];
        
    }
    
    return self;
}


-(void)initView{

    layerLine = [CALayer layer];
    layerLine.frame = CGRectMake(0, CGRectGetHeight(self.bounds), defaultW, 1);
    layerLine.backgroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:layerLine];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(canEditWords)];
    [self addGestureRecognizer:tap];
    
    
    TF_Input = [[UITextField alloc] initWithFrame:self.bounds];
    TF_Input.delegate = self;
    TF_Input.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [TF_Input addTarget:self action:@selector(inputValueChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:TF_Input];
    [TF_Input becomeFirstResponder];
    
    
}

-(void)canEditWords{

    [self.layer addSublayer:layerLine];
    TF_Input.userInteractionEnabled = YES;
    [TF_Input becomeFirstResponder];
    

}
-(void)initData{

    defaultW = 15.0;
    
}


-(void)inputValueChange:(UITextField *)sender{

    CGSize size = [sender.text boundingRectWithSize:MainBoundsSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:sender.font} context:nil].size;
 
    [self setTextFieldNewWidth:size.width+defaultW];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    textField.userInteractionEnabled = NO;
    [layerLine removeFromSuperlayer];
    [textField resignFirstResponder];
    
    return YES;
    
}


-(void)setTextFieldNewWidth:(CGFloat)newWidth{

    CGRect frame = self.bounds;
    frame.size.width = newWidth;
    self.bounds = frame;
    
    layerLine.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), 1);
    
    TF_Input.frame = self.bounds;
    
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch = touches.anyObject;
    
    if(touch.view == self){
    
        CGPoint point = [touch locationInView:self.superview];
        
        CGRect frame = self.frame;
        frame.origin.x = point.x - frame.size.width/2.0;
        frame.origin.y = point.y - frame.size.height/2.0;
        self.frame = frame;
        
    }
}

@end
