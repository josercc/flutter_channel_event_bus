import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_channel_event_bus/flutter_channel_event_bus_response.dart';

/// 通道数据回掉
typedef FlutterChannelEventBusResponseHandle = Function(FlutterChannelEventBusResponse response);

class FlutterChannelEventBus {
  /// 私有的通道
  static const MethodChannel _channel = const MethodChannel('flutter_channel_event_bus');

  /// 默认的单例对象
  static FlutterChannelEventBus defaultEventBus = FlutterChannelEventBus._();

  /// 方法字段名称
  static const String nameKey = "name";

  /// 数据字段名称
  static const String dataKey = "data";

  /// 接收数据的方法名称
  static const String responseKey = "response";

  /// 存储注册的回掉
  Map<String, List<Map<int, FlutterChannelEventBusResponseHandle>>> _responseHandleMap = {};

  /// 私有的初始化方法
  FlutterChannelEventBus._() {
    _channel.setMethodCallHandler((call) {
      if (call.method == responseKey) {
        _didReciverResponse(call.arguments);
        return;
      } else {
        throw "${call.method}不支持";
      }
    });
  }

  /// 已经收到了返回信息
  void _didReciverResponse(dynamic arguments) {
    if (arguments is! String) {
      assert(false, "传递的参数必须是JSON字符串");
      return;
    }
    dynamic araumentsMap = json.decode(arguments);
    if (araumentsMap is! Map<String, dynamic>) {
      assert(false, "传递的参数必须是JSON字符串");
      return;
    }
    Map<String, dynamic> map = (araumentsMap as Map<String, dynamic>);
    if (!map.containsKey(nameKey) || !map.containsKey(dataKey)) {
      assert(false, "传递的参数缺少$nameKey或者$dataKey字段");
      return;
    }
    String name = map[nameKey];
    if (!_responseHandleMap.containsKey(name)) {
      return;
    }
    var registerList = _registerList(name);
    registerList.forEach((element) {
      FlutterChannelEventBusResponseHandle handle = element.values.first;
      if (element.values.first == null) {
        return;
      }
      handle(map[dataKey]);
    });
  }

  /// 注册消息接收
  /// registerHash 注册对象的Hash
  /// name 对应消息的唯一标识符
  /// handle 数据相应回掉
  void register(int registerHash, String name, FlutterChannelEventBusResponseHandle handle) {
    assert(name != null, "name不能为空");
    assert(!_responseHandleMap.containsKey(name), "$name已经存在注册");
    var registerList = _registerList(name);
    registerList.add({registerHash: handle});
    _responseHandleMap[name] = registerList;
  }

  List<Map<int, FlutterChannelEventBusResponseHandle>> _registerList(String name) {
    return _responseHandleMap[name] ?? [];
  }

  /// 取消注册消息的接收
  /// registerHash 注册对象Hash
  /// name 对应消息的唯一标识符
  void deregister(int registerHash, String name) {
    var list = _registerList(name);
    var first = list.firstWhere((element) => element.containsKey(registerHash), orElse: () => null);
    if (first == null) {
      return;
    }
    list.remove(first);
    _responseHandleMap[name] = list;
  }

  /// 发送通道数据
  void sendData(String name, dynamic data) {
    assert(name != null || data != null);
    Map<String, dynamic> response = {nameKey: name, dataKey: data};
    _channel.invokeMethod(responseKey, json.encode(response));
  }
}
