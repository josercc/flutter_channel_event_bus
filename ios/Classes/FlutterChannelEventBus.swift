import Flutter
import UIKit

public class FlutterChannelEventBus: NSObject {
    /// 消息的注册者
    var registers:[FlutterChannelEventBusRegister] = []
    /// 处理消息的通道
    var methodChannel:FlutterMethodChannel?
    /// 防止外部初始化
    private override init() {}
    
    /// 获取真正传输的方法名称
    /// - Parameters:
    ///   - name: 传输的方法
    ///   - route: 传输的路由
    /// - Returns: 真正传输的方法名称
    func callMethodName(name:String, route:FlutterChannelEventBusRoute) -> String {
        return "\(route.name)_\(name)"
    }
}

public extension FlutterChannelEventBus {
    /// 获取单例
    static let `default` = FlutterChannelEventBus()
}

public extension FlutterChannelEventBus {
    /// 数据获取到的回掉
    typealias FlutterChannelEventBusResponsehandle = (FlutterChannelEventBusResponse) -> Void
}

public extension FlutterChannelEventBus {
    /// 注册消息
    /// - Parameters:
    ///   - name: 消息的方法名称
    ///   - route: 消息的路由 [默认路由]
    ///   - handle: 数据的回掉
    ///   - return: 消息的唯一ID
    @discardableResult
    func register(event name:String,
                         route:FlutterChannelEventBusRoute = FlutterChannelEventBusRoute(),
                         handle:@escaping FlutterChannelEventBusResponsehandle) -> String {
        let registerId = "flutter_channel_event_bus_\(Date().timeIntervalSince1970)"
        registers.append(FlutterChannelEventBusRegister(registerId: registerId, name: name, route: route, handle: handle))
        return registerId
    }
    
    /// 取消注册
    /// - Parameter registerId: 注册的唯一ID
    func deregister(event registerId:String) {
        guard let index = registers.firstIndex(where: {$0.registerId == registerId}) else {
            return
        }
        registers.remove(at: index)
    }
    
    /// 发送消息数据
    /// - Parameters:
    ///   - name: 消息的方法名称
    ///   - route: 消息路由 [默认路由]
    ///   - data: 发送的数据
    ///   - result: 相应的数据
    func send(event name:String, route:FlutterChannelEventBusRoute = FlutterChannelEventBusRoute(), data:Any?, result:@escaping FlutterResult) {
        guard let data = data,
              let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed),
              let jsonText = String(data: jsonData, encoding: .utf8) else {
            result(nil)
            return
        }
        methodChannel?.invokeMethod(callMethodName(name: name, route: route), arguments: jsonText, result: result)
    }
}
