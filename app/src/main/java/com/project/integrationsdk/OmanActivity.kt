package com.project.integrationsdk

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.clevertap.android.sdk.CleverTapAPI
import com.clevertap.android.sdk.CleverTapInstanceConfig
import com.project.integrationsdk.databinding.ActivityOmanBinding

class OmanActivity : AppCompatActivity() {

    lateinit var binding: ActivityOmanBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityOmanBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val clevertapAdditionalInstanceConfig = CleverTapInstanceConfig.createInstance(
            this,
            "TEST-RK4-66R-966Z",
            "TEST-266-432"
        )

        clevertapAdditionalInstanceConfig.setDebugLevel(CleverTapAPI.LogLevel.DEBUG)
        clevertapAdditionalInstanceConfig.isAnalyticsOnly = true
        clevertapAdditionalInstanceConfig.useGoogleAdId(false)
        clevertapAdditionalInstanceConfig.enablePersonalization(false)

        val clevertapAdditionalInstance = CleverTapAPI.instanceWithConfig(this, clevertapAdditionalInstanceConfig)

        clevertapAdditionalInstance.pushEvent("Oman Dashboard Entered")

        binding.onUserLogin.setOnClickListener {
            omanOnUserLogin(clevertapAdditionalInstance)
        }
    }

    private fun omanOnUserLogin(clevertapAdditionalInstance: CleverTapAPI?) {
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