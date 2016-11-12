//
//  VC_MuiscInfo.m
//  SlideDome
//
//  Created by ceing on 16/11/8.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "VC_MuiscInfo.h"

@interface VC_MuiscInfo (){

    NSArray *arrayMuisc;
    AVAudioPlayer *player;
    
}

@end

@implementation VC_MuiscInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self initView];
    
    
}

#pragma mark - initSet -

-(void)initView{
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];

    NSError *error;
    player = [[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfFile:[self getMusicPathWithMusicName:arrayMuisc[0]]] error:&error];
    [player prepareToPlay];
    [player play];
    
    
    
}

-(void)initData{

    arrayMuisc = @[@"悲伤",@"欢快",@"安静",@"忧郁"];
    
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{


  
}
#pragma mark - 

-(NSString *)getMusicPathWithMusicName:(NSString *)musicName{

    return [[NSBundle mainBundle] pathForResource:musicName ofType:@"mp3"];
    
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BTN_PlayOrStop:(UIButton *)sender {
    
    if(sender.isSelected){
    
        [player pause];
        
    }else{
    
        [player play];
    }
    
    sender.selected = !sender.isSelected;
    
    
//    player = nil;
//    
//    player = [[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfFile:[self getMusicPathWithMusicName:arrayMuisc[1]]] error:nil];
//    [player prepareToPlay];
//    [player play];
}
@end
