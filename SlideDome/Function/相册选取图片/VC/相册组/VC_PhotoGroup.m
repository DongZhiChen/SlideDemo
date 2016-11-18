//
//  VC_PhotoGroup.m
//  SlideDome
//
//  Created by ceing on 16/11/4.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "VC_PhotoGroup.h"

@interface VC_PhotoGroup (){

    UITableView *TB_PhotoGroupList;
    NSMutableArray *arrayGroupInfo;
    PHImageRequestOptions *option;
    
}

@end

static NSString *CellID = @"CellPhotoGroup";

@implementation VC_PhotoGroup

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Group";
    
    arrayGroupInfo = [NSMutableArray new];
    self.view.backgroundColor = [UIColor blackColor];
    
    option = [[PHImageRequestOptions alloc] init];
    option.synchronous = YES;
    option.resizeMode = PHImageContentModeAspectFill;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    [self setTB_PhotoGroupList];
    
    [self getAllAssetPhotoAblum];
    
    
   
    
}



-(void)setTB_PhotoGroupList{

    TB_PhotoGroupList = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20) style:UITableViewStylePlain];
    TB_PhotoGroupList.delegate = self;
    TB_PhotoGroupList.dataSource = self;
    TB_PhotoGroupList.backgroundColor = [UIColor blackColor];
    [TB_PhotoGroupList registerNib:[UINib nibWithNibName:@"CellPhotoGroup" bundle:nil] forCellReuseIdentifier:CellID];
    TB_PhotoGroupList.tableFooterView = [UIView new];
    TB_PhotoGroupList.separatorColor = [UIColor clearColor];
    [self.view addSubview:TB_PhotoGroupList];
    
}



-(void)getAllAssetPhotoAblum{

    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PHAssetCollection *collection = (PHAssetCollection *)obj;
        
        if(![collection.localizedTitle isEqualToString:@"Videos"]){
        
            PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
            
            if(result.count > 0){
                
                [arrayGroupInfo addObject:obj];
                
            }
            
        }
   
    }];
    
    
   
}


#pragma mark - UITableViewDataSource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return arrayGroupInfo.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CellPhotoGroup *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITableViewDelegate -

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    CellPhotoGroup *cellNew = (CellPhotoGroup *)cell;
    
    PHAssetCollection *collection = (PHAssetCollection *)arrayGroupInfo[indexPath.row];
    cellNew.LB_GroupName.text = collection.localizedTitle;
    
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    cellNew.LB_Count.text = [NSString stringWithFormat:@"%d pictures",(int)result.count];
    
    PHAsset *asset =result.lastObject;
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        
        cellNew.IV_StartImage.image = image;
        
    }];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    VC_locationPhoto *locationPhoto = [[VC_locationPhoto alloc] init];
   locationPhoto.imageGroup = arrayGroupInfo[indexPath.row];
   [self.navigationController pushViewController:locationPhoto animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100.0;
}


#pragma mark - 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
