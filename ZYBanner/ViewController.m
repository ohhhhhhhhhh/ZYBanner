//
//  ViewController.m
//  ZYBanner
//
//  Created by zy on 2017/9/5.
//  Copyright © 2017年 zy. All rights reserved.
//

#import "ViewController.h"
#import "ZYBanner.h"

@interface ViewController ()

@property (nonatomic,  weak) ZYBanner * banner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.banner.images = @[@"img_00",@"img_01",@"img_02",@"img_03",@"img_04"];
}


#pragma mark -make ui
-(ZYBanner *)banner{
    
    if (!_banner) {
        
        ZYBanner * banner = [[ZYBanner alloc]initWithFrame:CGRectMake(30, 100, 300, 130)];
        [self.view addSubview:banner];
        _banner = banner;
    }
    return _banner;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
