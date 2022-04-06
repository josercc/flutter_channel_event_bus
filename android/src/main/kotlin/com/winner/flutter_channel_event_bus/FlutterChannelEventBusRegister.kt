package com.winner.flutter_channel_event_bus

/**
 * @author zhuhui
 * @date 2022/4/2
 * @description
 */
data class FlutterChannelEventBusRegister(
    var registerId: String,
    var route: FlutterChannelEventBusRoute,
    var handle: FlutterChannelEventBusResponseHandle,
    var methodName: String,

)