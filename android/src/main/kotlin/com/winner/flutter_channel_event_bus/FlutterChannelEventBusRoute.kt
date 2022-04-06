package com.winner.flutter_channel_event_bus

/**
 * @author zhuhui
 * @date 2022/4/2
 * @description
 */
class FlutterChannelEventBusRoute {

    // 路由的名称
    var name: String = ""

    // 通用的路由
    constructor() {
        name = "flutter_channel_event_bus_route";
    }

    // 设置指定的路由
    constructor(name: String) {
        this.name = name;
    }

}