//
// Created by sail on 10/22/13.
// Copyright (c) 2013 sail. All rights reserved.
//


#import "SettingViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "KKPasscodeSettingsViewController.h"

@implementation SettingViewController {

}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"setting_label", @"setting_label")]];
  MMDrawerBarButtonItem *leftDrawerBarItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
  self.navigationItem.leftBarButtonItem = leftDrawerBarItem;
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];

  self.view.backgroundColor = [UIColor whiteColor];
  UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"logo", @"logo")]];
  logoImageView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    
    //去掉狼logo
 // [self.view addSubview:logoImageView];

  UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  UIImage *explainImg = [UIImage imageNamed:NSLocalizedString(@"explain", @"explain")];
  [explainBtn setImage:explainImg forState:UIControlStateNormal];
  explainBtn.frame = CGRectMake((self.view.frame.size.width - explainImg.size.width) / 2, 300, explainImg.size.width,
    explainImg.size.height);
  [explainBtn addTarget:self action:@selector(explainBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:explainBtn];

  UIButton *psdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  UIImage *psdImg = [UIImage imageNamed:NSLocalizedString(@"password", @"password")];
  [psdBtn setImage:psdImg forState:UIControlStateNormal];
  psdBtn.frame = CGRectMake((self.view.frame.size.width - psdImg.size.width) / 2, 250, psdImg.size.width,
    psdImg.size.height);
  [psdBtn addTarget:self action:@selector(passwordBtnPressed:) forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:psdBtn];


}

- (void)explainBtnPressed:(id)sender {
  NSLog(@"explain");
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLog(@"Preferred Language:%@", preferredLang);
    
    NSString * title =@"";
    NSString * msg =@"";
    NSString * ok=@"";
    if ([preferredLang isEqualToString:@"zh-Hans"]) {//1为中文
       
        title=@"使用说明";
        msg=@"设置密码可以保护您的隐私。当开启密码保护后，开启删除所有数据开关，在密码输入错误5次时会自动清空用户所加载的内容。";
        ok=@"确定";
    }else{//0为英文
        title=@"Instructions for use";
        msg=@"You can set a password to protect your privacy. When you turn on password protection, open delete all data, five times in the password input error is automatically cleared the user loads the contents of the.";
        ok=@"ok";
        
    }
   
    UIAlertView * messageBox = [[UIAlertView alloc] initWithTitle: title
                                                          message: msg
                                                         delegate: nil
                                                cancelButtonTitle: ok
                                                otherButtonTitles: nil];
    
    [messageBox show];
   
   

}

- (void)rateBtnPressed:(id)sender {
  NSLog(@"rate");
    NSLog(@"rate");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/lang-you-she-qu-liu-lan-qi/id744877201?ls=1&mt=8"]];
}

- (void)passwordBtnPressed:(id)sender {
//  [self.navigationController pushViewController:[[PasswordViewController alloc]init] animated:YES];
    [self.navigationController pushViewController:[[KKPasscodeSettingsViewController alloc] init] animated:YES];
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ShowFullScreen"];
}

- (void)leftDrawerButtonPress:(id)sender {
  [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end