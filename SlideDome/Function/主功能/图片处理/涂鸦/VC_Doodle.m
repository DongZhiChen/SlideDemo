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
    
    [self initView];
    
    
}






-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    if(_drawingBoard == nil){
    
        [self.view addSubview:self.drawingBoard];

        
    }
    
}


-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    if(_drawingBoard.imageDoodle){
    
       self.image = [UIImage imageMergeWithImage1:self.image addImage2:_drawingBoard.imageDoodle];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"editPhotoResultImage" object:self.image];
        
    }
}



-(void)initView{
    
    self.title = @"Doodle";
    [self.BTN_Eraser addTarget:self action:@selector(BTN_Eraser:) forControlEvents:UIControlEventTouchUpInside];
    [self.BTN_Pen addTarget:self action:@selector(BTN_Pen:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(V_DrawingBoard *)drawingBoard{

    if(_drawingBoard == nil){
        
        [self.view layoutIfNeeded];
        _drawingBoard = [[V_DrawingBoard alloc] initWithFrame:self.IV_Image.frame];
        _drawingBoard.DrawingType = DrawingTypeDrawLine;
        
    }
    
    return _drawingBoard;
    
}


#pragma mark - UIButtonEventClick -

-(void)BTN_Eraser:(UIButton *)sender{

    _drawingBoard.DrawingType = DrawingTypeEraser;
    

}

-(void)BTN_Pen:(UIButton *)sender{

    _drawingBoard.DrawingType = DrawingTypeDrawLine;

}


#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
