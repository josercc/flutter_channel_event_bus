package com.winner.flutter_channel_event_bus

import com.example.flutter_channel_json.FlutterChannelJson
import android.util.Log
import io.flutter.plugin.common.MethodChannel

/**
 * @author zhuhui
 * @date 2022/4/2
 * @description
 */
class FlutterChannelEventBus private constructor() {
    companion object {
        val instance = FlutterChannelEventBusHolder.holder
    }

    private object FlutterChannelEventBusHolder {
        val holder = FlutterChannelEventBus()
    }

    var registers: MutableList<FlutterChannelEventBusRegister> = mutableListOf();

    lateinit var methodChannel: MethodChannel

    /**
     * 注册消息接收
     * @param [name] 对应消息方法名称
     * @param [route] 消息处理的路由
     * @param [handle] 数据相应回掉
     * @return 注册消息接收的唯一ID
     */
    fun register(
        name: String,
        route: FlutterChannelEventBusRoute,
        handle: FlutterChannelEventBusResponseHandle
    ): String {
        val registerId = "flutter_channel_event_bus_${System.currentTimeMillis()}"
        registers.add(FlutterChannelEventBusRegister(registerId, route, handle, name));
        return registerId;
    }

    /**
     * 取消注册消息的接收
     * @param [registerId] 注册的唯一ID
     */
    fun deregister(registerId: String) {
        var first: FlutterChannelEventBusRegister? = registers.firstOrNull {
            it.registerId == registerId
        } ?: return
        registers.remove(first);
    }

    /**
     * 发送通道数据
     * @param [name] 发送的方法名称
     * @param [route] 发送数据的路由方式
     * @param [data] 发送的数据，数据必须是Map或者是List
     * @param [result] 响应的数据
     */
    fun send(
        name: String,
        route: FlutterChannelEventBusRoute,
        data: FlutterChannelJson<Any>?,
        result: MethodChannel.Result?
    ) {
        var methodName = callMethodName(name, route);
        val json = data?.toJsonString()?:""
        Log.d("TAG", "$name - send: $json")
        methodChannel.invokeMethod(methodName, json, result);
    }

    /**
     * 获取真正传输的方法名称
     * @param name 设置的传输方法名称
     * @param route 设置的传输路由
     * @return 真正的传输方法名称
     */
    fun callMethodName(name: String, route: FlutterChannelEventBusRoute): String {
        return "${route.name}_$name";
    }

}

typealias FlutterChannelEventBusResponseHandle = (FlutterChannelEventBusResponse) -> Unit