import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class FacebookAnalyticsPlugin {
  static const MethodChannel _channel =
      const MethodChannel('facebook_analytics_plugin');

  /// The achievement of specific levels you define within your application, business or organization.
  static Future<void> logAchievedLevel({@required String level})async{
    assert(level.isNotEmpty);
    await _channel.invokeMethod("EVENT_NAME_ACHIEVED_LEVEL", level);
  }

  /// Logs a custom Facebook event with the given [name] and event [parameters].
  static Future<void> logCustomEvent(
      {@required String name, Map<String, dynamic> parameters}) async {
    if (parameters == null) {
      parameters = {};
    }

    await _channel
        .invokeMethod('logCustomEvent', {"name": name, "parameters": parameters});
  }
}
