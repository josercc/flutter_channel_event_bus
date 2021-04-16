import Flutter
import UIKit

public class FlutterChannelEventBus: NSObject {
    
    /// 防止外部初始化
    private override init() {}
    
}

public extension FlutterChannelEventBus {
    /// 获取单例
    static let `default` = FlutterChannelEventBus()
}

private extension FlutterChannelEventBus {
    enum Key:String {
        case response = "response"
        case name = "name"
        case data = "data"
    }
}

extension FlutterChannelEventBus: FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_channel_event_bus", binaryMessenger: registrar.messenger())
        let instance = FlutterChannelEventBus()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == Key.response.rawValue {
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}

public extension FlutterChannelEventBus {
    /// 数据获取到的回掉
    typealias FlutterChannelEventBusResponsehandle = (FlutterChannelEventBusResponse) -> Void
}

public extension FlutterChannelEventBus {
    func register<T>(register:T) {
        
    }
}
