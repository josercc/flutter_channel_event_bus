/// Flutter通信设置的路由
class FlutterChannelEventBusRoute {
  /// 路由的名称
  final String name;

  /// 通用的路由
  FlutterChannelEventBusRoute.general() : name = "flutter_channel_event_bus_route";

  /// 设置指定的路由
  FlutterChannelEventBusRoute.custom(this.name);
}
