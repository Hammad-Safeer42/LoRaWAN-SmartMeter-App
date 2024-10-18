package com.smartmetering.app
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import android.net.Uri

class SmartHomeWidget : HomeWidgetProvider() {
   override fun onUpdate(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetIds: IntArray,
            widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.smart_home_widget).apply {
                val units = widgetData.getString("units", "00")
                val watts = widgetData.getString("kwatts", "0 kW")
                setTextViewText(R.id.units, units)
                setTextViewText(R.id.kwatts, watts)

                val incrementIntent = HomeWidgetBackgroundIntent.getBroadcast(
                        context,
                        Uri.parse("smartHomeWidget://increment")
                )
                

                setOnClickPendingIntent(R.id.button_refresh, incrementIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}