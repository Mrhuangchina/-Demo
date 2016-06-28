//
//  ShowMenu.m
//  下拉菜单Demo
//
//  Created by hzzc on 16/6/28.
//  Copyright © 2016年 hzzc. All rights reserved.
//


#import "ShowMenu.h"

static NSString *CellID = @"identifier";

@implementation ShowMenu

-(instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)data{
    
        self.data =[NSArray arrayWithArray:data];
    
   return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreateUIWithFrame:frame];
    }
    return self;
}


-(void)CreateUIWithFrame:(CGRect)frame{
    
    self.MenuField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.MenuField.placeholder = @"请选择你需要的产品";
    self.MenuField.font = [UIFont systemFontOfSize:17];
    self.MenuField.rightViewMode = UITextFieldViewModeAlways;
    self.MenuField.leftViewMode = UITextFieldViewModeAlways;
//    self.MenuField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.MenuField.delegate = self;
    [self addSubview:self.MenuField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"arrow@2x.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, frame.size.width / 8, frame.size.height);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.MenuField setRightView:button];
    
    self.MenuTable = [[UITableView alloc]initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 0) style:UITableViewStylePlain];
    self.MenuTable.delegate = self;
    self.MenuTable.dataSource = self;
    self.MenuTable.layer.borderColor = [UIColor grayColor].CGColor;
    self.MenuTable.layer.borderWidth = 0.3;
    self.MenuTable.layer.shadowColor = [UIColor grayColor].CGColor;
    self.MenuTable.backgroundColor = [UIColor clearColor];
    self.MenuTable.layer.masksToBounds = YES;
    [self.MenuTable resignFirstResponder];
    [self addSubview:self.MenuTable];
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.layer setBorderWidth:0.3];
    [self.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.layer setMasksToBounds:YES];
    [self.layer setShadowColor:[UIColor grayColor].CGColor];
 
    self.clipsToBounds = NO;
    self.status = MenuStatus_DisMiss;
    [self.MenuTable resignFirstResponder];
    
}


-(void)buttonAction{

    if (self.status == MenuStatus_Show) {
        [self MenuDismiss];
    }else{
        [self MenuShow];
    }

}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *vi = [super hitTest:point withEvent:event];
    if (vi == nil) {
        CGPoint pointView = [self.MenuTable convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.MenuTable.bounds, pointView)) {
            vi = self.MenuTable;
        }
    }

    return vi;
};

-(void)MenuShow{

  [UIView animateWithDuration:0.3 animations:^{
      
      self.MenuField.rightView.transform = CGAffineTransformMakeRotation(M_PI);
      
  } completion:^(BOOL finished) {
      
      [UIView animateWithDuration:0.3 animations:^{
          self.MenuTable.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height * self.data.count);
          self.status = MenuStatus_Show;
      }];
      
  }];
    
}

-(void)MenuDismiss{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.MenuField.rightView.transform = CGAffineTransformMakeRotation(0);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.MenuTable.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 0);
            self.status = MenuStatus_DisMiss;
        }];
    }];

}

#pragma mark - TextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.status == MenuStatus_Show) {
        [self MenuDismiss];
    }else{
        [self MenuShow];
    }
    
    return NO;
}


#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return self.frame.size.height;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (Cell == nil) {
        
        Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        
        Cell.textLabel.text = self.data[indexPath.row];
        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        Cell.backgroundColor = [UIColor clearColor];
        Cell.backgroundView = nil;
        Cell.textLabel.textColor = [UIColor blackColor];
        Cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self MenuDismiss];
    
    self.MenuField.text = self.data[indexPath.row];
    if (self.ValuechangeBlock) {
        
        self.ValuechangeBlock(self.MenuField.text);
        
    }

}
@end
