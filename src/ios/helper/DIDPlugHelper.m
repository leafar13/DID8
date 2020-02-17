//
//  DIDServerURL.m
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

#import "DIDPlugConstantsHelper.h"
#import "DIDPlugHelper.h"

@implementation DIDPlugHelper

+(PushTransactionViewProperties*)convertJsonToPushTransactionViewProperties:(NSDictionary*)json{
    
    PushTransactionViewProperties* pushTransactionVP = [[PushTransactionViewProperties alloc]init];
    pushTransactionVP.CONFIRM = [json valueForKeyPath: CONFIRM_PROPERTIES] ? : nil;
    pushTransactionVP.DECLINE = [json valueForKeyPath: DECLINE_PROPERTIES] ? : nil;
    NSString *quickActionParameter = ([json valueForKeyPath: ENABLE_NOTIFICATION_QUICK_ACTIONS_PROPERTIES] ? : nil);
    BOOL quickAction = NO;
    
    if (nil != quickActionParameter){
        quickAction = ([quickActionParameter boolValue] ? YES : NO);
    }
    
    pushTransactionVP.ENABLE_NOTIFICATION_QUICK_ACTIONS = quickAction;
    pushTransactionVP.SERVER_RESPONSE_CODE_96 = [json valueForKeyPath: SERVER_RESPONSE_CODE_96_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_98 = [json valueForKeyPath: SERVER_RESPONSE_CODE_98_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_99 = [json valueForKeyPath: SERVER_RESPONSE_CODE_99_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1001 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1001_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1002 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1002_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1012 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1012_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1020 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1020_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1021 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1021_PROPERTIES] ? : nil;
    pushTransactionVP.SERVER_RESPONSE_CODE_1022 = [json valueForKeyPath: SERVER_RESPONSE_CODE_1022_PROPERTIES] ? : nil;
    
    return pushTransactionVP;
}

+(TransactionInfo*)convertJsonToPushTransactionInfo:(NSDictionary*)json{
    TransactionInfo* transaction = [[TransactionInfo alloc]init];
    
    transaction.transactionID = [json valueForKeyPath: TRANSACTION_ID] ? : nil;
    transaction.subject = [json valueForKeyPath: SUBJECT] ? : nil;
    transaction.message = [json valueForKeyPath: MESSAGE_PROPERTIES] ? : nil;
    transaction.subject = [json valueForKeyPath: SUBJECT_NOTIFICATION] ? : nil;
    transaction.message = [json valueForKeyPath: MESSAGE_NOTIFICATION] ? : nil;
    transaction.urlToResponse = [json valueForKeyPath: URL_TO_RESPONSE] ? : nil;
    transaction.urlToConfigFaceID = [json valueForKeyPath: URL_TO_CONFIG_FACEID] ? : nil;
    transaction.timeStamp =  [([json valueForKeyPath: TIME_STAMP] ? : nil) longLongValue];
    transaction.transactionOfflineCode = [json valueForKeyPath: TRANSACTION_OFFLINE_CODE] ? : nil;
    transaction.account = [self convertJsonToAccount:[json valueForKeyPath: ACCOUNT_PROPERTIES] ? : nil];
    transaction.gestures = [self convertJsonToGestures:[json valueForKeyPath: GESTURES_PROPERTIES] ? : nil];
    transaction.channel = [self convertJsonToChannel:[json valueForKeyPath: CHANNEL_PROPERTIES] ? : nil];
    transaction.type = [([json valueForKeyPath: TYPE] ? : nil) integerValue];
    transaction.biometricType = [([json valueForKeyPath: BIOMETRIC_TYPE] ? : nil) integerValue];
    transaction.status = [([json valueForKeyPath: STATUS] ? : nil) integerValue];
    
    return transaction;
}

+(Account*)convertJsonToAccount:(NSDictionary*)json{
    Account* account = [[Account alloc]init];
    
    account.username = [json valueForKeyPath: USERNAME] ? : nil;
    account.activationURL = [json valueForKeyPath: ACTIVATION_URL] ? : nil;
    account.organizationName = [json valueForKeyPath: ORGANIZATION_NAME] ? : nil;
    account.activeOTPAuth = [([json valueForKeyPath: ACTIVE_OTP_AUTH] ? : nil) boolValue];
    account.activePushAuth = [([json valueForKeyPath: ACTIVE_PUSH_AUTH] ? : nil) boolValue];
    account.activeQRAuth = [([json valueForKeyPath: ACTIVE_QR_AUTH] ? : nil) boolValue];
    account.activePushAlert = [([json valueForKeyPath: ACTIVE_PUSH_ALERT] ? : nil) boolValue];
    account.activeVoiceAuth = [([json valueForKeyPath: ACTIVE_VOICE_AUTH] ? : nil) boolValue];
    account.activeFaceAuth =  [([json valueForKeyPath: ACTIVE_FACE_AUTH] ? : nil) longLongValue];
    account.registrationDate = [json valueForKeyPath: REGISTRATION_DATE] ? : nil;
    account.isLegacy = [([json valueForKeyPath: IS_LEGACY] ? : nil) boolValue];
    account.registrationMethod = [([json valueForKeyPath: REGISTRATION_METHOD] ? : nil) intValue];
    
    return account;
}

+ (NSDictionary *)convertAccountToJson:(Account *)account {
    return @{
             USERNAME: account.username,
             ORGANIZATION_NAME : account.organizationName ,
             REGISTRATION_DATE : account.registrationDate ,
             ACTIVATION_URL : account.activationURL,
             ACTIVE_PUSH_AUTH : [NSNumber numberWithBool: account.activePushAuth],
             ACTIVE_QR_AUTH : [NSNumber numberWithBool:account.activeQRAuth],
             ACTIVE_PUSH_ALERT : [NSNumber numberWithBool:account.activePushAlert],
             ACTIVE_VOICE_AUTH : [NSNumber numberWithBool:account.activeVoiceAuth],
             ACTIVE_OTP_AUTH : [NSNumber numberWithBool:account.activeOTPAuth],
             ACTIVE_FACE_AUTH : [NSNumber numberWithBool:account.activeFaceAuth],
             IS_LEGACY : [NSNumber numberWithBool:account.isLegacy],
             REGISTRATION_METHOD : [NSNumber numberWithInt:account.registrationMethod]
             };
}

+(Gestures*)convertJsonToGestures:(NSDictionary*)json{
    Gestures* gestures = [[Gestures alloc]init];
    gestures.faceGestures = [json valueForKeyPath: FACE_GESTURES] ? : nil;
    
    return gestures;
}

+(Channel*)convertJsonToChannel:(NSDictionary*)json{
    Channel* channel = [[Channel alloc]init];
    channel.channelName = [json valueForKeyPath: CHANNEL_NAME] ? : nil;
    
    return channel;
}

+(NSDictionary *)convertTransactionInfoToDictionary:(TransactionInfo*) transactionInfo{
    
    NSDictionary *dictTransactionInfo = [self convertObjectToDictionary: transactionInfo];
    NSDictionary *dictAccount = [self convertObjectToDictionary: transactionInfo.account];
    NSDictionary *dictChannel = [self convertObjectToDictionary: transactionInfo.channel];
    NSDictionary *dictGestures = [self convertObjectToDictionary: transactionInfo.gestures];
    
    NSMutableDictionary *mutableDictionary = [dictTransactionInfo mutableCopy];
    
    [mutableDictionary setObject:dictAccount forKey:ACCOUNT_PROPERTIES];
    [mutableDictionary setObject:dictChannel forKey:CHANNEL_PROPERTIES];
    [mutableDictionary setObject:dictGestures forKey:GESTURES_PROPERTIES];
    
    dictTransactionInfo = [mutableDictionary mutableCopy];
    
    return dictTransactionInfo;
}

+(NSDictionary *) convertObjectToDictionary:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        
        if(![key isEqualToString: SUPERCLASS_PROPERTIES])
        {
            [dict setObject: [obj valueForKey:key] ? : @"" forKey:key];
        }
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
