//
//  VC_MuiscList.m
//  SlideDome
//
//  Created by ceing on 16/11/8.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "VC_MuiscList.h"

@interface VC_MuiscList (){

    NSArray *arrayMuisc;
    NSInteger index;
}

@end
static NSString *CellID = @"CELLID";

@implementation VC_MuiscList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self initView];
    
}


#pragma mark - initSet -

-(void)initView{
    
    self.TB_MuiscList.delegate = self;
    self.TB_MuiscList.dataSource = self;
    self.TB_MuiscList.separatorColor = [UIColor clearColor];
    [self.TB_MuiscList registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    
}


-(void)initData{

    arrayMuisc = @[@"悲伤",@"欢快",@"平静",@"忧郁"];
    
}


-(NSString *)changeMuiscName:(NSString *)name{

    if([name isEqualToString:@"悲伤"]){
    
    return @"sad";
        
    }else if([name isEqualToString:@"欢快"]){
    
    return @"happy";
        
    }else if([name isEqualToString:@"平静"]){
    
    return @"quiet";
        
    }else{
    
    return @"cafard";
        
    }
}
#pragma mark - UITableViewDataSource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return arrayMuisc.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.backgroundColor = [UIColor blackColor];

    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@.mp3",[self changeMuiscName:arrayMuisc[indexPath.row]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    index = indexPath.row;
    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BTN_Close:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)BTN_Sure:(id)sender {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseMuisc" object:[[NSBundle mainBundle] pathForResource:arrayMuisc[index] ofType:@"mp3"]];
   [self.navigationController popViewControllerAnimated:YES];
    
}


@end
