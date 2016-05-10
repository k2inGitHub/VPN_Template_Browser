//
// Created by sail on 10/20/13.
// Copyright (c) 2013 sail. All rights reserved.
//


#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "BrowserViewController.h"
#import "PageViewController.h"

static BOOL OSVersionIsAtLeastiOS7() {
    return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1);
}

@implementation BrowserViewController {
  UIWebView *_webView;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"browser_label", @"browser_label")]];
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];

  MMDrawerBarButtonItem *leftDrawerBarItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
  [self.navigationItem setLeftBarButtonItem :leftDrawerBarItem];

  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
  UILabel *httpLabel;
  if (OSVersionIsAtLeastiOS7()) {
    httpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 57, 50, 50)];
  }
  else {
    httpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 50)];
  }
  httpLabel.text = @"http://";
  [httpLabel setBackgroundColor:[UIColor clearColor]];
  [self.view addSubview:httpLabel];

  if (OSVersionIsAtLeastiOS7()) {
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(70, 67, 180, 30)];
  }
  else {
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(70, 10, 180, 30)];
  }
  [_textField setBackgroundColor:[UIColor whiteColor]];
  [_textField setBorderStyle:UITextBorderStyleRoundedRect];
  [_textField setClearButtonMode:UITextFieldViewModeAlways];
  [_textField setKeyboardType:UIKeyboardTypeURL];
  [_textField setReturnKeyType:UIReturnKeyGo];
  _textField.delegate = self;
  [_textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
  [self.view addSubview:_textField];
    _textField.text = @"";

  UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [goBtn setImage:[UIImage imageNamed:@"btn_go"] forState:UIControlStateNormal];
  if (OSVersionIsAtLeastiOS7()) {
    goBtn.frame = CGRectMake(250, 57, 50, 50);
  }
  else {
    goBtn.frame = CGRectMake(250, 0, 50, 50);
  }
  [goBtn addTarget:self action:@selector(goBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:goBtn];

  if (OSVersionIsAtLeastiOS7()) {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100,
      self.view.frame.size.width,
      self.view.frame.size.height - self.navigationController.toolbar.frame.size.height - 50)];
    _webView.delegate = self;
  }
  else {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50,
      self.view.frame.size.width,
      self.view.frame.size.height - self.navigationController.toolbar.frame.size.height - 50)];
    _webView.delegate = self;
  }
  [self.view addSubview:_webView];

    //kt
//  NSString *htmlFile = [[NSBundle mainBundle] pathForResource:NSLocalizedString(@"nav_en", @"nav_en") ofType:@"html"];
//  NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
//  [_webView loadHTMLString:htmlString baseURL:nil];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [_textField resignFirstResponder];
}


- (void)goBtnPressed:(id)goBtnPressed {
    
    
  [self navigateToURL];

  [_textField resignFirstResponder];
    
}

- (void)navigateToURL {
  if ([_textField.text characterAtIndex:_textField.text.length - 1] != '/') {
    _textField.text = [_textField.text stringByAppendingString:@"/"];
  }
    
    
  PageViewController *pageViewController =
    [[PageViewController alloc] initWithURL:[[NSURL alloc] initWithString:[@"http://"
      stringByAppendingString:_textField.text]] needSave:YES];
  [self.navigationController pushViewController:pageViewController animated:YES];
}

- (void)leftDrawerButtonPress:(id)leftDrawerButtonPress {
  NSLog(@"left");
  [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
  [_textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self navigateToURL];
  [_textField resignFirstResponder];
  return NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  if (navigationType == UIWebViewNavigationTypeLinkClicked) {
    PageViewController *pageViewController =
      [[PageViewController alloc] initWithURL:request.URL needSave:YES];
    [self.navigationController pushViewController:pageViewController animated:YES];
    return NO;
  }
  return YES;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end