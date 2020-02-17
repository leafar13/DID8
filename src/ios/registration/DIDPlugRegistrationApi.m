//
//  DIDPluginManager.m
//  Exceptions
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
//

#import "DIDPlugServerHelper.h"
#import "DIDPlugRegexHelper.h"
#import "DIDPlugExceptionsHelper.h"
#import "DIDPlugRegistrationApi.h"
#import "DIDPlugConstantsHelper.h"
#import <Cordova/CDVViewController.h>

@implementation DIDPlugRegistrationApi
    {
        __block DIDPlugRegistrationApi* pluginManager;
        __block CDVInvokedUrlCommand *commandDeviceRegistrationServerResponseListener;
    }
    
- (instancetype)init {
    if (self == [super init]){
    }
    return self;
}
  - (void) didInit:(CDVInvokedUrlCommand*)command {
        [[DetectID sdk] enableRegistrationServerResponseAlerts:NO];
       __block CDVInvokedUrlCommand *commandBlock = command;
       [self didInitManager:commandBlock withPlugin:self];
   }

   -(void)didInitManager: (CDVInvokedUrlCommand*)command withPlugin:(DIDPlugRegistrationApi *)plugin{
    __block CDVInvokedUrlCommand* commandBlock = command;
    __block DIDPlugRegistrationApi* pluginBlock = plugin;
    __block CDVPluginResult* pluginResult;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:TRUE];
    [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
    NSLog(SUCCESS_PROCESS);
}
    
- (void) initDIDServerWithParams:(CDVInvokedUrlCommand*)command{
    [[DetectID sdk] enableRegistrationServerResponseAlerts:NO];
    __block CDVInvokedUrlCommand *commandBlock = command;
    [self initDIDServerWithParamsManager:commandBlock withPlugin:self];
}
    
- (void) deviceRegistrationByCode:(CDVInvokedUrlCommand*)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    [self.commandDelegate runInBackground:^{
        [self deviceRegistrationByCodeManager:commandBlock withPlugin:self];
    }];
}
    
- (void) deviceRegistrationByQRCode:(CDVInvokedUrlCommand*)command{
    __block CDVInvokedUrlCommand *commandBlock = command;
    [self deviceRegistrationByQRCodeManager:commandBlock withPlugin:self];
}
    
- (void) setDeviceRegistrationServerResponseListener:(CDVInvokedUrlCommand*)command {
    [self setDeviceRegistrationServerResponseListenerManager:command withPlugin:self];
}
    
-(void)onRegistrationResponse:(NSString*) result {
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString: result] callbackId: _myCallbackId];
}
    
- (void) setRegistrationViewProperties:(CDVInvokedUrlCommand*)command{
    [self setRegistrationViewPropertiesManager:command withPlugin:self];
}
    
- (void)initDIDServerWithParamsManager:(CDVInvokedUrlCommand*)command withPlugin:(DIDPlugRegistrationApi *)plugin{
    __block DIDPlugRegistrationApi* pluginBlock = plugin;
    
    @try {
        __block CDVPluginResult* pluginResult;
        __block CDVInvokedUrlCommand* commandBlock = command;
        DIDPlugRegistrationApi * __weak weakSelf = self;
        [self validateInputParams:[NSDictionary class] withSize:1 withCommand:command completion:^(NSException *exception) {
            if (exception) {
                @throw exception;
            } else {
                NSString *url = @"";
                NSString *initParamsJsonString = [[commandBlock.arguments objectAtIndex:0] valueForKeyPath:@"initParams"];
                if (![initParamsJsonString isEqual:[NSNull null]] && [initParamsJsonString length] > 0){
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData: [initParamsJsonString dataUsingEncoding: NSUTF8StringEncoding] options: NSJSONReadingMutableLeaves  error: nil];
                    NSString *urlParameter = [dic objectForKey:@"url"];
                    if (nil != urlParameter && [urlParameter length] > 0){
                        url = urlParameter;
                    }
                }
                
                InitParams *params = [[[InitParamsBuilder new] buildDidUrl: url] buildParams];
                [[DetectID sdk] initDIDServerWithParams: params];
                [[[DetectID sdk] PUSH_API] setPushTransactionOpenDelegate:self];
                [[[DetectID sdk] PUSH_API] setPushAlertOpenDelegate:self];
                [[[DetectID sdk] PUSH_API] enablePushTransactionServerResponseAlerts:NO];
                
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:TRUE];
                [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
                NSLog(SUCCESS_PROCESS);
            }
        }];
    } @catch (NSException *e){
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}
    
