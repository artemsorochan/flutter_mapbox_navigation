package com.eopeter.flutter_mapbox_navigation.activity

import android.app.Activity
import android.content.Intent
import com.mapbox.geojson.Point
import java.io.Serializable

object NavigationLauncher {
    const val KEY_STOP_NAVIGATION = "com.my.mapbox.broadcast.STOP_NAVIGATION"
    fun startNavigation(activity: Activity, wayPoints: List<Point?>?) {
        val navigationIntent = Intent(activity, NavigationActivity::class.java)
        navigationIntent.putExtra("waypoints", wayPoints as Serializable?)
        activity.startActivity(navigationIntent)
    }

    fun stopNavigation(activity: Activity) {
        val stopIntent = Intent()
        stopIntent.action = KEY_STOP_NAVIGATION
        activity.sendBroadcast(stopIntent)
    }
}