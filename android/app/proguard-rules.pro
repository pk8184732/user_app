
# Keep Razorpay SDK classes
-keep class com.razorpay.** { *; }

# Ignore missing proguard annotations
-dontwarn proguard.annotation.**

# Ignore Google Pay related classes (not needed if you don’t use GPay directly)
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.**
-keep class com.google.android.apps.nbu.paisa.inapp.client.api.** { *; }
