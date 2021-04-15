
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterChannelEventBus {
  static const MethodChannel _channel =
      const MethodChannel('flutter_channel_event_bus');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
