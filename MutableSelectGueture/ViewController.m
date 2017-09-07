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




















@end
