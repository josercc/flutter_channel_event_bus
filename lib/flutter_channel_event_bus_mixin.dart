import 'package:flutter_channel_event_bus/flutter_channel_event_bus.dart';

mixin FlutterChannelEventBusMixin {
  /// 存放已经注册ID数组
  final List<String> _eventBusRegisterIds = [];

  /// 释放注册的通知
  void freeRegisters() {
    for (var element in _eventBusRegisterIds) {
      FlutterChannelEventBus.defaultEventBus.deregister(element);
    }
  }

  /// 注册一个通用的通知
  /// [name]注册的名称
  /// [handle]消息回掉
  String register(
    String name,
    FlutterChannelEventBusResponseHandle handle,
  ) {
    var route = FlutterChannelEventBusRoute.general();
    var registerId = FlutterChannelEventBus.defaultEventBus.register(
      name,
      route,
      handle,
    );
    _eventBusRegisterIds.add(registerId);
    return registerId;
  }

  /// 注册一个自定义的通知
  /// [name]注册的名称
  /// [routeName]自定义消息路由
  /// [handle]消息回掉
  String registerCustom(
    String name,
    String routeName,
    FlutterChannelEventBusResponseHandle handle,
  ) {
    var route = FlutterChannelEventBusRoute.custom(routeName);
    var registerId = FlutterChannelEventBus.defaultEventBus.register(
      name,
      route,
      handle,
    );
    _eventBusRegisterIds.add(registerId);
    return registerId;
  }

  /// 通过通用的路由发送消息
  /// [name]消息的名称
  /// [data]消息的数据
  Future<dynamic> send(
    String name,
    dynamic data,
  ) {
    var route = FlutterChannelEventBusRoute.general();
    return FlutterChannelEventBus.defaultEventBus.send(
      name,
      route,
      data,
    );
  }

  /// 通过自定义的路由发送消息
  /// [name]消息名称
  /// [routeName]自定义路由名称
  /// [data]消息的数据
  Future<dynamic> sendCustom(
    String name,
    String routeName,
    dynamic data,
  ) {
    var route = FlutterChannelEventBusRoute.custom(routeName);
    return FlutterChannelEventBus.defaultEventBus.send(
      name,
      route,
      data,
    );
  }
}
