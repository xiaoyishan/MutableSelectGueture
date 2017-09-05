//
//  UIView+TouchEventBlock.h
//
//  Created by Doluvor on 15/2/10.
//  Copyright (c) 2015年 Doluvor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchesBeganBlock)(NSSet *touches, UIEvent *event);
typedef void (^TouchesMovedBlock)(NSSet *touches, UIEvent *event);
typedef void (^TouchesEndedBlock)(NSSet *touches, UIEvent *event);
typedef void (^TouchesCancelledBlock)(NSSet *touches, UIEvent *event);

@interface UIView (TouchEventBlock)

@property (nonatomic, copy) TouchesBeganBlock touchesBeganBlock;
@property (nonatomic, copy) TouchesMovedBlock touchesMovedBlock;
@property (nonatomic, copy) TouchesEndedBlock touchesEndedBlock;
@property (nonatomic, copy) TouchesCancelledBlock touchesCancelledBlock;

@end
