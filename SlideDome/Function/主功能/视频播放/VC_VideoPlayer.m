//
//  VC_VideoPlayer.m
//  SlideDome
//
//  Created by ceing on 16/11/16.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "VC_VideoPlayer.h"

@interface VC_VideoPlayer ()

@property (nonatomic,strong) LJPlayerView *playerView;

@end

@implementation VC_VideoPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    __weak typeof(self) weakSelf = self;
    
    _playerView = [[LJPlayerView alloc] initWithFrame:CGRectMake(0, 0, MainBoundsSize.width, MainBoundsSize.height)];
    _playerView.videoURL = self.videoPath;
    _playerView.blockBack = ^{
    
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
    
    [self.view addSubview:_playerView];
    
    
}



-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
