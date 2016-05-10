//
// Created by sail on 10/24/13.
// Copyright (c) 2013 sail. All rights reserved.
//


#import "PasswordViewController.h"
#import "EnablePSWViewConrtroller.h"


@implementation PasswordViewController {

}

- (void)viewDidLoad {
  [super viewDidLoad];

 self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_label"]];

//   self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"password_label", @"password_label")]];
  [self.view setBackgroundColor:[UIColor grayColor]];

  UIButton *pswEnableBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [pswEnableBtn setImage:[UIImage imageNamed:@"psw_enable_btn"] forState:UIControlStateNormal];
  [pswEnableBtn setImage:[UIImage imageNamed:@"psw_disable_btn"] forState:UIControlStateHighlighted];
  pswEnableBtn.frame = CGRectMake(10, 100, 300, 48);
  [self.view addSubview:pswEnableBtn];
  [pswEnableBtn addTarget:self action:@selector(enablePswPressed:) forControlEvents:UIControlEventTouchUpInside];

  UIButton *pswModifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [pswModifyBtn setImage:[UIImage imageNamed:@"psw_modify_btn"] forState:UIControlStateNormal];
  [pswModifyBtn setImage:[UIImage imageNamed:@"psw_modify_disable"] forState:UIControlStateHighlighted];
  pswModifyBtn.frame = CGRectMake(10, 150, 300, 48);
  [self.view addSubview:pswModifyBtn];

  UIButton *deleteDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [deleteDataBtn setImage:[UIImage imageNamed:@"delete_data_btn"] forState:UIControlStateNormal];
  [deleteDataBtn setImage:[UIImage imageNamed:@"delete_data_disable"] forState:UIControlStateHighlighted];
  deleteDataBtn.frame = CGRectMake(10, 200, 300, 48);
  [self.view addSubview:deleteDataBtn];
}

- (void)enablePswPressed:(id)sender {
  [self.navigationController pushViewController:[[EnablePSWViewConrtroller alloc] init] animated:YES];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end