package com.example.chat_flutter

import io.flutter.embedding.android.FlutterActivity
import android.view.WindowManager.LayoutParams
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.configureFlutterEngine(flutterEngine)
    }
}
