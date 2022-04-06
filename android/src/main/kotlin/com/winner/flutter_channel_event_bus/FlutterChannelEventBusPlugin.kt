package com.winner.flutter_channel_event_bus

import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterChannelEventBusPlugin */
class FlutterChannelEventBusPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_channel_event_bus")
        FlutterChannelEventBus.instance.methodChannel = channel
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        Log.d("FlutterChannelEvent", call.method)
        val registers = FlutterChannelEventBus.instance.registers.filter {
            FlutterChannelEventBus.instance.callMethodName(it.methodName, it.route) == call.method
        }
        if (registers.isNotEmpty()) {
            registers.forEachIndexed { index, element ->
                if (index == 0) {
                    element.handle(FlutterChannelEventBusResponse(call.arguments, element, result))
                } else {
                    element.handle(FlutterChannelEventBusResponse(call.arguments, element, null))
                }
            }
        } else {
            throw IllegalAccessException("${call.method}不支持")
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}