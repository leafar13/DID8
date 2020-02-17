//
//  DIDPluginManager.m
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

#import "DIDPlugAccountsApi.h"
#import "DIDPlugServerHelper.h"
#import "DIDPlugHelper.h"
#import "DIDPlugExceptionsHelper.h"
#import "DIDPlugRegistrationApi.h"
#import "DIDPlugConstantsHelper.h"

@implementation DIDPlugAccountsApi
{
    __block DIDPlugAccountsApi* pluginManager;
}

- (instancetype)init {
    return [super init];
}

- (void)getAccounts: (CDVInvokedUrlCommand*)command {
    __block DIDPlugAccountsApi* pluginBlock = self;
    
    @try {
        __block CDVPluginResult* pluginResult;
        __block CDVInvokedUrlCommand* commandBlock = command;
        
        NSArray *accounts = [[DetectID sdk] getAccounts];

        NSMutableArray *jsonArray = [NSMutableArray new];
        
        for (Account *account in accounts) {
             [jsonArray addObject: [DIDPlugHelper convertAccountToJson:account]];
        }

        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsArray: jsonArray.copy];
        [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
    }
    @catch (NSException *e)
    {
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}

- (void)removeAccount:(CDVInvokedUrlCommand*) command{
    __block DIDPlugAccountsApi* pluginBlock = self;
    @try{
        __block CDVPluginResult* pluginResult;
        __block CDVInvokedUrlCommand* commandBlock = command;

        Account *account = [DIDPlugHelper convertJsonToAccount: [[commandBlock.arguments objectAtIndex:0] valueForKeyPath: @"currentAccount"]];

        [[DetectID sdk] removeAccount: account];

        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool: TRUE];
        [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];

    }@catch(NSException *ex) {
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:ex]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}

- (void)setAccountUsername:(CDVInvokedUrlCommand*) command{
    __block DIDPlugAccountsApi* pluginBlock = self;

    @try{
         __block CDVPluginResult* pluginResult;
         __block CDVInvokedUrlCommand* commandBlock = command;

        NSString *username = [[commandBlock.arguments objectAtIndex:0] valueForKeyPath:@"username"];
        Account *account = [DIDPlugHelper convertJsonToAccount: [[commandBlock.arguments objectAtIndex:0] valueForKeyPath: @"currentAccount"]];


        [[DetectID sdk] setAccountUsername: username forAccount: account];

        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool: TRUE];
        [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];

    }@catch(NSException *ex) {
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:ex]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}

@end
