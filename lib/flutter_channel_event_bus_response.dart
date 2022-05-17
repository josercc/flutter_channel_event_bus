import 'dart:convert';

import 'package:flutter_channel_event_bus/flutter_channel_event_bus_register.dart';
import 'package:flutter_channel_json/flutter_channel_json.dart';

/// 消息通道传递回来的数据相应
class FlutterChannelEventBusResponse {
  /// 响应的数据
  final dynamic data;

  final FlutterChannelEventBusRegister register;

  /// 初始化
  FlutterChannelEventBusResponse(this.data, this.register);

  /// 自定义将字典转换成模型
  /// [transfer] 自定义转换闭包
  T cover<T>(T Function(dynamic data) transfer) {
    return transfer(data);
  }

  /// 获取某个值
  /// [key] 对应值的key
  T getValue<T>(String key) {
    return mapData[key];
  }

  /// 将传递的通道数据转化为字典
  Map<String, dynamic> get mapData {
    if (data is! String) {
      assert(false, "[data]必须是JSON字符串");
      return {};
    }
    var decode = json.decode(data);
    if (decode == null || decode is! Map<String, dynamic>) {
      assert(false, "[data]无法解析为字典");
      return {};
    }
    return decode;
  }

  FlutterChannelJson<T> toChannelJson<T>() {
    if (data is String) {
      return FlutterChannelJson<T>.fromJsonString(data);
    } else if (data is Map) {
      return FlutterChannelJson<T>.fromJson(data);
    } else {
      assert(false, "[data]必须是JSON字符串或者字典");
      return FlutterChannelJson.failure("[data]必须是JSON字符串或者字典");
    }
  }
}
