//
//  VC_EditPhoto.m
//  SlideDome
//
//  Created by ceing on 16/11/17.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "VC_EditPhoto.h"

@interface VC_EditPhoto (){

    NSArray *arrayEditTools;
    
}

@end

@implementation VC_EditPhoto

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self initView];
    

}

-(void)initData{

    arrayEditTools = @[@"色彩调节",@"效果",@"滤镜",@"涂鸦"];
}


-(void)initView{

    self.title = @"Picture";
    [self addRollingTab];
    
}



-(void)addRollingTab{

    [self initData];
    
    V_RollingTab *rollingTab = [[V_RollingTab alloc] initWithFrame:CGRectMake(0, MainBoundsSize.height - 40, MainBoundsSize.width, 40)];
    rollingTab.delegate = self;
    rollingTab.arrayTitles = arrayEditTools;
    rollingTab.canShowSelectedState = NO;
    [self.view addSubview:rollingTab];
 
    self.IV_Image.image = self.image;
    
}


#pragma mark - V_RollingTabDelegate -

-(void)V_RollingTabSelectedIndx:(NSInteger)index{

    if(index == 3){
    
        VC_Doodle *doodle = [[VC_Doodle alloc] init];
        doodle.image = self.image;
        [self.navigationController pushViewController:doodle animated:YES];
        
    }else{
    
        VC_ColorAdjust *adjustColor = [[VC_ColorAdjust alloc] init];
        adjustColor.image = self.image;
        adjustColor.PhotoEditType = index;
        [self.navigationController pushViewController:adjustColor animated:YES];
        
    }
    
    
    
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
