//
//  UpBitAPI.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import Foundation


struct UpBitAPI: Decodable {
    var market: String
    let change: String
    let changePrice: Double
    let changeRate: Double
    let trade: Double
    let accTrade: Double

    enum CodingKeys: String, CodingKey {
        case market
        case change
        case changePrice = "signed_change_price"
        case changeRate = "signed_change_rate"
        case trade = "trade_price"
        case accTrade = "acc_trade_price_24h"
    }

    /// 커스텀 디코딩
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        market = try container.decode(String.self, forKey: .market)
        change = try container.decode(String.self, forKey: .change)
        changePrice = try container.decode(Double.self, forKey: .changePrice)
        changeRate = try container.decode(Double.self, forKey: .changeRate)
        
        
        trade = try container.decodeIfPresent(Double.self, forKey: .trade) ?? 0.0
        
        accTrade = try container.decode(Double.self, forKey: .accTrade)
    }
}
