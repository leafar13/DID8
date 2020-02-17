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
package net.easysol.did.DetectIDCordovaPlugin.otp;

import android.content.Context;

import com.google.gson.Gson;

import net.easysol.did.DetectID;
import net.easysol.did.common.account.Account;

import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

class DIDPlugOtpManager {

    private DIDPlugOtpManager() {

    }

    static void getTokenValue(Context context, JSONArray args, CallbackContext callbackContext) {
        try {
            Account account = getAccountFromJsonObject(args);
            String tokenValue = DetectID.sdk(context).OTP_API.getTokenValue(account);
            callbackContext.success(tokenValue);
        } catch (JSONException e) {
            callbackContext.error(e.getMessage());
        }
    }

    static void updateTokenTimeStepValue(Context context, JSONArray args, CallbackContext callbackContext) {
        try {
            Account account = getAccountFromJsonObject(args);
            DetectID.sdk(context).OTP_API.updateTokenLifetime(account);
            callbackContext.success();
        } catch (NullPointerException | JSONException e) {
            callbackContext.error(e.getMessage());
        }
    }

    private static Account getAccountFromJsonObject(JSONArray args) throws JSONException {
        JSONObject accountJson = args.getJSONObject(0);
        return new Gson().fromJson(accountJson.toString(), Account.class);
    }
}
