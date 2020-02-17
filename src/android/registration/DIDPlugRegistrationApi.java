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
import android.util.Log;

import net.easysol.did.DetectID;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

public class DIDPlugRegistrationApi extends CordovaPlugin {

    private final String TAG = "DetectIDCordovaPlugin";
    private Context myContext;

    private final String INIT_WITH_PARAMS = "initDIDServerWithParams";
    private final String DID_INIT = "didInit";
    private final String SET_DEVICE_REGISTRATION_SERVER_RESPONSE_LISTENER = "setDeviceRegistrationServerResponseListener";
    private final String DEVICE_REGISTRATION_BY_CODE = "deviceRegistrationByCode";
    private final String SET_REGISTRATION_VIEW_PROPERTIES = "setRegistrationViewProperties";
    private final String DISPLAY_DEVICE_REGISTRATION_DIALOG = "displayDeviceRegistrationDialog";
    private final String ENABLE_REGISTRATION_SERVER_RESPONSE_ALERTS = "enableRegistrationServerResponseAlerts";
    private final String DEVICE_REGISTRATION_BY_QR = "deviceRegistrationByQRCode";

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
        try {
            myContext = cordova.getActivity().getApplicationContext();
            DetectID.sdk(myContext);

            if (action.equals(INIT_WITH_PARAMS)) {
                DIDPlugRegistrationManager.initDIDServerWithParams(myContext, args, callbackContext);
            }
            if (action.equals(DID_INIT)) {
                DIDPlugRegistrationManager.didInit(myContext, callbackContext);
            }
            if (action.equals(SET_DEVICE_REGISTRATION_SERVER_RESPONSE_LISTENER)) {
                DIDPlugRegistrationManager.setDeviceRegistrationListener(myContext, callbackContext);
            }
            if (action.equals(DEVICE_REGISTRATION_BY_CODE)) {
                DIDPlugRegistrationManager.setDeviceRegistrationByCode(myContext, args, callbackContext);
            }
            if (action.equals(DEVICE_REGISTRATION_BY_QR)) {
                DIDPlugRegistrationManager.setDeviceRegistrationByQrCode(myContext, args, callbackContext);
            }
            if (action.equals(SET_REGISTRATION_VIEW_PROPERTIES)) {
                DIDPlugRegistrationManager.setRegistrationViewProperties(myContext, args, callbackContext);
            }
            // if (action.equals(DISPLAY_DEVICE_REGISTRATION_DIALOG)) {
            //     DIDPlugRegistrationManager.displayDeviceRegistration(myContext, callbackContext);
            // }
            if (action.equals(ENABLE_REGISTRATION_SERVER_RESPONSE_ALERTS)) {
                DIDPlugRegistrationManager.enableRegistrationServerResponse(myContext, args, callbackContext);
            }

            return true;
        } catch (JSONException e) {
            Log.e(TAG, e.toString());
            callbackContext.error(e.toString());
        }
        return false;
    }
}
