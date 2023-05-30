package com.project.integrationsdk

import android.app.NotificationManager
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.clevertap.android.pushtemplates.PushTemplateNotificationHandler
import com.clevertap.android.sdk.ActivityLifecycleCallback
import com.clevertap.android.sdk.CleverTapAPI
import com.clevertap.android.sdk.CleverTapInstanceConfig
import com.clevertap.android.sdk.interfaces.NotificationHandler
import com.project.integrationsdk.databinding.ActivityKuwaitBinding

class KuwaitActivity : AppCompatActivity() {

    lateinit var binding: ActivityKuwaitBinding
    lateinit var mainApplication: MainApplication

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityKuwaitBinding.inflate(layoutInflater)
        setContentView(binding.root)

        mainApplication = application as MainApplication

        CleverTapAPI.setDebugLevel(CleverTapAPI.LogLevel.DEBUG)

        //push templates
        CleverTapAPI.setNotificationHandler(PushTemplateNotificationHandler() as NotificationHandler)

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

        mainApplication.clevertapAdditionalInstance!!.pushEvent("Kuwait Dashboard Entered")

        mainApplication.clevertapAdditionalInstance!!.enableDeviceNetworkInfoReporting(true)



        binding.onUserLogin.setOnClickListener {
            kuwaitOnUserLogin()
        }

    }

    private fun kuwaitOnUserLogin() {
        val profile = HashMap<String, Any>()
        profile["Name"] = binding.userName.text.toString()
        profile["Identity"] = binding.userIdentity.text.toString()
        profile["Email"] = binding.emailId.text.toString()
        profile["Phone"] = binding.mobileNo.text.toString()
        profile["MSG-email"] = true
        profile["MSG-push"] = true
        profile["MSG-sms"] = true
        profile["MSG-whatsapp"] = true
        mainApplication.clevertapAdditionalInstance!!.onUserLogin(profile)
        Toast.makeText(applicationContext, "Kuwait OnUserLogin Clicked", Toast.LENGTH_SHORT).show()

    }
}