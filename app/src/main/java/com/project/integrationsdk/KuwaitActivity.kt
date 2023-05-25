package com.project.integrationsdk

import android.app.NotificationManager
import android.os.Build
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.clevertap.android.sdk.CleverTapAPI
import com.clevertap.android.sdk.CleverTapInstanceConfig
import com.project.integrationsdk.databinding.ActivityKuwaitBinding


class KuwaitActivity : AppCompatActivity() {

    lateinit var binding: ActivityKuwaitBinding
    lateinit var mainApplication: MainApplication

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityKuwaitBinding.inflate(layoutInflater)
        setContentView(binding.root)

        mainApplication = application as MainApplication

        mainApplication.clevertapAdditionalInstance!!.pushEvent("Kuwait Dashboard Entered")

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