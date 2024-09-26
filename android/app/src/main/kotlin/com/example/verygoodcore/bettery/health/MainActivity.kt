package com.example.verygoodcore.bettery_health

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.verygoodcore.bettery_health/batteryHealth"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).apply {
            setMethodCallHandler { call, result ->
                if (call.method == "getBatteryLevel") {
                    try {
                        val batteryStatus: Intent? = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { ifilter ->
                            context.registerReceiver(null, ifilter)
                        }

                        val batteryPct: Float? = batteryStatus?.let { intent ->
                            val level: Int = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
                            val scale: Int = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
                            (level * 100 / scale.toFloat()) // Assign the result to batteryPct
                        }

                        // Return the calculated battery percentage
                        if (batteryPct != null) {
                            result.success(batteryPct)
                        } else {
                            result.error("UNAVAILABLE", "Battery level not available", null)
                        }
                    } catch (e: Exception) {
                        result.error("UNAVAILABLE", "Battery level not available",null)
                    }
                } else {
                    result.error("UNAVAILABLE", "No such method",null)
                }
            }
        }
    }
}
