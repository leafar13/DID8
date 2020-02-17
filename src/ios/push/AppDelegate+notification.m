//
//  AppDelegate+notification.m
//
// Disclaimer
// © 2019, Cyxtera Cybersecurity, Inc. d/b/a AppGate.  All rights reserved.  

// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met: 
// (a) redistributions of source code must retain the above copyright notice, this list of conditions and the disclaimer below, and (b) 
// redistributions in binary form must reproduce the above copyright notice, this list of conditions and the disclaimer below in the documentation
// and/or other materials provided with the distribution. 

// THE CODE AND SCRIPTS POSTED ON THIS WEBSITE ARE PROVIDED ON AN “AS IS” BASIS AND YOUR USE OF SUCH CODE AND/OR SCRIPTS IS AT YOUR OWN RISK.  
// APPGATE DISCLAIMS ALL EXPRESS AND IMPLIED WARRANTIES, EITHER IN FACT OR BY OPERATION OF LAW, STATUTORY OR OTHERWISE, INCLUDING, BUT NOT LIMITED TO, 
// ALL WARRANTIES OF MERCHANTABILITY, TITLE, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, ACCURACY, COMPLETENESS, COMPATABILITY OF SOFTWARE OR 
// EQUIPMENT OR ANY RESULTS TO BE ACHIEVED THEREFROM.  APPGATE DOES NOT WARRANT THAT SUCH CODE AND/OR SCRIPTS ARE OR WILL BE ERROR-FREE.  
// IN NO EVENT SHALL APPGATE BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, RELIANCE, EXEMPLARY, PUNITIVE OR CONSEQUENTIAL DAMAGES, OR ANY LOSS 
// OF GOODWILL, LOSS OF ANTICIPATED SAVINGS, COST OF PURCHASING REPLACEMENT SERVICES, LOSS OF PROFITS, REVENUE, DATA OR DATA USE, ARISING IN ANY WAY OUT 
// OF THE USE AND/OR REDISTRIBUTION OF SUCH CODE AND/OR SCRIPTS, REGARDLESS OF THE LEGAL THEORY UNDER WHICH SUCH LIABILITY IS ASSERTED AND REGARDLESS 
// OF WHETHER APPGATE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH LIABILITY.
//

#import "AppDelegate+notification.h"
#import <objc/runtime.h>
#import <didm_auth_sdk_iOS/didm_auth_sdk_iOS.h>
#import "DIDPluginTransactionOpenListener.h"
#import "DIDPluginPushAlertOpenListener.h"

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

static char launchNotificationKey;

@implementation AppDelegate (notification)

- (id) getCommandInstance:(NSString*)className
{
    return [self.viewController getCommandInstance:className];
}

+ (void)load
{
    Method original, swizzled;
    
    original = class_getInstanceMethod(self, @selector(init));
    swizzled = class_getInstanceMethod(self, @selector(swizzled_init));
    method_exchangeImplementations(original, swizzled);
}

- (AppDelegate *)swizzled_init
{
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
                                                                                         | UIUserNotificationTypeAlert
                                                                                         | UIUserNotificationTypeSound)
                                                                             categories:[[DetectID sdk] getNotificationActionCategoriesForNotifications] ];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

    return [self swizzled_init];
}

- (void)createNotificationChecker:(NSNotification *)notification {
    
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
                
            }
        }];
        [center setNotificationCategories:[[DetectID sdk] getUNNotificationActionCategoriesForNotifications]];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[[DetectID sdk] PUSH_API] setPushTransactionOpenDelegate:self];
    [[[DetectID sdk] PUSH_API] setPushAlertOpenDelegate:self];
    [[[DetectID sdk] PUSH_API] enablePushTransactionServerResponseAlerts:NO];
    
    
     PushTransactionViewProperties* pushTransactionVP = [[PushTransactionViewProperties alloc]init];
     pushTransactionVP.CONFIRM =  @"Confirm";
     pushTransactionVP.DECLINE =  @"Cancel";
     pushTransactionVP.ENABLE_NOTIFICATION_QUICK_ACTIONS = YES;
     
     [[[DetectID sdk] PUSH_API] setPushTransactionViewProperties: pushTransactionVP];
     
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [[DetectID sdk] receivePushServiceId:deviceToken];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{
    //error handling
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"didReceiveRemoteNotification");
        
        [[[DetectID sdk] PUSH_API] enablePushTransactionDefaultDialog:false];
        [[[DetectID sdk] PUSH_API] enablePushAlertDefaultDialog:false];
        
        [[DetectID sdk]subscribePayload:userInfo];
    });
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    
    [[DetectID sdk] handleActionWithIdentifier:identifier forNotification:userInfo]; completionHandler();
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    dispatch_async(dispatch_get_main_queue(), ^{

        [[[DetectID sdk] PUSH_API] enablePushTransactionDefaultDialog:false];
        [[[DetectID sdk] PUSH_API] enablePushAlertDefaultDialog:false];
        
        [[DetectID sdk] subscribePayload:notification withCompletionHandler:completionHandler];
    });
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    [[DetectID sdk] handleActionWithIdentifier:response];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [[DetectID sdk] deviceRegistrationByCode:[url query]];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"active");
}

- (NSMutableArray *)launchNotification{
    return objc_getAssociatedObject(self, &launchNotificationKey);
}

- (void)setLaunchNotification:(NSDictionary *)aDictionary{
    objc_setAssociatedObject(self, &launchNotificationKey, aDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)dealloc{
    self.launchNotification    = nil;
}

- (void)onPushTransactionOpen:(TransactionInfo *)transaction {
    
    DIDPluginTransactionOpenListener* pluginTransactionOpen = [DIDPluginTransactionOpenListener sharedInstance];
    
    pluginTransactionOpen.transactionInfo = transaction;
}

- (void)onPushAlertOpen:(TransactionInfo *)transaction {
    DIDPluginPushAlertOpenListener* pluginAlertOpen = [DIDPluginPushAlertOpenListener sharedInstance];
    
    pluginAlertOpen.transactionInfo = transaction;
}

@end
