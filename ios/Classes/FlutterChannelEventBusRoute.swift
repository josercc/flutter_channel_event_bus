//
//  FlutterChannelEventBusRoute.swift
//  flutter_channel_event_bus
//
//  Created by 张行 on 2021/4/16.
//

import Foundation

/// 设置通信的路由
public class FlutterChannelEventBusRoute {
    /// 路由的名称
    public let name:String
    /// 默认路由
    public init() {
        self.name = "flutter_channel_event_bus_route"
    }
    /// 自定义路由
    public init(custom name:String) {
        self.name = name
    }
}
