//
//  ImageItem.h
//  MutableSelectGueture
//
//  Created by xiaSang on 2017/9/5.
//  Copyright © 2017年 xiaSang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ImageItem : NSObject

@property NSInteger Dex; //位置
@property BOOL isSelected; //选中状态
//@property UIImage *image;  //图

@end


@interface SwipePath : NSObject
@property CGFloat XX;
@property CGFloat YY;
@end
