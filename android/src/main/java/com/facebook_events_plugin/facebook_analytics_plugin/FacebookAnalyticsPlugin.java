package com.facebook_events_plugin.facebook_analytics_plugin;

import android.os.Bundle;

import com.facebook.FacebookSdk;
import com.facebook.LoggingBehavior;
import com.facebook.appevents.AppEventsLogger;

import java.util.Iterator;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;




/** FacebookAnalyticsPlugin */
public class FacebookAnalyticsPlugin implements MethodCallHandler {
  private final PluginRegistry.Registrar registrar;
  private  final AppEventsLogger appEventsLogger;

  private FacebookAnalyticsPlugin(PluginRegistry.Registrar registrar) {
    this.registrar = registrar;
    FacebookSdk.setAutoInitEnabled(true);
    FacebookSdk.fullyInitialize();
    System.out.println(FacebookSdk.isInitialized());
    appEventsLogger = AppEventsLogger.newLogger(registrar.context());

    if (BuildConfig.DEBUG) {
      FacebookSdk.setIsDebugEnabled(true);
      FacebookSdk.addLoggingBehavior(LoggingBehavior.APP_EVENTS);
    }

  }


  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {

    final MethodChannel channel = new MethodChannel(registrar.messenger(), "facebook_analytics_plugin");
    channel.setMethodCallHandler(new FacebookAnalyticsPlugin(registrar));
  }



  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("logEvent")) {
      handleLogEvent(call,result);
    } else {
      result.notImplemented();
    }
  }

  private void handleLogEvent(MethodCall call, Result result) {

    System.out.println(call.argument("parameters"));
    Map<String,Object> parameters =  call.argument("parameters");
    String eventName = call.argument("name");


    if (parameters == null || parameters.isEmpty()) {
      appEventsLogger.logEvent(eventName);
      System.out.println("logged event ");
    }

    Bundle bundleParams = createBundleFromMap(parameters);
    appEventsLogger.logEvent(eventName, bundleParams);
    result.success(null);


  }

  private Bundle createBundleFromMap(Map paramMap) {
    if (paramMap.isEmpty()) {
      return null;
    }
    Bundle bundleParams = new Bundle();

    Iterator it = paramMap.entrySet().iterator();
    while (it.hasNext()) {
      Map.Entry pair = (Map.Entry)it.next();
      switch (pair.getValue().getClass().getSimpleName()) {
        case  "String":
          bundleParams.putString((String)pair.getKey(), (String)pair.getValue());
          break;
        case "Integer":
          System.out.println("int here bra");
          bundleParams.putInt((String) pair.getKey(), (Integer) pair.getValue());
          break;
        case "Long":
          bundleParams.putLong((String)pair.getKey(),(Long)pair.getValue());
          break;
        case "Double":
          bundleParams.putDouble((String) pair.getKey(), (Double) pair.getValue());
          break;
        case "Boolean":
          bundleParams.putBoolean((String) pair.getKey(), (Boolean) pair.getValue());
          break;
        default:
          throw new IllegalArgumentException("Unsupported value type: " + pair.getKey().getClass().getSimpleName());

      }
      System.out.println(pair.getKey() + " = " + pair.getValue());
      it.remove();

    }
    return  bundleParams;
  }
}
