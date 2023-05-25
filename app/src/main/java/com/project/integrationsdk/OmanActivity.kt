package com.project.integrationsdk

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
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

        mainApplication.clevertapAdditionalInstance!!.pushEvent("Oman Dashboard Entered")

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