import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_channel_event_bus/flutter_channel_event_bus_register.dart';
import 'package:flutter_channel_event_bus/flutter_channel_event_bus_response.dart';
import 'package:flutter_channel_event_bus/flutter_channel_event_bus_route.dart';

/// 通道数据回掉
/// - parameter response: 通道消息
/// - return Future<dynamic> 返回的数据
typedef FlutterChannelEventBusResponseHandle = Future<dynamic> Function(FlutterChannelEventBusResponse response);

/// 处理Flutter通道消息
class FlutterChannelEventBus {
  /// 私有的通道
  static const MethodChannel _channel = const MethodChannel('flutter_channel_event_bus');

  /// 默认的单例对象
  static FlutterChannelEventBus defaultEventBus = FlutterChannelEventBus._();

  /// 存储注册
  List<FlutterChannelEventBusRegister> registers = [];

  /// 私有的初始化方法
  FlutterChannelEventBus._() {
    _channel.setMethodCallHandler((call) async {
      List<FlutterChannelEventBusRegister> callRegisters = registers.where((element) {
        String method = _callMethodName(element.methodName, element.route);
        return call.method == method;
      }).toList();
      if (callRegisters.length > 0) {
        dynamic response;
        for (var register in callRegisters) {
          if (response == null) {
            response = await register.handle(FlutterChannelEventBusResponse(call.arguments, register));
          } else {
            register.handle(FlutterChannelEventBusResponse(call.arguments, register));
          }
        }
        return response;
      } else {
        throw "${call.method}不支持";
      }
    });
  }

  /// 注册消息接收
  /// [name] 对应消息方法名称
  /// [route] 消息处理的路由
  /// [handle] 数据相应回掉
  /// [注册消息接收的唯一ID]
  String register(String name, FlutterChannelEventBusRoute route, FlutterChannelEventBusResponseHandle handle) {
    assert(name != null && route != null && handle != null);
    String registerId = "flutter_channel_event_bus_${DateTime.now().microsecondsSinceEpoch}";
    registers.add(FlutterChannelEventBusRegister(
      registerId: registerId,
      route: route,
      methodName: name,
      handle: handle,
    ));
    return registerId;
  }

  /// 取消注册消息的接收
  /// [registerId] 注册的唯一ID
  void deregister(String registerId) {
    var first = registers.firstWhere((element) => element.registerId == registerId, orElse: () => null);
    if (first == null) {
      return;
    }
    registers.remove(first);
  }

  /// 发送通道数据
  /// [name] 发送的方法名称
  /// [route] 发送数据的路由方式
  /// [data] 发送的数据 [数据必须是Map或者是List]
  /// [相应返回的数据]
  Future<dynamic> send(String name, FlutterChannelEventBusRoute route, dynamic data) async {
    assert((name != null && route != null) || data != null);
    return _channel.invokeMethod(_callMethodName(name, route), json.encode(data));
  }

  /// 获取真正传输的方法名称
  /// [name] 设置的传输方法名称
  /// [route] 设置的传输路由
  /// [真正的传输方法名称]
  String _callMethodName(String name, FlutterChannelEventBusRoute route) {
    return "${route.name}_$name";
  }
}
