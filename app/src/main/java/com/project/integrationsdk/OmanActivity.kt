package com.project.integrationsdk

import android.app.NotificationManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import com.clevertap.android.pushtemplates.PushTemplateNotificationHandler
import com.clevertap.android.sdk.CleverTapAPI
import com.clevertap.android.sdk.interfaces.NotificationHandler
import com.project.integrationsdk.databinding.ActivityOmanBinding

class OmanActivity : AppCompatActivity() {

    lateinit var binding: ActivityOmanBinding
    lateinit var mainApplication: MainApplication

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityOmanBinding.inflate(layoutInflater)
        setContentView(binding.root)

        mainApplication = application as MainApplication

        binding.onUserLogin.setOnClickListener {
            omanOnUserLogin()
        }

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

        mainApplication.clevertapAdditionalInstance!!.enableDeviceNetworkInfoReporting(true)

        mainApplication.clevertapAdditionalInstance!!.pushEvent("Oman Dashboard Entered")
        mainApplication.clevertapAdditionalInstance!!.pushEvent("KK Segment CT Completed")

    }

    private fun omanOnUserLogin() {
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
        Toast.makeText(applicationContext, "Oman OnUserLogin Clicked", Toast.LENGTH_SHORT).show()
    }
}