//
//  FlutterChannelEventBusMixin.swift
//  flutter_channel_event_bus
//
//  Created by joser on 2021/6/3.
//

import Foundation

public protocol FlutterChannelEventBusMixin {
    
}

fileprivate struct FlutterChannelEventBusMixinKey {
    static var _eventBusRegisterIds = "_eventBusRegisterIds"
}

public extension FlutterChannelEventBusMixin {
    private var _eventBusRegisterIds:[String] {
        let ids = objc_getAssociatedObject(self,
                                           &FlutterChannelEventBusMixinKey._eventBusRegisterIds)
        return ids as? [String] ?? []
    }
    /// 释放当前所有的注册订阅
    func freeRegisterIds() {
        self._eventBusRegisterIds.forEach { element in
            FlutterChannelEventBus.default.deregister(event: element)
        }
    }
    
    
    /// 通过默认的路由进行注册订阅
    /// - Parameters:
    ///   - name: 注册的订阅名称
    ///   - handle: 注册订阅消息回掉
    /// - Returns: 注册的订阅ID
    func register(eventBus name:String,
                  handle:@escaping FlutterChannelEventBus.FlutterChannelEventBusResponsehandle) -> String {
        let registerId = FlutterChannelEventBus.default.register(event: name,
                                                                 handle: handle)
        append(eventBus: registerId)
        return registerId
    }
    
    /// 通过自定义的路由进行注册订阅
    /// - Parameters:
    ///   - name: 注册的订阅名称
    ///   - routeName: 自定义路由的名称
    ///   - handle:  注册订阅消息回掉
    /// - Returns: 注册的订阅ID
    func register(customEventBus name:String,
                  routeName:String,
                  handle:@escaping FlutterChannelEventBus.FlutterChannelEventBusResponsehandle) -> String {
        let registerId = FlutterChannelEventBus.default.register(event: name,
                                                                 route: .init(custom: routeName),
                                                                 handle: handle)
        append(eventBus: registerId)
        return registerId
    }
    
    /// 通过默认的路由发送一条订阅消息
    /// - Parameters:
    ///   - name: 订阅的名称
    ///   - data: 消息的内容
    ///   - result: 接收到回掉
    func send(eventBus name:String,
              data:Any? = nil,
              result:@escaping FlutterResult) {
        FlutterChannelEventBus.default.send(event: name,
                                            data: data,
                                            result: result)
    }
    
    /// 通过自定义的路由发送一条订阅消息
    /// - Parameters:
    ///   - name: 订阅的名称
    ///   - routeName: 自定义路由名称
    ///   - data: 消息的内容
    ///   - result: 接收到回掉
    func send(customEventBus name:String,
              routeName:String,
              data:Any? = nil,
              result:@escaping FlutterResult) {
        FlutterChannelEventBus.default.send(event: name,
                                            route: .init(custom: routeName),
                                            data: data,
                                            result: result)
    }
    
    private func append(eventBus id:String) {
        var ids:[String] = self._eventBusRegisterIds
        ids.append(id)
        objc_setAssociatedObject(self,
                                 &FlutterChannelEventBusMixinKey._eventBusRegisterIds,
                                 ids,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
