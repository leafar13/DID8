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
package net.easysol.did.DetectIDCordovaPlugin.registration;

import android.content.Context;

import net.easysol.did.DetectID;
import net.easysol.did.DetectIDCordovaPlugin.listeners.DIDPluginRegistrationServerResponseListener;
import net.easysol.did.common.model.contract.InitParams;
import net.easysol.did.common.registration.RegistrationViewProperties;

import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class DIDPlugRegistrationManager {

    private static final String CODE_IS_NULL = "Code is null";
    private static final String SERVER_URL = "url";
    private static final String INIT_PARAMS = "initParams";
    private static final String NULL = "null";
    private static final String CODE = "code";
    private static final String ENABLE = "enable";
    private static final String TITLE = "TITLE";
    private static final String MESSAGE = "MESSAGE";
    private static final String CONFIRM = "CONFIRM";
    private static final String CANCEL = "CANCEL";
    private static final String SERVER_RESPONSE_CODE_98 = "SERVER_RESPONSE_CODE_98";
    private static final String SERVER_RESPONSE_CODE_99 = "SERVER_RESPONSE_CODE_99";
    private static final String SERVER_RESPONSE_CODE_1002 = "SERVER_RESPONSE_CODE_1002";
    private static final String SERVER_RESPONSE_CODE_1010 = "SERVER_RESPONSE_CODE_1010";
    private static final String SERVER_RESPONSE_CODE_1011 = "SERVER_RESPONSE_CODE_1011";
    private static final String SERVER_RESPONSE_CODE_1012 = "SERVER_RESPONSE_CODE_1012";
    private static final String SERVER_RESPONSE_CODE_1013 = "SERVER_RESPONSE_CODE_1013";
    private static final String SERVER_RESPONSE_CODE_1014 = "SERVER_RESPONSE_CODE_1014";
    private static final String SERVER_RESPONSE_CODE_1020 = "SERVER_RESPONSE_CODE_1020";

    private DIDPlugRegistrationManager() {

    }

    public static void initDIDServerWithParams(Context context, JSONArray args, CallbackContext callbackContext) throws JSONException {
        JSONObject serverUrlJson = args.getJSONObject(0);
        String serverURL = "";

        if (serverUrlJson != null) {
            String initParams = serverUrlJson.getString(INIT_PARAMS);
            serverURL = new JSONObject(initParams).getString(SERVER_URL);
        }

        InitParams initParams = new InitParams.InitParamsBuilder()
                .addDidUrl(serverURL)
                .build();
        DetectID.sdk(context).initDIDServerWithParams(initParams);

        DetectID.sdk(context).PUSH_API.enablePushAlertDefaultDialog(false);
        DetectID.sdk(context).PUSH_API.enablePushTransactionDefaultDialog(false);

        callbackContext.success();
    }

    public static void didInit(Context context, CallbackContext callbackContext) throws IllegalArgumentException {
        DetectID.sdk(context).didInit();
    }

    public static void setDeviceRegistrationListener(Context context, CallbackContext callbackContext) throws IllegalArgumentException {
        DetectID.sdk(context).setDeviceRegistrationServerResponseListener(new DIDPluginRegistrationServerResponseListener(callbackContext));
    }

    public static void setDeviceRegistrationByCode(Context myContext, JSONArray args, CallbackContext callbackContext) throws JSONException {
        JSONObject jsonDevicerRegistrationByCode = args.getJSONObject(0);
        String code = jsonDevicerRegistrationByCode.getString(CODE);
        if (code != null) {
            DetectID.sdk(myContext).setDeviceRegistrationServerResponseListener(new DIDPluginRegistrationServerResponseListener(callbackContext));
            DetectID.sdk(myContext).deviceRegistrationByCode(code);
        } else {
            callbackContext.error(CODE_IS_NULL);
        }
    }

    public static void setDeviceRegistrationByQrCode(Context myContext, JSONArray args, CallbackContext callbackContext) throws JSONException {
        DetectID.sdk(myContext).setDeviceRegistrationServerResponseListener(new DIDPluginRegistrationServerResponseListener(callbackContext));
        DetectID.sdk(myContext).deviceRegistrationByQRCode();
    }

    // public static void displayDeviceRegistration(Context myContext, CallbackContext callbackContext) throws JSONException {
    //     DetectID.sdk(myContext).displayDeviceRegistrationDialog();
    //     callbackContext.success();
    // }

    public static void setRegistrationViewProperties(Context myContext, JSONArray args, CallbackContext callbackContext) throws JSONException {
        JSONObject registrationViewPropertiesJSON = new JSONObject(args.get(0).toString());
        RegistrationViewProperties registrationProperties = new RegistrationViewProperties(myContext);

        if (registrationViewPropertiesJSON.has(TITLE)) {
            registrationProperties.TITLE = registrationViewPropertiesJSON.getString(TITLE);
        }
        if (registrationViewPropertiesJSON.has(MESSAGE)) {
            registrationProperties.MESSAGE = registrationViewPropertiesJSON.getString(MESSAGE);
        }
        if (registrationViewPropertiesJSON.has(CONFIRM)) {
            registrationProperties.CONFIRM = registrationViewPropertiesJSON.getString(CONFIRM);
        }
        if (registrationViewPropertiesJSON.has(CANCEL)) {
            registrationProperties.CANCEL = registrationViewPropertiesJSON.getString(CANCEL);
        }
        if (registrationViewPropertiesJSON.has(SERVER_RESPONSE_CODE_98)) {
            registrationProperties.SERVER_RESPONSE_CODE_98 = registrationViewPropertiesJSON.getString(SERVER_RESPONSE_CODE_98);
        }
        if (registrationViewPropertiesJSON.has(SERVER_RESPONSE_CODE_99)) {
            registrationProperties.SERVER_RESPONSE_CODE_99 = registrationViewPropertiesJSON.getString(SERVER_RESPONSE_CODE_99);
        }
        if (registrationViewPropertiesJSON.has(SERVER_RESPONSE_CODE_1002)) {
            registrationProperties.SERVER_RESPONSE_CODE_1002 = registrationViewPropertiesJSON.getString(SERVER_RESPONSE_CODE_1002);
        }
        if (registrationViewPropertiesJSON.has(SERVER_RESPONSE_CODE_1010)) {
            registrationProperties.SERVER_RESPONSE_CODE_1010 = registrationViewPropertiesJSON.getString(SERVER_RESPONSE_CODE_1010);
        }
        if (registrationViewPropertiesJSON.has(SERVER_RESPONSE_CODE_1011)) {
            registrationProperties.SERVER_RESPONSE_CODE_1011 = registrationViewPropertiesJSON.getString(SERVER_RESPONSE_CODE_1011);
        }
        if (registrationViewPropertiesJSON.has(SERVER_RESPONSE_CODE_1012)) {
            registrationProperties.SERVER_RESPONSE_CODE_1012 = registrationViewPropertiesJSON.getString(SERVER_RESPONSE_CODE_1012);
        }
        if (registrationViewPropertiesJSON.has(SERVER_RESPONSE_CODE_1013)) {
            registrationProperties.SERVER_RESPONSE_CODE_1013 = registrationViewPropertiesJSON.getString(SERVER_RESPONSE_CODE_1013);
        }
        if (registrationViewPropertiesJSON.has(SERVER_RESPONSE_CODE_1014)) {
            registrationProperties.SERVER_RESPONSE_CODE_1014 = registrationViewPropertiesJSON.getString(SERVER_RESPONSE_CODE_1014);
        }
        if (registrationViewPropertiesJSON.has(SERVER_RESPONSE_CODE_1020)) {
            registrationProperties.SERVER_RESPONSE_CODE_1020 = registrationViewPropertiesJSON.getString(SERVER_RESPONSE_CODE_1020);
        }
        DetectID.sdk(myContext).setRegistrationViewProperties(registrationProperties);
        callbackContext.success();
    }

    public static void enableRegistrationServerResponse(Context myContext, JSONArray args, CallbackContext callbackContext) throws JSONException {
        JSONObject jsonClient = args.getJSONObject(0);
        DetectID.sdk(myContext).enableRegistrationServerResponseAlerts(jsonClient.getBoolean(ENABLE));
        callbackContext.success();
    }
}
