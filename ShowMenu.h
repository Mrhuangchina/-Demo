//
//  ShowMenu.h
//  下拉菜单Demo
//
//  Created by hzzc on 16/6/28.
//  Copyright © 2016年 hzzc. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ShowMenu : UIView <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

typedef void(^TextBlock)(NSString *text);

typedef NS_ENUM(NSInteger,Menustatus) {
    
    MenuStatus_Show = 0,
    MenuStatus_DisMiss = 1
    
};

@property(nonatomic,strong)UITextField *MenuField;
@property(nonatomic,strong)UITableView *MenuTable;
@property(nonatomic,copy)NSArray *data;
@property(nonatomic,assign)NSInteger status;

@property(nonatomic,copy)TextBlock ValuechangeBlock;

-(instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)data;
-(void)MenuShow;
-(void)MenuDismiss;



@end
