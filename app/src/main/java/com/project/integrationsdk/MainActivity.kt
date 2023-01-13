package com.project.integrationsdk

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import com.project.integrationsdk.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    lateinit var binding : ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.omanEnv.setOnClickListener {
            startActivity(Intent(applicationContext, OmanActivity::class.java))
            Toast.makeText(applicationContext, "Oman Activity", Toast.LENGTH_SHORT).show()
        }
        binding.kuwaitEnv.setOnClickListener {
            startActivity(Intent(applicationContext, KuwaitActivity::class.java))
            Toast.makeText(applicationContext, "Oman Activity", Toast.LENGTH_SHORT).show()
        }

    }
}