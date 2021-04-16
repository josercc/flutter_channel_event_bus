import 'package:flutter_channel_event_bus/flutter_channel_event_bus_register.dart';

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
}
