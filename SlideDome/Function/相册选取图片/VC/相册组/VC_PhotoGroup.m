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
        
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        
        if(result.count > 0){
        
            [arrayGroupInfo addObject:obj];

        }
    }];
    
    
   
}

//- (NSString *)transformAblumTitle:(NSString *)title
//{
//    if ([title isEqualToString:@"Slo-mo"]) {
//        return @"慢动作";
//    } else if ([title isEqualToString:@"Recently Added"]) {
//        return @"最近添加";
//    } else if ([title isEqualToString:@"Favorites"]) {
//        return @"最爱";
//    } else if ([title isEqualToString:@"Recently Deleted"]) {
//        return @"最近删除";
//    } else if ([title isEqualToString:@"Videos"]) {
//        return @"视频";
//    } else if ([title isEqualToString:@"All Photos"]) {
//        return @"所有照片";
//    } else if ([title isEqualToString:@"Selfies"]) {
//        return @"自拍";
//    } else if ([title isEqualToString:@"Screenshots"]) {
//        return @"屏幕快照";
//    } else if ([title isEqualToString:@"Camera Roll"]) {
//        return @"相机胶卷";
//    }else if([title isEqualToString:@"Panoramas"]){
//       return @"全景照片";
//    }else if([title isEqualToString:@"Bursts"]){
//       return @"连拍";
//    }
//    return nil;
//}

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
    cellNew.LB_Count.text = [NSString stringWithFormat:@"%d pictures",result.count];
    
    PHAsset *asset =result.lastObject;
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        
        cellNew.IV_StartImage.image = image;
        
    }];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    VC_locationPhoto *locationPhoto = [[VC_locationPhoto alloc] init];
   locationPhoto.imageGroup = arrayGroupInfo[indexPath.row];
    [self presentViewController:locationPhoto animated:YES completion:nil];
    
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
