//
//  ViewController.m
//  下拉菜单Demo
//
//  Created by hzzc on 16/6/28.
//  Copyright © 2016年 hzzc. All rights reserved.
//

#import "ViewController.h"
#import "ShowMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *addData = @[@"手机数码",@"时尚女装",@"时尚男装",@"美食饮料",@"居家生活",@"虚拟充值"];
    
    ShowMenu *menu = [[ShowMenu alloc]initWithFrame:CGRectMake(100, 100, 200, 35) Data:addData];
    [self.view addSubview:menu];
    
    [menu setValuechangeBlock:^(NSString *text)
     {
      
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
