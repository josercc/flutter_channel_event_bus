import 'package:flutter_channel_event_bus/flutter_channel_event_bus.dart';
import 'package:flutter_channel_event_bus/flutter_channel_event_bus_response.dart';
import 'package:flutter_channel_event_bus/flutter_channel_event_bus_route.dart';

/// 消息注册信息
class FlutterChannelEventBusRegister {
  /// 消息注册的唯一ID
  final String registerId;

  /// 消息的路由
  final FlutterChannelEventBusRoute route;

  /// 数据回掉
  final FlutterChannelEventBusResponseHandle handle;

  /// 指定的传输方法
  final String methodName;

  /// 初始化
  FlutterChannelEventBusRegister({this.registerId, this.route, this.handle, this.methodName});
}
