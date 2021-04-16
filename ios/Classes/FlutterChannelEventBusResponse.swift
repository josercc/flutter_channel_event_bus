//
//  FlutterChannelEventBusResponse.swift
//  flutter_channel_event_bus
//
//  Created by 张行 on 2021/4/15.
//

import Foundation

public struct FlutterChannelEventBusResponse {
    let data:Any?
    
    /// 将数据转换成对应的模型
    /// - Returns: 转换的模型
    public func cover<T:Codable>() -> T? {
        guard let data = self.data else {
            return nil
        }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: jsonData)
    }
}
