//
//  VC_Doodle.m
//  SlideDome
//
//  Created by ceing on 16/11/18.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "VC_Doodle.h"

@interface VC_Doodle ()

@property (retain, nonatomic) V_DrawingBoard *drawingBoard;


@end

@implementation VC_Doodle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     self.IV_Image.image = self.image;
    
}


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    if(_drawingBoard == nil){
    
        [self.view addSubview:self.drawingBoard];

    }
    
}


-(V_DrawingBoard *)drawingBoard{

    if(_drawingBoard == nil){
        
        [self.view layoutIfNeeded];
        _drawingBoard = [[V_DrawingBoard alloc] initWithFrame:self.IV_Image.frame];
        _drawingBoard.DrawingType = DrawingTypeDrawLine;
        
    }
    
    return _drawingBoard;
    
}



#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
