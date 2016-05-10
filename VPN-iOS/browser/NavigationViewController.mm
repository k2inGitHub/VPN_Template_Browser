//
// Created by sail on 10/22/13.
// Copyright (c) 2013 sail. All rights reserved.
//


#import "NavigationViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "ShareViewController.h"
#import "SettingViewController.h"
#import "BookmarkViewController.h"
#import "PageViewController.h"
#import "HLService.h"

@implementation NavigationViewController {
  UITableView *_tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
      if([HLInterface sharedInstance].market_reviwed_status==1){
          return 10;
      }
    return 4;
  }
  else if (section == 1) {
    NSArray *history = [[NSUserDefaults standardUserDefaults] arrayForKey:@"history"];
    return [history count];
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.section == 0) {
      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      [cell addSubview:button];

      [button setImage:[UIImage imageNamed:@"btn_pressed"] forState:UIControlStateHighlighted];
      [button setImage:[UIImage imageNamed:@"btn_unpressed"] forState:UIControlStateHighlighted];
      UIImageView *subImageView = nil;

        if([HLInterface sharedInstance].market_reviwed_status==1){
            switch (indexPath.row) {
                case 0:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share_btn_bt"]];
                    break;
                case 1:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"girl-body_btn"]];
                    break;
                case 2:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"girl-secret_btn"]];
                    break;
                case 3:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanning_btn"]];
                    break;
                case 4:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"video_btn"]];
                    break;
                case 5:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"girl-room_btn"]];
                    break;
                case 6:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red-money_btn"]];
                    break;
                case 7:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"startpage_btn", @"startpage_btn")]];
                    break;
                case 8:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"bookmark_btn", @"bookmark_btn")]];
                    break;
                case 9:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"passwrd_btn", @"passwrd_btn")]];
                    break;
                default:
                    cell.textLabel.text = @"nothing";
                    break;
            }
        }
        else{
            
            switch (indexPath.row) {
                case 0:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"startpage_btn", @"startpage_btn")]];
                    break;
                case 1:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"share_btn", @"share_btn")]];
                    break;
                case 2:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"bookmark_btn", @"bookmark_btn")]];
                    break;
                case 3:
                    subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"passwrd_btn", @"passwrd_btn")]];
                    break;
                default:
                    cell.textLabel.text = @"nothing";
                    break;
            }
        }
      [button addSubview:subImageView];
      subImageView.center = CGPointMake(subImageView.center.x, 20);
    }
    else if(indexPath.section==1){
      NSArray *history = [[NSUserDefaults standardUserDefaults] arrayForKey:@"history"];
      NSDictionary *urlDict = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"history_url"];
//      HistoryItem *historyItem = [history objectAtIndex:(NSUInteger) indexPath.row];
      NSString *url = [history objectAtIndex:(NSUInteger) indexPath.row];
      UILabel *titleLabel = [[UILabel alloc] init];
      titleLabel.text = [urlDict objectForKey:url];
      [titleLabel sizeToFit];
      [titleLabel setTextAlignment:NSTextAlignmentCenter];
      [cell addSubview:titleLabel];


      UILabel *linkLabel = [[UILabel alloc] init];
      linkLabel.text = url;
      [linkLabel sizeToFit];
      [linkLabel setTextAlignment:NSTextAlignmentCenter];
      [cell addSubview:linkLabel];
      linkLabel.center = CGPointMake(linkLabel.center.x, linkLabel.center.y + 20);
      cell.frame.size = CGSizeMake(linkLabel.frame.size.width, titleLabel.frame.size.height + linkLabel.frame.size
        .height);
//      cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@", title, link];
    }
  }
  return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"title_label", @"title_label")]];
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];

  _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

  _tableView.delegate = self;
  _tableView.dataSource = self;
  [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  NSLog(@"apprea");
  [_tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UINavigationController *centerVC = (UINavigationController *) self.mm_drawerController.centerViewController;
  if (indexPath.section == 0) {
      NSString* address = nil;
      
      if([HLInterface sharedInstance].market_reviwed_status==1){
          switch (indexPath.row) {
              case 0:
                  [centerVC popToRootViewControllerAnimated:NO];
                  [centerVC pushViewController:[[ShareViewController alloc] init] animated:NO];
                  break;
              case 1:
                  [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ShowFullScreen"];
                  break;
              case 2:
                  [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ShowFullScreen"];
                  break;
              case 3:
                  [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ShowFullScreen"];
                  break;
              case 4:
                  [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ShowFullScreen"];
                  break;
              case 5:
                  address=[HLAnalyst stringValue:@"ButtonAddress1"];
                  if(address==nil){
                      address=@"https://itunes.apple.com/cn/app/mei-mei-fang-jian-shi-shang/id1062516606?l=en&mt=8";
                  }
                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:address]];
                  break;
              case 6:
                  address=[HLAnalyst stringValue:@"ButtonAddress2"];
                  if(address==nil){
                      address=@"https://itunes.apple.com/cn/app/reckless-die-racing-earn-for/id1057853596?l=en&mt=8";
                  }
                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:address]];
                  break;
              case 7:
                  [centerVC popToRootViewControllerAnimated:NO];
                  break;
              case 8:
                  [centerVC popToRootViewControllerAnimated:NO];
                  [centerVC pushViewController:[[BookmarkViewController alloc] init] animated:NO];
                  break;
              case 9:
                  [centerVC popToRootViewControllerAnimated:NO];
                  [centerVC pushViewController:[[SettingViewController alloc] init] animated:NO];
                  break;
              default:
                  break;
          }
      }
      else{
          switch (indexPath.row) {
              case 0:
                  [centerVC popToRootViewControllerAnimated:NO];
                  break;
              case 1:
                  [centerVC popToRootViewControllerAnimated:NO];
                  [centerVC pushViewController:[[ShareViewController alloc] init] animated:NO];
                  break;
              case 2:
                  [centerVC popToRootViewControllerAnimated:NO];
                  [centerVC pushViewController:[[BookmarkViewController alloc] init] animated:NO];
                  break;
              case 3:
                  [centerVC popToRootViewControllerAnimated:NO];
                  [centerVC pushViewController:[[SettingViewController alloc] init] animated:NO];
                  break;
              default:
                  break;
          }
      }
  }
  else if (indexPath.section == 1) {
    NSArray *history = [[NSUserDefaults standardUserDefaults] arrayForKey:@"history"];

    NSString *url = [history objectAtIndex:(NSUInteger) indexPath.row];

    [centerVC popToRootViewControllerAnimated:NO];

    [centerVC pushViewController:[[PageViewController alloc] initWithURL:[[NSURL alloc] initWithString:url]
                                                                needSave:NO] animated:NO];
  }
    

    if([HLInterface sharedInstance].market_reviwed_status==1){
        if(indexPath.row<=6&&indexPath.row>0){
            return;
        }
    }

  NSLog(@"%d", indexPath.row);
  [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//  return 0;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//  return nil;
//}
@end