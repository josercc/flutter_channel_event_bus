package com.winner.flutter_channel_event_bus

import io.flutter.plugin.common.MethodChannel

/**
 * @author zhuhui
 * @date 2022/4/2
 * @description
 */
class FlutterChannelEventBusManager {
    var eventBusRegisterIds: MutableList<String> = mutableListOf()

    /**
     * 释放注册的通知
     */
    fun freeRegisters() {
        eventBusRegisterIds.forEach {
            FlutterChannelEventBus.instance.deregister(it)
        };
    }

    /**
     * 注册一个通用的通知
     * @param [name]注册的名称
     * @param [handle]消息回掉
     */
    fun register(name: String, handle: FlutterChannelEventBusResponseHandle): String {
        val route = FlutterChannelEventBusRoute()
        val registerId = FlutterChannelEventBus.instance.register(name, route, handle)
        eventBusRegisterIds.add(registerId);
        return registerId;
    }

    /**
     * 注册一个自定义的通知
     * @param [name]注册的名称
     * @param [routeName]自定义消息路由
     * @param [handle]消息回掉
     */
    fun register(
        name: String,
        routeName: String,
        handle: FlutterChannelEventBusResponseHandle
    ): String {
        val route = FlutterChannelEventBusRoute(routeName)
        val registerId = FlutterChannelEventBus.instance.register(name, route, handle)
        eventBusRegisterIds.add(registerId);
        return registerId;
    }


    /**
     * 通过默认的路由发送消息
     * @param [name]消息名称
     * @param [data]消息的数据
     * @param [result]接收到的回调
     */
    fun send(name: String, data: Any?, result: MethodChannel.Result?) {
        val route = FlutterChannelEventBusRoute()
        FlutterChannelEventBus.instance.send(name, route, data, result)
    }

    /**
     * 通过自定义的路由发送消息
     * @param [name]消息名称
     * @param [routeName]自定义路由名称
     * @param [data]消息的数据
     * @param [result]接收到的回调
     */
    fun sendCustom(name: String, routeName: String, data: Any?, result: MethodChannel.Result?) {
        val route = FlutterChannelEventBusRoute(routeName)
        return FlutterChannelEventBus.instance.send(name, route, data, result)
    }
}