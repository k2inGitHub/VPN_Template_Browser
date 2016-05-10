//
// Created by sail on 10/22/13.
// Copyright (c) 2013 sail. All rights reserved.
//


#import "MMDrawerBarButtonItem.h"
#import "MMDrawerController.h"
#import "BookmarkViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "KKPasscodeLock.h"
#import "BookmarkCellView.h"
#import "PageViewController.h"
#import "PSTCollectionView.h"

@implementation BookmarkViewController {

}
- (void)loadView {
  [super loadView];
  if ([[KKPasscodeLock sharedLock] isPasscodeRequired]) {
    KKPasscodeViewController *vc = [[KKPasscodeViewController alloc] initWithNibName:nil bundle:nil];
    vc.mode = KKPasscodeModeEnter;
    vc.delegate = (id <KKPasscodeViewControllerDelegate>) [[UIApplication sharedApplication] delegate];
    [self presentViewController:vc animated:NO completion:nil];
  }
}


- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"bookmark_label", @"bookmark_label")]];
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];

  MMDrawerBarButtonItem *leftDrawerBarItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
  [self.navigationItem setLeftBarButtonItem:leftDrawerBarItem];

//  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];

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
  NSDictionary *bookmarks = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"bookmarks"];
  NSLog(@"%d", [bookmarks count]);
  return [bookmarks count];
}

- (PSTCollectionViewCell *)collectionView:(PSTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  BookmarkCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection_cell"
                                                                     forIndexPath:indexPath];
  NSDictionary *bookmarks = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"bookmarks"];
  NSString *title = [[bookmarks allValues] objectAtIndex:(NSUInteger) indexPath.row];
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
  NSDictionary *bookmarks = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"bookmarks"];
  NSString *urlStr = [bookmarks.allKeys objectAtIndex:(NSUInteger) indexPath.row];
  [self.navigationController pushViewController:[[PageViewController alloc] initWithURL:[[NSURL alloc]
    initWithString:urlStr]                                                     needSave:YES] animated:YES];

  NSLog(@"%@", [bookmarks.allKeys objectAtIndex:(NSUInteger) indexPath.row]);
  NSLog(@"%d", indexPath.row);
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end