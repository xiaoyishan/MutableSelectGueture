//
//  MutSelectCollection.h
//  MutableSelectGueture
//
//  Created by xiaSang on 2017/9/5.
//  Copyright © 2017年 xiaSang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageItem.h"
#import "MutSelectCollection.h"
#import "UIView+TouchEventBlock.h"







@interface MutSelectCollection : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *AllTouches; //轨迹
    BOOL isCancel;//反选标志
    
    //layout设置
    CGFloat MinInterval;//左右最小间距
    CGFloat LineSpace;//上下间距
    NSInteger MaxRowItems;//当前设备最大列数
    CGSize CellSize;//cell的尺寸
}
@property NSMutableArray *List;
@end

