//
// Created by sail on 10/20/13.
// Copyright (c) 2013 sail. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface BrowserViewController : UIViewController <UITextFieldDelegate, UIWebViewDelegate>
@property(strong, nonatomic) UITextField *textField;

@end