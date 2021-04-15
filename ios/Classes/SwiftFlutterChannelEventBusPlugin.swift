import Flutter
import UIKit

public class SwiftFlutterChannelEventBusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_channel_event_bus", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterChannelEventBusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
