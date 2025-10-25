package com.example.surkatha

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.app.Application

// We are keeping this Application class minimal, as the previous engine caching
// logic (which was removed in the last update) caused conflicts.
class Application : Application() {
    override fun onCreate() {
        super.onCreate()
    }
}

class MainActivity: FlutterFragmentActivity() {
    // CRITICAL FIX: This method ensures that the FlutterEngine used by this specific
    // Activity is explicitly configured to register all necessary plugins (including
    // audio_service and permission_handler).
    // This resolves the "wrong FlutterEngine" and "Unable to detect current Android Activity" errors.
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
