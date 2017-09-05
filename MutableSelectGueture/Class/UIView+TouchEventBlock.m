//
//  UIView+TouchEventBlock.m
//
//  Created by Doluvor on 15/2/10.
//  Copyright (c) 2015年 Doluvor. All rights reserved.
//

#import "UIView+TouchEventBlock.h"
#import <objc/runtime.h>

static const void *TouchesBeganBlockKey = &TouchesBeganBlockKey;
static const void *TouchesMovedBlockKey = &TouchesMovedBlockKey;
static const void *TouchesEndedBlockKey = &TouchesEndedBlockKey;
static const void *TouchesCancelledBlockKey = &TouchesCancelledBlockKey;

@implementation UIView (TouchEventBlock)

@dynamic touchesBeganBlock;
@dynamic touchesMovedBlock;
@dynamic touchesEndedBlock;
@dynamic touchesCancelledBlock;

- (void)setTouchesBeganBlock:(TouchesBeganBlock)touchesBeganBlock {
    objc_setAssociatedObject(self, TouchesBeganBlockKey, touchesBeganBlock, OBJC_ASSOCIATION_COPY);
}

- (TouchesBeganBlock)touchesBeganBlock {
    return objc_getAssociatedObject(self, TouchesBeganBlockKey);
}

- (void)setTouchesMovedBlock:(TouchesMovedBlock)touchesMovedBlock {
    objc_setAssociatedObject(self, TouchesMovedBlockKey, touchesMovedBlock, OBJC_ASSOCIATION_COPY);
}

- (TouchesMovedBlock)touchesMovedBlock {
    return objc_getAssociatedObject(self, TouchesMovedBlockKey);
}

- (void)setTouchesEndedBlock:(TouchesEndedBlock)touchesEndedBlock {
    objc_setAssociatedObject(self, TouchesEndedBlockKey, touchesEndedBlock, OBJC_ASSOCIATION_COPY);
}

- (TouchesEndedBlock)touchesEndedBlock {
    return objc_getAssociatedObject(self, TouchesEndedBlockKey);
}

- (void)setTouchesCancelledBlock:(TouchesCancelledBlock)touchesCancelledBlock {
    objc_setAssociatedObject(self, TouchesCancelledBlockKey, touchesCancelledBlock, OBJC_ASSOCIATION_COPY);
}

- (TouchesCancelledBlock)touchesCancelledBlock {
    return objc_getAssociatedObject(self, TouchesCancelledBlockKey);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    TouchesBeganBlock block = self.touchesBeganBlock;
    
    if (block != NULL)
        block(touches, event);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    TouchesMovedBlock block = self.touchesMovedBlock;
    
    if (block != NULL)
        block(touches, event);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    TouchesEndedBlock block = self.touchesEndedBlock;
    
    if (block != NULL)
        block(touches, event);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    TouchesCancelledBlock block = self.touchesCancelledBlock;
    
    if (block != NULL)
        block(touches, event);
}

@end
