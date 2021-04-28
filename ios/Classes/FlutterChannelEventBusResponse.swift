//
//  FlutterChannelEventBusResponse.swift
//  flutter_channel_event_bus
//
//  Created by 张行 on 2021/4/15.
//

import Foundation
/// 数据通道回掉参数
public struct FlutterChannelEventBusResponse {
    /// 回掉数据
    public let data:Any?
    /// 回掉的注册者
    public let register:FlutterChannelEventBusRegister
    /// 相应数据的回掉
    public let result:FlutterResult?
    /// 将数据转换成对应的模型
    /// - Returns: 转换的模型
    public func cover<T:Codable>() -> T? {
        guard let jsonText = self.data as? String, let data = jsonText.data(using: .utf8) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
