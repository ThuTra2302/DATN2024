package com.datn.tra.travelweather


import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity : FlutterActivity() {
    @Override
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.getPlugins().add(GoogleMobileAdsPlugin())
        super.configureFlutterEngine(flutterEngine)



    }

}