- (void)displayDeviceRegistrationDialogManager:(CDVInvokedUrlCommand*)command withPlugin:(DIDPlugRegistrationApi *)plugin{
    __block DIDPlugRegistrationApi* pluginBlock = plugin;
    @try {
        __block CDVPluginResult* pluginResult;
        __block CDVInvokedUrlCommand* commandBlock = command;
        [self validateInputParams:[NSDictionary class] withSize:0 withCommand:command completion:^(NSException *exception) {
            if (exception) {
                @throw exception;
            } else {
                [[DetectID sdk] displayDeviceRegistrationDialog];
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:TRUE];
                [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
                NSLog(SUCCESS_PROCESS);
            }
        }];
    } @catch (NSException *e){
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
        NSLog(ERROR_CALLING_DEFAULT_REGISTRATION_DIALOG);
    }
}
    
- (void)deviceRegistrationByCodeManager:(CDVInvokedUrlCommand*)command withPlugin:(DIDPlugRegistrationApi *)plugin{
    __block DIDPlugRegistrationApi *pluginBlock = plugin;
    @try {
        __block CDVPluginResult *pluginResult;
        __block CDVInvokedUrlCommand *commandBlock = command;
        self.myCallbackId = command.callbackId;
        
        DIDPlugRegistrationApi * __weak weakSelf = self;
        [self validateInputParams:[NSDictionary class] withSize:1 withCommand:command completion:^(NSException *exception) {
            if (exception) {
                @throw exception;
            } else {
                NSString *code=[[commandBlock.arguments objectAtIndex:0] valueForKeyPath:CODE_KEY];
                if ([weakSelf validateNullString:code]) {
                    @throw [[DIDPlugExceptionsHelper new] nullParameterException];
                }else{
                     [pluginResult setKeepCallbackAsBool: NO];
                     [[DetectID sdk] deviceRegistrationByCode:code];
                     NSLog(SUCCESS_PROCESS);
                }
            }
        }];
    } @catch (NSException *e){
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}
    
- (void)deviceRegistrationByQRCodeManager:(CDVInvokedUrlCommand*)command withPlugin:(DIDPlugRegistrationApi *)plugin {
    __block DIDPlugRegistrationApi* pluginBlock = plugin;
    @try {
        __block CDVPluginResult* pluginResult;
        __block CDVInvokedUrlCommand* commandBlock = command;
        self.myCallbackId = command.callbackId;
        
        DIDPlugRegistrationApi * __weak weakSelf = self;
        [self validateInputParams:[NSDictionary class] withSize:1 withCommand:command completion:^(NSException *exception) {
            if (exception) {
                @throw exception;
            }else{
                [pluginResult setKeepCallbackAsBool: NO];
                [[DetectID sdk] deviceRegistrationByQRCode: self.viewController];
                NSLog(SUCCESS_PROCESS);
            }
        }];
    } @catch (NSException *e){
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}
    
- (void)setDeviceRegistrationServerResponseListenerManager:(CDVInvokedUrlCommand*)command withPlugin:(DIDPlugRegistrationApi *)plugin {
    __block DIDPlugRegistrationApi* pluginBlock = plugin;
    @try {
        __block CDVPluginResult* pluginResult;
        __block CDVInvokedUrlCommand* commandBlock = command;
        [self validateInputParams:[NSDictionary class] withSize:0 withCommand:command completion:^(NSException *exception) {
            if (exception) {
                @throw exception;
            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
               // _commandDeviceRegistrationServerResponseListener = commandBlock;
                [pluginResult setKeepCallbackAsBool: NO];
                [[DetectID sdk] setDeviceRegistrationServerResponseDelegate: pluginBlock];
                [[DetectID sdk] enableRegistrationServerResponseAlerts: false];
                
                [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
                NSLog(SUCCESS_PROCESS);
            }
        }];
    } @catch (NSException *e){
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
        NSLog(ERROR_CALLING_REGISTRATION_RESPONSE_DELEGATE);
    }
}
    
- (CDVPluginResult*)onRegistrationResponseManager:(NSString *)result withCommand:(CDVInvokedUrlCommand *)commandDeviceRegistrationServerResponseListener {
    CDVPluginResult *pluginResult = nil;
    
    if(commandDeviceRegistrationServerResponseListener != nil){
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
        NSLog(SUCCESS_PROCESS);
    }else{
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:ERROR_REGISTRATION_RESPONSE_DELEGATE_NULL];
        NSLog(ERROR_REGISTRATION_RESPONSE_DELEGATE_NULL);
    }
    
    return pluginResult;
}
    
- (void) setRegistrationViewPropertiesManager:(CDVInvokedUrlCommand*)command withPlugin:(DIDPlugRegistrationApi *)plugin{
    __block DIDPlugRegistrationApi* pluginBlock = plugin;
    @try {
        __block CDVPluginResult* pluginResult;
        __block CDVInvokedUrlCommand* commandBlock = command;
        [self validateInputParams:[NSString class] withSize:1 withCommand:command completion:^(NSException *exception) {
            if (exception) {
                @throw exception;
            } else {
                if ([DIDPlugRegexHelper validateStringFormat:[commandBlock.arguments objectAtIndex:0] withPattern:regitrationViewPropertiesRegex]) {
                    NSError *jsonError;
                    NSData *objectData = [[commandBlock.arguments objectAtIndex:0] dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                         options:NSJSONReadingMutableContainers
                                                                           error:&jsonError];
                    RegistrationViewProperties *registrationViewProperties = [[RegistrationViewProperties alloc]init];
                    registrationViewProperties.TITLE = [json valueForKeyPath:@"TITLE"] ? : nil;
                    registrationViewProperties.MESSAGE = [json valueForKeyPath:@"MESSAGE"] ? : nil;
                    registrationViewProperties.CONFIRM = [json valueForKeyPath:@"CONFIRM"] ? : nil;
                    registrationViewProperties.CANCEL = [json valueForKeyPath:@"CANCEL"] ? : nil;
                    registrationViewProperties.SERVER_RESPONSE_CODE_98 = [json valueForKeyPath:@"SERVER_RESPONSE_CODE_98"] ? : nil;
                    registrationViewProperties.SERVER_RESPONSE_CODE_99 = [json valueForKeyPath:@"SERVER_RESPONSE_CODE_99"] ? : nil;
                    registrationViewProperties.SERVER_RESPONSE_CODE_1002 = [json valueForKeyPath:@"SERVER_RESPONSE_CODE_1002"] ? : nil;
                    registrationViewProperties.SERVER_RESPONSE_CODE_1010 = [json valueForKeyPath:@"SERVER_RESPONSE_CODE_1010"] ? : nil;
                    registrationViewProperties.SERVER_RESPONSE_CODE_1011 = [json valueForKeyPath:@"SERVER_RESPONSE_CODE_1011"] ? : nil;
                    registrationViewProperties.SERVER_RESPONSE_CODE_1012 = [json valueForKeyPath:@"SERVER_RESPONSE_CODE_1012"] ? : nil;
                    registrationViewProperties.SERVER_RESPONSE_CODE_1013 = [json valueForKeyPath:@"SERVER_RESPONSE_CODE_1013"] ? : nil;
                    registrationViewProperties.SERVER_RESPONSE_CODE_1014 = [json valueForKeyPath:@"SERVER_RESPONSE_CODE_1014"] ? : nil;
                    registrationViewProperties.SERVER_RESPONSE_CODE_1020 = [json valueForKeyPath:@"SERVER_RESPONSE_CODE_1020"] ? : nil;
                    registrationViewProperties.CAMERA_PERMISSION_REQUEST = [json valueForKeyPath:@"CAMERA_PERMISSION_REQUEST"] ? : nil;
                    registrationViewProperties.CAMERA_PERMISSION_SETTINGS = [json valueForKeyPath:@"CAMERA_PERMISSION_SETTINGS"] ? : nil;
                    registrationViewProperties.CAMERA_PERMISSION_CANCEL = [json valueForKeyPath:@"CAMERA_PERMISSION_CANCEL"] ? : nil;
                    [[DetectID sdk] setRegistrationViewProperties:registrationViewProperties];
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:TRUE];
                    [pluginBlock.commandDelegate sendPluginResult:pluginResult callbackId:commandBlock.callbackId];
                    NSLog(SUCCESS_PROCESS);
                } else {
                    @throw [[DIDPlugExceptionsHelper new] invalidArgumentFormatException];
                }
            }
        }];
    } @catch (NSException *e){
        CDVPluginResult *pluginResultFail = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[DIDPlugExceptionsHelper pluginExceptionHandler:e]];
        [pluginBlock.commandDelegate sendPluginResult:pluginResultFail callbackId:command.callbackId];
    }
}
    
    
- (void)validateInputParams:(Class) aClass withSize:(NSUInteger) size withCommand:(CDVInvokedUrlCommand*)command completion:(void (^)(NSException *exception)) completion {
    if (command.arguments) {
        if ([command.arguments count] == size) {
            if (size > 0) {
                id myarg = [command.arguments objectAtIndex:0];
                if ([myarg isKindOfClass:aClass]) {
                    completion(nil);
                } else {
                    completion([[DIDPlugExceptionsHelper new] wrongTypeParameterException]);
                }
            } else {
                completion(nil);
            }
        } else {
            completion([[DIDPlugExceptionsHelper new] invalidParameterSizeException]);
        }
    }else {
        completion([[DIDPlugExceptionsHelper new] nullParameterException]);
    }
}
    
- (BOOL)validateNullString:(NSString *) string {
    return [string isEqual:@"null"] || [string isEqual:[NSNull null]] || string ==nil;
}
    @end
