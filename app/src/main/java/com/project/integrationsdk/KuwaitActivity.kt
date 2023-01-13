package com.project.integrationsdk

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.clevertap.android.sdk.CleverTapAPI
import com.clevertap.android.sdk.CleverTapInstanceConfig
import com.project.integrationsdk.databinding.ActivityKuwaitBinding


class KuwaitActivity : AppCompatActivity() {

    lateinit var binding: ActivityKuwaitBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityKuwaitBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val clevertapAdditionalInstanceConfig = CleverTapInstanceConfig.createInstance(
            this,
            "TEST-W8W-6WR-846Z",
            "TEST-206-0b0"
        )

        clevertapAdditionalInstanceConfig.setDebugLevel(CleverTapAPI.LogLevel.DEBUG)
        clevertapAdditionalInstanceConfig.isAnalyticsOnly = true
        clevertapAdditionalInstanceConfig.useGoogleAdId(false)
        clevertapAdditionalInstanceConfig.enablePersonalization(false)

        val clevertapAdditionalInstance =
            CleverTapAPI.instanceWithConfig(this, clevertapAdditionalInstanceConfig)

        clevertapAdditionalInstance.pushEvent("Kuwait Dashboard Entered")

        binding.onUserLogin.setOnClickListener {
            kuwaitOnUserLogin(clevertapAdditionalInstance)
        }

    }

    private fun kuwaitOnUserLogin(clevertapAdditionalInstance: CleverTapAPI?) {
        val profile = HashMap<String, Any>()
        profile["Name"] = binding.userName.text.toString()
        profile["Identity"] = binding.userIdentity.text.toString()
        profile["Email"] = binding.emailId.text.toString()
        profile["Phone"] = binding.mobileNo.text.toString()
        profile["MSG-email"] = true
        profile["MSG-push"] = true
        profile["MSG-sms"] = true
        profile["MSG-whatsapp"] = true
        clevertapAdditionalInstance?.onUserLogin(profile)
    }
}