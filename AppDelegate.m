//
//  AppDelegate.m
//  ScanLanDemo
//
//  Created by Kevin--Xue on 2020/7/25.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ViewController *vc = [[ViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    return YES;
}




@end
