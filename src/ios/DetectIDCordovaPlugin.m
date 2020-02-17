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

#import "DetectIDCordovaPlugin.h"
#import <Availability.h>
#import "DIDPlugRegexHelper.h"
#import "DIDPlugExceptionsHelper.h"
#import "DIDPlugServerHelper.h"
#import "DIDPlugRegistrationApi.h"


@interface DetectIDCordovaPlugin ()

// Retrieves the application state
@property (readonly, getter=applicationState) NSString* applicationState;
// All events will be queued until deviceready has been fired
@property (readwrite, assign) BOOL deviceready;
// Event queue
@property (readonly, nonatomic, retain) NSMutableArray* eventQueue;

@end

@implementation DetectIDCordovaPlugin
{
    __block DIDPlugRegistrationApi* pluginManager;
    __block CDVInvokedUrlCommand *commandDeviceRegistrationServerResponseListener;
}

@synthesize deviceready, eventQueue;

#pragma mark -
#pragma mark Interface

/**
 * Execute all queued events. TODO: PREGUNTAR ESTO QUE HACE
 */
- (void) deviceready:(CDVInvokedUrlCommand*)command
{
    deviceready = YES;
    
    for (NSString* js in eventQueue) {
        [self.commandDelegate evalJs:js];
    }
    
    [eventQueue removeAllObjects];
}

- (void) initDIDServerWithParams:(CDVInvokedUrlCommand*)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    pluginManager = [DIDPlugRegistrationApi new];
    [pluginManager initDIDServerWithParamsManager:commandBlock withPlugin:self];
}

- (void) displayDeviceRegistrationDialog:(CDVInvokedUrlCommand*)command {
    [pluginManager displayDeviceRegistrationDialogManager:command withPlugin:self];
}

- (void) deviceRegistrationByCode:(CDVInvokedUrlCommand*)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    [self.commandDelegate runInBackground:^{
        [pluginManager deviceRegistrationByCodeManager:commandBlock withPlugin:self];
    }];
}

- (void) deviceRegistrationByQRCode:(CDVInvokedUrlCommand*)command {
    __block CDVInvokedUrlCommand *commandBlock = command;
    [pluginManager deviceRegistrationByQRCodeManager:commandBlock withPlugin:self];
}

- (void) setDeviceRegistrationServerResponseListener:(CDVInvokedUrlCommand*)command {
    [pluginManager setDeviceRegistrationServerResponseListenerManager:command withPlugin:self];
}

-(void)onRegistrationResponse:(NSString*) result {
    commandDeviceRegistrationServerResponseListener = pluginManager.commandDeviceRegistrationServerResponseListener;
    [self.commandDelegate sendPluginResult:[pluginManager onRegistrationResponseManager:result withCommand:commandDeviceRegistrationServerResponseListener] callbackId:commandDeviceRegistrationServerResponseListener.callbackId];
}

- (void) setRegistrationViewProperties:(CDVInvokedUrlCommand*)command{
    [pluginManager setRegistrationViewPropertiesManager:command withPlugin:self];
}

@end