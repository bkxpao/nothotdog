package com.example.application

import android.os.Bundle

import io.flutter.app.FlutterActivity
//import org.devio.flutter.splashscreen.flutter_splash_screen.SplashScreen;
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
//    SplashScreen.show(this, true)
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }
}
