/// 消息通道传递回来的数据相应
class FlutterChannelEventBusResponse {
  /// 响应的数据
  final dynamic data;
  FlutterChannelEventBusResponse(this.data);

  /// 自定义将字典转换成模型
  /// transfer: 自定义转换闭包
  T cover<T>(T Function(dynamic data) transfer) {
    return transfer(data);
  }
}
