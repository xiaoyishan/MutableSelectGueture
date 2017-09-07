//
//  MutSelectCollection.m
//  MutableSelectGueture
//
//  Created by xiaSang on 2017/9/5.
//  Copyright © 2017年 xiaSang. All rights reserved.
//

#import "MutSelectCollection.h"

@implementation MutSelectCollection

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayers];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupLayers];
    }
    return self;
}


-(void)setupLayers{
    self.delegate=self;
    self.dataSource=self;
    
    //layout设置
    MinInterval = 5;//左右最小间距
    LineSpace = 10;//上下间距
    CellSize = CGSizeMake(80, 80);//cell的尺寸
    MaxRowItems = ([UIScreen mainScreen].bounds.size.width-30)/(CellSize.width+MinInterval);
    
    
    
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint Point = [[touches anyObject] locationInView:self];
//    NSLog(@"touch  X: %.0f  Y: %.0f" , Point.x,Point.y);
    
    AllTouches = [NSMutableArray new];
    
    SwipePath *path = [SwipePath new];
    path.XX = Point.x-15;
    path.YY = Point.y-20;
    if([self isInLayout:path])[AllTouches addObject:path];
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint Point = [[touches anyObject] locationInView:self];
    SwipePath *path = [SwipePath new];
    path.XX = Point.x-15;
    path.YY = Point.y-20;
    if([self isInLayout:path])[AllTouches addObject:path];
    
    if ([self isSwipeGuseture]) {
        self.scrollEnabled = NO;
    }
//    [self HightLightCell];//暂时高亮
    [self RollinHeadOrFoot:[[touches anyObject] locationInView:self.superview]];//上下滚动
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint Point = [[touches anyObject] locationInView:self];
    SwipePath *path = [SwipePath new];
    path.XX = Point.x-15;
    path.YY = Point.y-20;
    if([self isInLayout:path])[AllTouches addObject:path];
//    NSLog(@"touch end  X: %.0f  Y: %.0f" , Point.x,Point.y);
    
    self.scrollEnabled = YES;
    [self HightLightCell];//暂时高亮
}



//断定swipe  条件 ：25个点以上 上下滚动距离小于左右距离的1/3
-(BOOL)isSwipeGuseture{
    
    if (AllTouches.count==25) {
        CGFloat X = 0;
        CGFloat Y = 0;
        for (int k=0; k<25; k++) {
            SwipePath *FirstPath = AllTouches[0];
            SwipePath *path = AllTouches[k];
            X = X + path.XX+0.001 - FirstPath.XX;
            Y = Y + path.YY+0.001 - FirstPath.YY;
        }
        
        if (fabs(X)/fabs(Y)>3) {
//            NSLog(@"条件成立!!!   X:%.0f Y:%.0f 比例:%.1f", X,Y, X/Y/1.0 );
            return YES;
        }
    }
    return NO;
}

//断定边界范围 确定范围外的坐标不加入到轨迹
-(BOOL)isInLayout:(SwipePath*)path{
    if (path.XX<0 || path.XX>[UIScreen mainScreen].bounds.size.width-30) {
        return NO;
    }return YES;
}

//模拟选中
-(void)HightLightCell{
    if(AllTouches.count==0)return;
    
    
    SwipePath *BeginPath = AllTouches.firstObject;
    SwipePath *EndPath = AllTouches.lastObject;
    
    NSInteger BeginRow = 0;
    NSInteger EndRow = 0;
    
    //计算实际左右间距
    NSInteger actualInterval = ([UIScreen mainScreen].bounds.size.width-30 - CellSize.width*MaxRowItems)/(MaxRowItems-1);
    
    
    BeginRow = floor(BeginPath.YY/(CellSize.height+LineSpace))*MaxRowItems + floor(BeginPath.XX/(CellSize.width+actualInterval));
    EndRow = floor(EndPath.YY/(CellSize.height+LineSpace))*MaxRowItems + floor(EndPath.XX/(CellSize.width+actualInterval));
  
//    NSLog(@"结果: %.0f %.0f 计算的起点和终点 %zd %zd", EndPath.XX, EndPath.YY ,BeginRow,EndRow);
  
    isCancel = NO;//反选标志
    
    for (NSInteger k=BeginRow>EndRow?EndRow:BeginRow; k<=(BeginRow>EndRow?BeginRow:EndRow); k++) {
        UICollectionViewCell *cell = [self cellForItemAtIndexPath:
                                      [NSIndexPath indexPathForItem:k
                                                          inSection:0]];
        //根据首个cell来决定是全选还是全取消
        if (k==BeginRow) {
            NSLog(@"K:%zd began:%zd end:%zd",k,BeginRow,EndRow);
            if (cell.alpha!=1){
                isCancel=YES;
            }
        }

        cell.alpha = isCancel?1:0.3;

    }
    
    //反选（都是选中的标签）
    if (isCancel) {
        for (NSInteger k=BeginRow>EndRow?EndRow:BeginRow; k<=(BeginRow>EndRow?BeginRow:EndRow); k++) {
            UICollectionViewCell *cell = [self cellForItemAtIndexPath:
                                          [NSIndexPath indexPathForItem:k
                                                              inSection:0]];
            cell.alpha = 1;
        }
    }
    
}


//自动上下滚动
-(void)RollinHeadOrFoot:(CGPoint)FingerPoint{
    if(AllTouches.count<25)return;
    if(self.scrollEnabled) return;
    if (FingerPoint.y<64) {
        NSLog(@"向上滚动:%.0f  ",FingerPoint.y);
        [self ScrollerToHead];
    }
    if (FingerPoint.y>self.superview.frame.size.height-64) {
        NSLog(@"向下滚动:%.0f  ",FingerPoint.y);
        [self ScrollerToFoot];
    }
    
}

-(void)ScrollerToHead{
    [self setContentOffset:CGPointMake(0, self.contentOffset.y-80) animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(!self.scrollEnabled)[self ScrollerToHead];
    });
}


-(void)ScrollerToFoot{
    [self setContentOffset:CGPointMake(0, self.contentOffset.y+80) animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(!self.scrollEnabled)[self ScrollerToFoot];
    });
}


















#pragma mark ------------ 集合视图 ---------------------


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _List.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell sizeToFit];
    
    ImageItem *item = _List[indexPath.row];
    if (item.isSelected) {
        cell.alpha = 0.3;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageItem *item = _List[indexPath.row];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if (item.isSelected) {
        item.isSelected = NO;
        cell.alpha = 1;
    }else{
        item.isSelected = YES;
        cell.alpha = 0.3;
    }
    
}





#pragma mark -- UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CellSize;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 15, 0, 15);
}

// 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return MinInterval;//最小左右间距
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return LineSpace;
}





@end
