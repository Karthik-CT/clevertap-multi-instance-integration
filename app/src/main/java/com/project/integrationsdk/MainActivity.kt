package com.project.integrationsdk

import android.content.Intent
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import com.clevertap.android.sdk.pushnotification.CTPushNotificationListener
import com.project.integrationsdk.databinding.ActivityMainBinding
import java.util.HashMap

class MainActivity : AppCompatActivity(), CTPushNotificationListener {

    lateinit var binding : ActivityMainBinding
    lateinit var mainApplication: MainApplication

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        mainApplication = application as MainApplication

        binding.omanEnv.setOnClickListener {
            startActivity(Intent(applicationContext, OmanActivity::class.java))
            mainApplication.initializeCountry("Oman")
            Toast.makeText(applicationContext, "Oman Activity", Toast.LENGTH_SHORT).show()
        }
        binding.kuwaitEnv.setOnClickListener {
            startActivity(Intent(applicationContext, KuwaitActivity::class.java))
            mainApplication.initializeCountry("Kuwait")
            Toast.makeText(applicationContext, "Kuwait Activity", Toast.LENGTH_SHORT).show()
        }

    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            mainApplication.clevertapAdditionalInstance!!.pushNotificationClickedEvent(intent!!.extras)
        }
    }

    override fun onNotificationClickedPayloadReceived(payload: HashMap<String, Any>?) {
        println("appl_paylaod: $payload")
    }

}