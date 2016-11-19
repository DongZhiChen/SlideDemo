//
//  V_DrawingBoard.m
//  DoodleDemo
//
//  Created by ceing on 16/11/16.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "V_DrawingBoard.h"

@implementation V_DrawingBoard{

    //画笔起点
    CGPoint startPoint;
    //画笔终点
    CGPoint endPoint;
    
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        self.layer.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect{

[_imageDoodle drawInRect:self.bounds];
    
}

#pragma mark - 
//橡皮擦
- (void)eraseLine
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [_imageDoodle drawInRect:self.bounds];
    
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 10);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), startPoint.x, startPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), endPoint.x, endPoint.y);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    _imageDoodle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    startPoint = endPoint;
    
    [self setNeedsDisplay];
}

//涂鸦
- (void)drawLineNew
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [_imageDoodle drawInRect:self.bounds];

    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 10);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), startPoint.x, startPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), endPoint.x, endPoint.y);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    _imageDoodle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    startPoint = endPoint;
 [self setNeedsDisplay];
}



-(void)touchDrawing{

    switch (_DrawingType) {
        case DrawingTypeDrawLine:{
        
            [self drawLineNew];
            
        }break;
        case DrawingTypeEraser:{
            
            [self eraseLine];
            
        }break;
        case DrawingTypeClearAll:{
            
            
            
        }break;
        default:
            break;
    }
}


#pragma mark - Touch -

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.allObjects[0];
    
    startPoint = [touch locationInView:self];
    endPoint = startPoint;
    [self touchDrawing];

    
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.allObjects[0];
    endPoint = [touch locationInView:self];
    
   [self touchDrawing];
    
}

@end
