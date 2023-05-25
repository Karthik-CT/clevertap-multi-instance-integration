package com.project.integrationsdk

import android.annotation.SuppressLint
import android.app.NotificationManager
import android.os.Build
import android.widget.Toast
import com.clevertap.android.pushtemplates.PushTemplateNotificationHandler
import com.clevertap.android.sdk.ActivityLifecycleCallback
import com.clevertap.android.sdk.Application
import com.clevertap.android.sdk.CleverTapAPI
import com.clevertap.android.sdk.CleverTapInstanceConfig
import com.clevertap.android.sdk.interfaces.NotificationHandler
import com.clevertap.android.sdk.pushnotification.CTPushNotificationListener
import java.util.HashMap

class MainApplication : Application(), CTPushNotificationListener {

    var clevertapAdditionalInstance: CleverTapAPI? = null
    var clevertapAdditionalInstanceConfig: CleverTapInstanceConfig? = null
    var cleverTapDefaultInstance: CleverTapAPI? = null

    @SuppressLint("MParticleInitialization")
    override fun onCreate() {
        ActivityLifecycleCallback.register(this)
        super.onCreate()

        clevertapAdditionalInstance = CleverTapAPI.getDefaultInstance(applicationContext)

        CleverTapAPI.setDebugLevel(CleverTapAPI.LogLevel.DEBUG)
        cleverTapDefaultInstance = CleverTapAPI.getDefaultInstance(applicationContext)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            CleverTapAPI.createNotificationChannelGroup(
                applicationContext,
                "testkk1",
                "Notification Test"
            )
        }
        CleverTapAPI.createNotificationChannel(
            applicationContext, "testkk123", "Notification Test", "CleverTap Notification Test",
            NotificationManager.IMPORTANCE_MAX, true
        )
        CleverTapAPI.createNotificationChannel(
            applicationContext,
            "testkk1234",
            "KK Notification Test",
            "KK CleverTap Notification Test",
            NotificationManager.IMPORTANCE_MAX,
            true
        )

        //push templates
        CleverTapAPI.setNotificationHandler(PushTemplateNotificationHandler() as NotificationHandler)

        cleverTapDefaultInstance?.enableDeviceNetworkInfoReporting(true)
    }

    fun initializeCountry(country: String) {
        if (country == "Oman") {
            clevertapAdditionalInstanceConfig = CleverTapInstanceConfig.createInstance(
                this,
                "TEST-RK4-66R-966Z",
                "TEST-266-432"
            )

            clevertapAdditionalInstanceConfig!!.setDebugLevel(CleverTapAPI.LogLevel.DEBUG)
            clevertapAdditionalInstanceConfig!!.isAnalyticsOnly = true
            clevertapAdditionalInstanceConfig!!.useGoogleAdId(false)
            clevertapAdditionalInstanceConfig!!.enablePersonalization(false)

            clevertapAdditionalInstance = CleverTapAPI.instanceWithConfig(this, clevertapAdditionalInstanceConfig)

        } else if (country == "Kuwait") {
            clevertapAdditionalInstanceConfig = CleverTapInstanceConfig.createInstance(
                this,
                "TEST-W8W-6WR-846Z",
                "TEST-206-0b0"
            )

            clevertapAdditionalInstanceConfig!!.setDebugLevel(CleverTapAPI.LogLevel.DEBUG)
            clevertapAdditionalInstanceConfig!!.isAnalyticsOnly = true
            clevertapAdditionalInstanceConfig!!.useGoogleAdId(false)
            clevertapAdditionalInstanceConfig!!.enablePersonalization(false)

            clevertapAdditionalInstance = CleverTapAPI.instanceWithConfig(this, clevertapAdditionalInstanceConfig)
        }
    }

    override fun onNotificationClickedPayloadReceived(payload: HashMap<String, Any>?) {
        println("appl_paylaod: $payload")
    }
}