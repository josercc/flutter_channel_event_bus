//
//  SwiftFlutterChannelEventBus.swift
//  flutter_channel_event_bus
//
//  Created by 张行 on 2021/4/16.
//

import Foundation
import Flutter
public class SwiftFlutterChannelEventBus:NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_channel_event_bus", binaryMessenger: registrar.messenger())
        FlutterChannelEventBus.default.methodChannel = channel
        let instance = SwiftFlutterChannelEventBus()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let registers:[FlutterChannelEventBusRegister] = FlutterChannelEventBus.default.registers.compactMap({FlutterChannelEventBus.default.callMethodName(name: $0.name, route: $0.route) == call.method ? $0 : nil})
        if registers.count > 0 {
            for element in registers.enumerated() {
                if element.offset == 0 {
                    element.element.handle(FlutterChannelEventBusResponse(data: call.arguments, register: element.element, result: result))
                } else {
                    element.element.handle(FlutterChannelEventBusResponse(data: call.arguments, register: element.element, result: nil))
                }
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
