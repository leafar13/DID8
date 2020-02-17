# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Users/danielfernandez/Library/Android/sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

-dontwarn net.easysol.shortcuts.**
-dontwarn net.easysol.did.**
-dontwarn net.easysol.faceid.authenticator.**
-dontwarn net.easysol.liveness.**
-dontwarn net.easysol.faceid_detector_sdk.**
-dontwarn net.easysol.jni.dlib.**
-dontwarn net.easysol.mobile.commos.**
-keep class net.easysol.shortcuts.** {*;}
-keep class net.easysol.did.** {*;}
-keep class net.easysol.faceid.authenticator.** {*;}
-keep class net.easysol.liveness.** {*;}
-keep class net.easysol.faceid_detector_sdk.** {*;}
-keep class net.easysol.jni.dlib.** {*;}
-keep class net.easysol.mobile.commos.** {*;}

-dontwarn com.google.errorprone.annotations.**