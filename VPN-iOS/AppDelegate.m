//
//  AppDelegate.m
//  VPN-iOS
//
//  Created by 宋扬 on 16/2/22.
//  Copyright © 2016年 handloft. All rights reserved.
//

#import "AppDelegate.h"
#import "VPNManager.h"
#import "HLService.h"
#import "VPNPageController.h"
#import "NSUserDefaults+KTAdditon.h"
#import "VPNAlertView.h"
#import "UINavigationController+KeyboardDismiss.h"
#import "UIImage+LaunchImage.h"
#import "BrowserViewController.h"
#import "NavigationViewController.h"
#import "MMDrawerController.h"


@interface AppDelegate ()
//根视图控制器 选择nav是基于加载广告、请求接口、拼接loading等需要
@property (nonatomic, strong) UINavigationController *rootNavigationController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //创建loading
    [self createLoadingView];
    [self.window makeKeyAndVisible];
    
    //请求接口
    [[HLInterface sharedInstance] startGet];
    //统计分析
    [HLAnalyst start];
    //加载广告
    [HLAdManager sharedInstance];
    
    [[HLLocalNotificationCenter sharedCenter] registerUserNotification];
    
    return YES;
}

//进入主逻辑视图控制器
- (void)createMainController {
    //goto
    BOOL flag = [HLInterface sharedInstance].girl_start == 1;
    if (!flag) {
        //马甲入口
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"history"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"history_url"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIViewController *vc1 = [[BrowserViewController alloc] init];
        UINavigationController *centerViewController = [[UINavigationController alloc]
                                                        initWithRootViewController:vc1];
        
        UIViewController *vc2 = [[NavigationViewController alloc] init];
        UINavigationController *leftViewController = [[UINavigationController alloc]
                                                      initWithRootViewController:vc2];
        
        MMDrawerController *drawerController = [[MMDrawerController alloc]
                            initWithCenterViewController:centerViewController
                            leftDrawerViewController:leftViewController
                            rightDrawerViewController:nil];
     
        
        drawerController.maximumLeftDrawerWidth = 200.f;
        drawerController.maximumRightDrawerWidth = 200.f;
        [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        [drawerController openDrawerSide:MMDrawerSideLeft animated:NO completion:nil];
        [_rootNavigationController setViewControllers:@[drawerController] animated:NO];
        [HLStartLogic start];
    } else {
        //产品入口
        BOOL flag = [HLAnalyst boolValue:@"vpn_favor_switch" defaultValue:YES];
        UIViewController *pageController = (![VPNManager sharedManager].hasFavor && flag) ? [[UIStoryboard storyboardWithName:@"VPN" bundle:nil] instantiateInitialViewController] : [[UIStoryboard storyboardWithName:@"VPN" bundle:nil] instantiateViewControllerWithIdentifier:@"page"];

        [_rootNavigationController setViewControllers:@[pageController] animated:NO];
    }
}
//loading结束回调
- (void)onLoadingFinish{
    [self createMainController];
    [[HLAdManager sharedInstance] showBanner];
}
//创建loading视图与根视图
- (void)createLoadingView{

    //loading
    UIViewController *loadingController = [[UIViewController alloc] init];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage launchImage:YES]];
    [loadingController.view addSubview:imageView];
    
    _rootNavigationController = [[UINavigationController alloc] initWithRootViewController:loadingController];
    _rootNavigationController.navigationBarHidden = YES;
    self.window.rootViewController = _rootNavigationController;
    
    //goto
    [self performSelector:@selector(onLoadingFinish) withObject:nil afterDelay:8];//8];
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //仿unity通知 免去unity打包多余代码
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kUnityDidReceiveLocalNotification" object:self userInfo:(id)notification];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //unity脚本里主动调用
    [[HLLocalNotificationCenter sharedCenter] schedeuleAll];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
