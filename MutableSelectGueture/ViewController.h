//
//  ViewController.h
//  MutableSelectGueture
//
//  Created by xiaSang on 2017/9/1.
//  Copyright © 2017年 xiaSang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageItem.h"
#import "MutSelectCollection.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MutSelectCollection *Collection;
@property NSMutableArray *List;
@end

