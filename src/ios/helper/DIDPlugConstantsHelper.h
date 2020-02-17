//
//  DetectIDCordovaPlugin.h
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

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

#define INVALID_PARAMETER_NULL @ "Argument was null or wrong parameter"
#define INVALID_PARAMETER_SIZE @ "Argument has an invalid size"
#define INVALID_PARAMETER_WRONG_TYPE @ "Argument parameter does't have the correct type"
#define INVALID_PARAMETER_WRONG_FORMAT @ "Argument has an invalid format"
#define NS_INVALID_ARGUMENT_EXCEPTION @ "This exception occurs when you pass an invalid argument to a method, such as a nil pointer where a non-nil object is required."

#define ERROR_CALLING_DEFAULT_REGISTRATION_DIALOG @ "Error calling displayDeviceRegistrationDialog method"
#define ERROR_CALLING_REGISTRATION_RESPONSE_DELEGATE @ "Error calling commandDeviceRegistrationServerResponseListener method"
#define ERROR_REGISTRATION_RESPONSE_DELEGATE_NULL @ "commandDeviceRegistrationServerResponseListener is null"
#define ERROR_CREATING_REGEX @ "Unable to create regular expression"

#define SUCCESS_PROCESS @ "Success method exceution"

#define URL_KEY @ "serverURL"
#define CODE_KEY @ "code"
#define ENABLE_KEY @ "enable"

#define serverUrlRegex @ "^(http:\\/\\/|https:\\/\\/)((([0-9]{1,3}).){3}(([0-9]{1,3}))|(www.)?([a-zA-Z0-9]+).[a-zA-Z0-9]*.[a-z]{3}.?([a-z]+)?)(:[0-9]{2,4})?(\\/detect\\/public\\/registration\\/mobileServices.htm\\?code=)([0-9]{0,6})?"
#define regitrationViewPropertiesRegex @ "^\\{(\\s{0,})\"TITLE\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"MESSAGE\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"CONFIRM\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"CANCEL\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"SERVER_RESPONSE_CODE_98\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"SERVER_RESPONSE_CODE_99\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"SERVER_RESPONSE_CODE_1002\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"SERVER_RESPONSE_CODE_1010\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"SERVER_RESPONSE_CODE_1011\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"SERVER_RESPONSE_CODE_1012\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"SERVER_RESPONSE_CODE_1013\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"SERVER_RESPONSE_CODE_1014\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"SERVER_RESPONSE_CODE_1020\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"CAMERA_PERMISSION_REQUEST\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"CAMERA_PERMISSION_SETTINGS\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,}),(\\s{0,})\"CAMERA_PERMISSION_CANCEL\"(\\s{0,}):(\\s{0,})\"(.*)\\\"(\\s{0,})\\}$"

#define CONFIRM_PROPERTIES @"CONFIRM"
#define DECLINE_PROPERTIES @"DECLINE"
#define APPROVE_PROPERTIES @"APPROVE"

#define SUPERCLASS_PROPERTIES @"superclass"
#define ACCOUNT_PROPERTIES @"account"
#define CHANNEL_PROPERTIES @"channel"
#define GESTURES_PROPERTIES @"gestures"

#define TRANSACTION_ID @"transactionID"
#define SUBJECT @"subject"
#define MESSAGE_PROPERTIES @"message"
#define SUBJECT_NOTIFICATION @"subjectNotification"
#define MESSAGE_NOTIFICATION @"messageNotification"
#define URL_TO_RESPONSE @"urlToResponse"
#define URL_TO_CONFIG_FACEID @"urlToConfigFaceID"
#define TIME_STAMP @"timeStamp"
#define TRANSACTION_OFFLINE_CODE @"transactionOfflineCode"
#define TYPE @"type"
#define BIOMETRIC_TYPE @"biometricType"
#define STATUS @"status"
#define USERNAME @"username"
#define ORGANIZATION_NAME @"organizationName"
#define ACTIVE_OTP_AUTH @"activeOTPAuth"
#define ACTIVE_PUSH_AUTH @"activePushAuth"
#define ACTIVE_QR_AUTH @"activeQRAuth"
#define ACTIVE_PUSH_ALERT @"activePushAlert"
#define ACTIVE_VOICE_AUTH @"activeVoiceAuth"
#define ACTIVE_FACE_AUTH @"activeFaceAuth"

#define ACTIVATION_URL @"activationURL"
#define REGISTRATION_DATE @"registrationDate"
#define IS_LEGACY @"isLegacy"
#define REGISTRATION_METHOD @"registrationMethod"
#define FACE_GESTURES @"faceGestures"
#define CHANNEL_NAME @"channelName"

#define SERVER_RESPONSE_CODE_96_PROPERTIES @"SERVER_RESPONSE_CODE_96"
#define SERVER_RESPONSE_CODE_98_PROPERTIES @"SERVER_RESPONSE_CODE_98"
#define SERVER_RESPONSE_CODE_99_PROPERTIES @"SERVER_RESPONSE_CODE_99"
#define SERVER_RESPONSE_CODE_1001_PROPERTIES @"SERVER_RESPONSE_CODE_1001"
#define SERVER_RESPONSE_CODE_1002_PROPERTIES @"SERVER_RESPONSE_CODE_1002"
#define SERVER_RESPONSE_CODE_1010_PROPERTIES @"SERVER_RESPONSE_CODE_1010"
#define SERVER_RESPONSE_CODE_1011_PROPERTIES @"SERVER_RESPONSE_CODE_1011"
#define SERVER_RESPONSE_CODE_1012_PROPERTIES @"SERVER_RESPONSE_CODE_1012"
#define SERVER_RESPONSE_CODE_1013_PROPERTIES @"SERVER_RESPONSE_CODE_1013"
#define SERVER_RESPONSE_CODE_1014_PROPERTIES @"SERVER_RESPONSE_CODE_1014"
#define SERVER_RESPONSE_CODE_1020_PROPERTIES @"SERVER_RESPONSE_CODE_1020"
#define SERVER_RESPONSE_CODE_1021_PROPERTIES @"SERVER_RESPONSE_CODE_1021"
#define SERVER_RESPONSE_CODE_1022_PROPERTIES @"SERVER_RESPONSE_CODE_1022"

#define  ENABLE_NOTIFICATION_QUICK_ACTIONS_PROPERTIES @"ENABLE_NOTIFICATION_QUICK_ACTIONS"
