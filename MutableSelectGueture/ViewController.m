//
//  ViewController.m
//  MutableSelectGueture
//
//  Created by xiaSang on 2017/9/1.
//  Copyright © 2017年 xiaSang. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _List = [NSMutableArray new];
    for (int k=0; k<1000; k++) {
        ImageItem *item = [ImageItem new];
        item.Dex = k;
        item.isSelected = NO;
        [_List addObject:item];
    }
    _Collection.List=_List;
    
}











//#pragma mark ------------ 集合视图 ---------------------
//
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return _List.count;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    [cell sizeToFit];
//    
//    ImageItem *item = _List[indexPath.row];
//    if (item.isSelected) {
//        cell.alpha = 0.3;
//    }
//    
//    return cell;
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    ImageItem *item = _List[indexPath.row];
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//
//    if (item.isSelected) {
//        item.isSelected = NO;
//        cell.alpha = 1;
//    }else{
//        item.isSelected = YES;
//        cell.alpha = 0.3;
//    }
//    
//}
//
//
//
//
//
//#pragma mark -- UICollectionViewDelegate
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(80, 80);
//}
//
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(20, 15, 0, 15);
//}
//
//// 间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 5;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 2;
//}











@end
