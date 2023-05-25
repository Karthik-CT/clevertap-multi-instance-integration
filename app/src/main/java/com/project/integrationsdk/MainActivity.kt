package com.project.integrationsdk

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import com.project.integrationsdk.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

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
}