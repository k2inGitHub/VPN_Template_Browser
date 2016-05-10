//
// Created by sail on 10/22/13.
// Copyright (c) 2013 sail. All rights reserved.
//


#import "MMDrawerController.h"
#import "PSTCollectionView.h"
#import "ShareViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "BookmarkCellView.h"
#import "PageViewController.h"
#import "HLService.h"
//#import "UnityAdvertise.h"
//#import "HandloftInterface.h"


@implementation ShareViewController {
  NSDictionary *_bookmarks;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
  if ([language isEqualToString:@"en"]) {
    _bookmarks = @{
      @"http://tumblr.com/" : @"Tumblr",
      @"http://CNET.com/" : @"CNET",
      @"http://reddit.com/" : @"Reddit",
      @"http://techcrunch.com/" : @"TechCrunch",
      @"http://huffingtonpost.com/" : @"Huffington",
      @"http://imgur.com/" : @"Imgur",
      @"http://www.google.com/" : @"Google",
      @"http://agoda.com/" : @"Agoda",
      @"http://facebook.com/" : @"Facebook",
      @"http://youtube.com/" : @"YouTube",
      @"http://yahoo.com/" : @"Yahoo!",
      @"http://amazon.com/" : @"Amazon",
      @"http://linkedin.com/" : @"LinkedIn",
      @"http://wikipedia.org/" : @"Wikipedia",
      @"http://bing.com/" : @"Bing",
      @"http://craigslist.org/" : @"Craigslist",
      @"http://ebay.com/" : @"eBay",
      @"http://twitter.com/" : @"Twitter",
      @"http://blogspot.com/" : @"Blogspot",
      @"http://live.com/" : @"Live",
      @"http://pinterest.com/" : @"Pinterest",
      @"http://go.com/" : @"Go",
      @"http://cnn.com/" : @"CNN",
      @"http://msn.com/" : @"MSN",
      @"http://paypal.com/" : @"PayPal",
      @"http://aol.com/" : @"AOL",
      @"http://wordpress.com/" : @"WordPress",
      @"http://instagram.com" : @"instagram",
      @"http://netflix.com/" : @"Netflix",
      @"http://espn.go.com/" : @"ESPN"
    };
  }
  else {
    _bookmarks = @{
      @"http://www.qyer.com/" : @"穷游",
      @"http://www.asmou.cn/" : @"全美视频",
      @"http://music.baidu.com/" : @"百度音乐",
      @"http://www.eastmoney.com/" : @"东方财富网",
      @"http://xueqiu.com/" : @"雪球",
      @"http://bbs.weiphone.com/" : @"威锋论坛",
      @"http://www.leiphone.com/" : @"雷锋网",
      @"http://www.hunantv.com/" : @"芒果台",
      @"http://www.gao7.com/free/1-0-0-3-0-0-1" : @"限时免费",
      @"http://www.qunar.com/" : @"去哪儿",
      @"http://www.dianping.com/" : @"点评网",
      @"http://www.sina.com.cn/" : @"新浪",
      @"http://www.xcar.com.cn/bbs/" : @"爱卡论坛",
      @"http://www.huxiu.com/" : @"虎嗅",
      @"http://tieba.baidu.com/" : @"百度贴吧",
      @"http://www.hao123.com/college_bbs.htm/" : @"大学论坛",
      @"http://www.163.com/" : @"163.com",
      @"http://www.ipc.me/" : @"IPC分享",
      @"http://www.hao123.com/" : @"hao123",
      @"http://www.weiphone.com/" : @"weiphone",
      @"http://www.mafengwo.cn/" : @"马蜂窝",
      @"http://www.qidian.com/" : @"起点",
      @"http://www.jd.com/" : @"京东",
      @"http://www.taobao.com/" : @"淘宝",
      @"http://www.sina.com.cn/" : @"新浪",
      @"http://www.youku.com/" : @"优酷",
      @"http://news.sohu.com/" : @"搜狐新闻",
      @"http://www.autohome.com.cn/" : @"汽车之家",
      @"http://www.163.com/" : @"网易",
      @"http://www.meishichina.com/" : @"美食天下"
    };
  }
  self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"share_label", @"share_label")]];
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];

  MMDrawerBarButtonItem *leftDrawerBarItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
  self.navigationItem.leftBarButtonItem = leftDrawerBarItem;

//  self.view.backgroundColor = [UIColor whiteColor];
  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];

//  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"web_bg"]];
//  imageView.frame = CGRectMake(20, 100, 100, 100);
//  [self.view addSubview:imageView];
//  [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"web_bg"]]];

  PSTCollectionView *collectionView = [[PSTCollectionView alloc] initWithFrame:self.view.frame
                                                          collectionViewLayout:[[PSTCollectionViewFlowLayout alloc]
                                                            init]];
  [collectionView registerClass:[BookmarkCellView class] forCellWithReuseIdentifier:@"collection_cell"];
  collectionView.delegate = self;
  collectionView.dataSource = self;

  collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
  self.view = collectionView;
}

- (void)leftDrawerButtonPress:(id)leftDrawerButtonPress {
  NSLog(@"left");
  [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (NSInteger)collectionView:(PSTCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [_bookmarks count];
}

- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)
  indexPath {
  BookmarkCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection_cell"
                                                                     forIndexPath:indexPath];
  NSString *title = [[_bookmarks allValues] objectAtIndex:(NSUInteger) indexPath.row];

    if([HLInterface sharedInstance].market_reviwed_status==1){
        if(indexPath.row==0){
            title = @"小电影";
            NSString* ti=[HLAnalyst stringValue:@"ButtonText1" defaultValue:nil];
            if(ti!=nil){
                title=ti;
            }
        }
        if(indexPath.row==1){
            title = @"未上锁的房间";
            NSString* ti=[HLAnalyst stringValue:@"ButtonText2" defaultValue:nil];
            if(ti!=nil){
                title=ti;
            }

        }
        if(indexPath.row==2){
            title = @"丝袜情趣";
            NSString* ti=[HLAnalyst stringValue:@"ButtonText3" defaultValue:nil];
            if(ti!=nil){
                title=ti;
            }

        }
    }

  cell.title.text = title;

  return cell;
}

- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(100, 100);
}

- (UIEdgeInsets)               collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewLayout *)
  collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(5, 0, 5, 0);
}

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if([HLInterface sharedInstance].market_reviwed_status==1){
        if(indexPath.row==0){
            [[HLAdManager sharedInstance] showEncourageInterstitial];
            return;
        }
        if(indexPath.row==1){
            NSString* address=[HLAnalyst stringValue:@"ButtonAddress3"];
            if(address==nil){
                address=@"https://itunes.apple.com/cn/app/wei-shang-suo-fang-jian-zhong/id1060518418?l=en&mt=8";
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:address]];
            return;
        }
        if(indexPath.row==2){
            [[HLAdManager sharedInstance] showUnsafeInterstitial];
            return;
        }
    }
    
  NSString *urlStr = [_bookmarks.allKeys objectAtIndex:(NSUInteger) indexPath.row];
  [self.navigationController pushViewController:[[PageViewController alloc] initWithURL:[[NSURL alloc]
    initWithString:urlStr]                                                     needSave:NO] animated:YES];

  NSLog(@"%@", [_bookmarks.allKeys objectAtIndex:(NSUInteger) indexPath.row]);
  NSLog(@"%d", indexPath.row);
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end