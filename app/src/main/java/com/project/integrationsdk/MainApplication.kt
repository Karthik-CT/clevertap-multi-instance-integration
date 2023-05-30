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

class MainApplication : Application() {

    var clevertapAdditionalInstance: CleverTapAPI? = null
    var clevertapAdditionalInstanceConfig: CleverTapInstanceConfig? = null

    @SuppressLint("MParticleInitialization")
    override fun onCreate() {
        ActivityLifecycleCallback.register(this)
        super.onCreate()

        clevertapAdditionalInstance = CleverTapAPI.getDefaultInstance(applicationContext)

        CleverTapAPI.setDebugLevel(CleverTapAPI.LogLevel.DEBUG)
    }

    fun initializeCountry(country: String) {
        if (country == "Oman") {
            clevertapAdditionalInstanceConfig = CleverTapInstanceConfig.createInstance(
                this,
                "account_id",
                "account_token"
            )

            clevertapAdditionalInstanceConfig!!.setDebugLevel(CleverTapAPI.LogLevel.DEBUG)
            clevertapAdditionalInstanceConfig!!.isAnalyticsOnly = false
            clevertapAdditionalInstanceConfig!!.useGoogleAdId(false)
            clevertapAdditionalInstanceConfig!!.enablePersonalization(false)

            clevertapAdditionalInstance = CleverTapAPI.instanceWithConfig(applicationContext, clevertapAdditionalInstanceConfig)


        } else if (country == "Kuwait") {
            clevertapAdditionalInstanceConfig = CleverTapInstanceConfig.createInstance(
                this,
                "account_id",
                "account_token"
            )

            clevertapAdditionalInstanceConfig!!.setDebugLevel(CleverTapAPI.LogLevel.DEBUG)
            clevertapAdditionalInstanceConfig!!.isAnalyticsOnly = false
            clevertapAdditionalInstanceConfig!!.useGoogleAdId(false)
            clevertapAdditionalInstanceConfig!!.enablePersonalization(false)

            clevertapAdditionalInstance = CleverTapAPI.instanceWithConfig(applicationContext, clevertapAdditionalInstanceConfig)
        }
    }
}
