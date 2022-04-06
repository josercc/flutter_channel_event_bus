package com.winner.flutter_channel_event_bus

import com.google.gson.Gson
import io.flutter.plugin.common.MethodChannel

/**
 * @author zhuhui
 * @date 2022/4/2
 * @description
 */
data class FlutterChannelEventBusResponse(
    val data: Any?,
    val register: FlutterChannelEventBusRegister,
    val result: MethodChannel.Result?
) {

    fun getMap(): Map<String, Any> {
        return Gson().fromJson<Map<String, Any>>(data.toString(), Map::class.java)
    }
}