//
//  FlutterChannelEventBusRegister.swift
//  flutter_channel_event_bus
//
//  Created by 张行 on 2021/4/15.
//

import Foundation
/// 消息注册
public struct FlutterChannelEventBusRegister {
    /// 注册唯一ID
    public let registerId:String
    /// 注册的方法名称
    public let name:String
    /// 注册的路由方式
    public let route:FlutterChannelEventBusRoute
    /// 注册的回掉
    public let handle:FlutterChannelEventBus.FlutterChannelEventBusResponsehandle
}

