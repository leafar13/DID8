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
#import "DIDPlugHelper.h"

@implementation DIDPlugPushTransactionManager{
}

- (instancetype)init {
    return [super init];
}

-(void)setPushTransactionViewProperties: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi{
    
    __block CDVInvokedUrlCommand* commandProperties = command;
    
    NSError *jsonError;
    NSData *objectData = [[commandProperties.arguments objectAtIndex:0] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:&jsonError];
    
    [[[DetectID sdk] PUSH_API] setPushTransactionViewProperties:[DIDPlugHelper convertJsonToPushTransactionViewProperties:json]];
}

- (void)confirmPushTransactionAction: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi{
    
    [[[DetectID sdk] PUSH_API] confirmPushTransactionAction : [DIDPlugHelper convertJsonToPushTransactionInfo:[command.arguments objectAtIndex:0]]];
}

- (void)declinePushTransactionAction: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi{
    
    [[[DetectID sdk] PUSH_API] declinePushTransactionAction: [DIDPlugHelper convertJsonToPushTransactionInfo:[command.arguments objectAtIndex:0]]];
}

- (void)setPushAuthenticationResponseAdditionalInfo: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugPushApi*) pluginPushApi{
    
    [[[DetectID sdk] PUSH_API] setPushAuthenticationResponseAdditionalInfo:[command.arguments objectAtIndex:0]];
}

@end
