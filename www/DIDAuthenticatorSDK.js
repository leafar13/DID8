/* Disclaimer
© 2019, Cyxtera Cybersecurity, Inc. d/b/a AppGate.  All rights reserved.  

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met: 
(a) redistributions of source code must retain the above copyright notice, this list of conditions and the disclaimer below, and (b) 
redistributions in binary form must reproduce the above copyright notice, this list of conditions and the disclaimer below in the documentation
and/or other materials provided with the distribution. 

THE CODE AND SCRIPTS POSTED ON THIS WEBSITE ARE PROVIDED ON AN “AS IS” BASIS AND YOUR USE OF SUCH CODE AND/OR SCRIPTS IS AT YOUR OWN RISK.  
APPGATE DISCLAIMS ALL EXPRESS AND IMPLIED WARRANTIES, EITHER IN FACT OR BY OPERATION OF LAW, STATUTORY OR OTHERWISE, INCLUDING, BUT NOT LIMITED TO, 
ALL WARRANTIES OF MERCHANTABILITY, TITLE, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, ACCURACY, COMPLETENESS, COMPATABILITY OF SOFTWARE OR 
EQUIPMENT OR ANY RESULTS TO BE ACHIEVED THEREFROM.  APPGATE DOES NOT WARRANT THAT SUCH CODE AND/OR SCRIPTS ARE OR WILL BE ERROR-FREE.  
IN NO EVENT SHALL APPGATE BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, RELIANCE, EXEMPLARY, PUNITIVE OR CONSEQUENTIAL DAMAGES, OR ANY LOSS 
OF GOODWILL, LOSS OF ANTICIPATED SAVINGS, COST OF PURCHASING REPLACEMENT SERVICES, LOSS OF PROFITS, REVENUE, DATA OR DATA USE, ARISING IN ANY WAY OUT 
OF THE USE AND/OR REDISTRIBUTION OF SUCH CODE AND/OR SCRIPTS, REGARDLESS OF THE LEGAL THEORY UNDER WHICH SUCH LIABILITY IS ASSERTED AND REGARDLESS 
OF WHETHER APPGATE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH LIABILITY. */

var exec = require('cordova/exec');

var DetectIDCordovaPlugin={
	initDIDServerWithParams : function(success, fail, initParams){
		exec(success, fail, "DIDPlugRegistrationApi","initDIDServerWithParams", [{"initParams" : initParams}]);
	},
	didInit : function(success,fail){
		exec(success, fail, "DIDPlugRegistrationApi", "didInit", []);
	},
	displayDeviceRegistrationDialog : function (success, fail){
        exec(success, fail, "DIDPlugRegistrationApi","displayDeviceRegistrationDialog",[]);
	},
	deviceRegistrationByCode : function (success, fail, code){
        exec(success, fail, "DIDPlugRegistrationApi","deviceRegistrationByCode",[{"code":code}]);
	},
	deviceRegistrationByQRCode : function (success, fail){
        exec(success, fail, "DIDPlugRegistrationApi","deviceRegistrationByQRCode",[{}]);
	},
	setDeviceRegistrationServerResponseListener : function (success, fail){
        exec(success, fail, "DIDPlugRegistrationApi","setDeviceRegistrationServerResponseListener",[]);
	},
	setRegistrationViewProperties : function (success, fail, registrationViewProperties){
        exec(success, fail, "DIDPlugRegistrationApi","setRegistrationViewProperties", ["" + JSON.stringify(registrationViewProperties)]);
	},
	setPushTransactionViewProperties : function(success, fail, pushTransactionViewProperties){
	    exec(success, fail, "DIDPlugPushApi", "setPushTransactionViewProperties", ["" + JSON.stringify(pushTransactionViewProperties)]);
	},
	setPushQuickActionServerResponseListener : function(success, fail){
	    exec(success, fail, "DIDPlugPushApi", "setPushTransactionServerResponseListener", []);
	},
	/*setPushTransactionReceiveListener : function(success, fail){
		exec(success, fail, "DIDPlugPushApi", "setPushTransactionReceiveListener", []);
	},
	setPushTransactionOpenListener : function(success, fail){
	    exec(success, fail, "DIDPlugPushApi", "setPushTransactionOpenListener", []);
	},
	setPushTransactionActionListener : function(success, fail){
	    exec(success, fail, "DIDPlugPushApi", "setPushTransactionActionListener", []);
	},
	setPushAlertViewProperties : function(success, fail, setPushAlertViewProperties){
	    exec(success, fail, "DIDPlugPushApi", "setPushAlertViewProperties", [setPushAlertViewProperties]);
	},
	confirmPushTransactionAction : function(success, fail, transactionJson){
	    exec(success, fail, "DIDPlugPushApi", "confirmPushTransactionAction", [transactionJson]);
	},
	declinePushTransactionAction : function(success, fail, transactionJson){
	    exec(success, fail, "DIDPlugPushApi", "declinePushTransactionAction", [transactionJson]);
	},
	setPushAlertReceiveListener : function(success, fail){
        exec(success, fail, "DIDPlugPushApi", "setPushAlertReceiveListener", []);
	},
	setPushAlertOpenListener : function(success, fail){
        exec(success, fail, "DIDPlugPushApi", "setPushAlertOpenListener", []);
	},
	approvePushAlert : function(success, fail, transactionJson){
		exec(success, fail, "DIDPlugPushApi", "approvePushAlertAction", [transactionJson]);
	},
	setPushAuthenticationResponseAdditionalInfo : function(success, fail, additionalInfoJson){
	    exec(success, fail, "DIDPlugPushApi", "setPushAuthenticationResponseAdditionalInfo", [additionalInfoJson]);
	},*/
	getAccounts : function (success) {
        exec(success, null, "DIDPlugAccountsApi","getAccounts", [{}]);
	},
	updateTokenTimeStepValue : function(success, fail, account){
		exec(success, fail, "DIDPlugOtpApi", "updateTokenTimeStepValue", [account]);
	},
	getTokenValue: function(success, fail, account) {
		exec(success, fail, "DIDPlugOtpApi", "getTokenValue", [account]);
	},
	removeAccount: function(success, fail, account){
		exec(success, fail, "DIDPlugAccountsApi", "removeAccount", [{"currentAccount": account }]);
	},
	setAccountUsername: function (success, fail, username, account){
		exec(success, fail, "DIDPlugAccountsApi", "setAccountUsername", [{"username": username, "currentAccount": account }]);
	}


};

module.exports = DetectIDCordovaPlugin;