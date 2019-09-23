import 'dart:async';

import 'package:meta/meta.dart';
import 'package:flutter/services.dart';


class FacebookAnalyticsPlugin {
  static const MethodChannel _channel =
      const MethodChannel('facebook_analytics_plugin');


  /// Logs a custom Flutter Analytics event with the given [name] and event [parameters].
  static Future<void> logEvent(
      {@required String name, Map<String, dynamic> parameters}) async {
    print("logging event");
    print(name);
    print(parameters);
    await _channel.invokeListMethod('logEvent', {"name": name, "parameters": parameters});
    // TODO
  }



}
