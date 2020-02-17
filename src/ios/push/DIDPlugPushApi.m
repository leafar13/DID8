//
//  DIDPlugPushTransaction.m
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

#import "DIDPlugPushApi.h"
#import "DIDPlugConstantsHelper.h"
#import "DIDPlugPushTransactionManager.h"
#import "DIDPlugPushAlertManager.h"
#import "DIDPluginTransactionServerResponseListener.h"
#import "DIDPluginTransactionOpenListener.h"
#import "DIDPluginTransactionActionListener.h"
#import "DIDPluginPushAlertOpenListener.h"
#import <didm_auth_sdk_iOS/didm_auth_sdk_iOS.h>

@implementation DIDPlugPushApi
{
    __block DIDPlugPushTransactionManager *pushTransactionManager;
    __block DIDPlugPushAlertManager *pushAlertManager;
}

- (instancetype)init {
    return [super init];
}

-(void)setPushTransactionViewProperties: (CDVInvokedUrlCommand*)command{

    pushTransactionManager = [[DIDPlugPushTransactionManager alloc]init];    
    [pushTransactionManager setPushTransactionViewProperties:command withPlugin:self];
}

-(void)confirmPushTransactionAction: (CDVInvokedUrlCommand*)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    
    [self.commandDelegate runInBackground:^{
        [[DIDPluginTransactionServerResponseListener alloc] initWithCommand:commandBlock withPlugin:self]; //setPushTransactionServerResponseListener
        self->pushTransactionManager = [[DIDPlugPushTransactionManager alloc]init];
        [self->pushTransactionManager confirmPushTransactionAction:commandBlock withPlugin:self];
    }];
}

-(void)declinePushTransactionAction: (CDVInvokedUrlCommand*)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    [self.commandDelegate runInBackground:^{
        [[DIDPluginTransactionServerResponseListener alloc] initWithCommand:commandBlock withPlugin:self]; //setPushTransactionServerResponseListener
        self->pushTransactionManager = [[DIDPlugPushTransactionManager alloc]init];
        [self->pushTransactionManager declinePushTransactionAction:commandBlock withPlugin:self];
    }];
}

-(void)setPushAuthenticationResponseAdditionalInfo: (CDVInvokedUrlCommand*)command{
    
    pushTransactionManager = [[DIDPlugPushTransactionManager alloc]init];          
    [pushTransactionManager setPushAuthenticationResponseAdditionalInfo:command withPlugin:self];
}

-(void)approvePushAlertAction: (CDVInvokedUrlCommand*)command{

    pushAlertManager = [[DIDPlugPushAlertManager alloc]init];       
    [pushAlertManager approvePushAlertAction:command withPlugin:self];
}

-(void)setPushAlertViewProperties: (CDVInvokedUrlCommand*)command{

    pushAlertManager = [[DIDPlugPushAlertManager alloc]init];    
    [pushAlertManager setPushAlertViewProperties:command withPlugin:self];
}

-(void)setPushTransactionServerResponseListener: (CDVInvokedUrlCommand*)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    [self.commandDelegate runInBackground:^{
    [[DIDPluginTransactionServerResponseListener alloc] initWithCommand:commandBlock withPlugin:self];
        }];
}

-(void)setPushTransactionOpenListener: (CDVInvokedUrlCommand*)command{
    
    [[DIDPluginTransactionOpenListener sharedInstance] setCommand:command withPlugin:self];
}

-(void)setPushTransactionActionListener: (CDVInvokedUrlCommand*)command{
    
    [[DIDPluginTransactionActionListener alloc] initWithCommand:command withPlugin:self];
}

-(void)setPushAlertOpenListener: (CDVInvokedUrlCommand*)command{
    
    [[DIDPluginPushAlertOpenListener sharedInstance] setCommand:command withPlugin:self];
}

@end
